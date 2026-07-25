#!/usr/bin/env bash
# measure.sh — lit Vercel Web Analytics du store en CLI, sans navigateur. Sortie JSON sur stdout.
#
#   tools/measure.sh                 # fenêtre 24h
#   tools/measure.sh --window 1h     # 15m | 30m | 1h | 6h | 24h | 7d | 30d
#   tools/measure.sh --window 7d --project 1h-money-store
#
# Auth : Bearer VERCEL_TOKEN (env, sinon lu dans SECRETS.local). Pas de cookie, pas de session.
# Endpoint : https://api.vercel.com/web-analytics/v2/{overview,stats,realtime}  (le "v2" est la clé —
# toutes les variantes sans v2 renvoient 404). Voir distro-dept/measure-cli-2026-07-25.md.
set -uo pipefail

API="https://api.vercel.com/web-analytics/v2"
TEAM_ID="team_eddVPHfYYUKbK3I7n2hCPYWf"   # deeployo (≠ team_v453... = parwebs-projects, qui 404)
PROJECT="1h-money-store"
WINDOW="24h"
LIMIT=25

while [ $# -gt 0 ]; do
  case "$1" in
    --window)  WINDOW="$2"; shift 2 ;;
    --project) PROJECT="$2"; shift 2 ;;
    --team)    TEAM_ID="$2"; shift 2 ;;
    --limit)   LIMIT="$2"; shift 2 ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [ -z "${VERCEL_TOKEN:-}" ]; then
  for f in "$(dirname "$0")/../SECRETS.local" "$PWD/SECRETS.local"; do
    [ -f "$f" ] && VERCEL_TOKEN=$(grep -m1 '^VERCEL_TOKEN=' "$f" | cut -d= -f2-) && break
  done
fi
if [ -z "${VERCEL_TOKEN:-}" ]; then
  echo '{"error":"VERCEL_TOKEN absent (env ou SECRETS.local)"}' ; exit 1
fi

# --- fenêtre -> bornes ISO UTC (compatible date BSD/macOS et GNU/Actions) ---
case "$WINDOW" in
  15m) SECS=900 ;; 30m) SECS=1800 ;; 1h) SECS=3600 ;; 6h) SECS=21600 ;;
  24h) SECS=86400 ;; 7d) SECS=604800 ;; 30d) SECS=2592000 ;;
  *) echo "{\"error\":\"window invalide: $WINDOW (15m|30m|1h|6h|24h|7d|30d)\"}"; exit 2 ;;
esac
NOW=$(date -u +%s)
iso() { date -u -r "$1" '+%Y-%m-%dT%H:%M:%S.000Z' 2>/dev/null || date -u -d "@$1" '+%Y-%m-%dT%H:%M:%S.000Z'; }
FROM=$(iso $((NOW - SECS)))
TO=$(iso "$NOW")

Q="environment=production&filter=%7B%7D&from=$FROM&to=$TO&projectId=$PROJECT&teamId=$TEAM_ID&tz=UTC"
get() { curl -sS --max-time 25 -H "Authorization: Bearer $VERCEL_TOKEN" "$API/$1"; }

OVERVIEW=$(get "overview?$Q")
if ! printf '%s' "$OVERVIEW" | jq -e '.total' >/dev/null 2>&1; then
  printf '{"error":"overview illisible","raw":%s}\n' "$(printf '%s' "$OVERVIEW" | jq -Rs . 2>/dev/null || echo '""')"
  exit 1
fi

REALTIME=$(get "realtime?environment=production&projectId=$PROJECT&teamId=$TEAM_ID&tz=UTC")
PATHS=$(get     "stats?$Q&limit=$LIMIT&type=path")
REFERRERS=$(get "stats?$Q&limit=$LIMIT&type=referrer")
COUNTRIES=$(get "stats?$Q&limit=$LIMIT&type=country")
DEVICES=$(get   "stats?$Q&limit=$LIMIT&type=device_type")
UTM_SRC=$(get   "stats?$Q&limit=$LIMIT&type=query_params&jsonProperty=utm_source")
UTM_CMP=$(get   "stats?$Q&limit=$LIMIT&type=query_params&jsonProperty=utm_campaign")

# .data peut manquer si un sous-appel échoue -> on retombe sur [] plutôt que de casser la sortie.
d() { printf '%s' "$1" | jq -c '.data // []' 2>/dev/null || echo '[]'; }

jq -n \
  --argjson ov "$OVERVIEW" \
  --argjson rt "$(printf '%s' "$REALTIME" | jq -c '{total,devices}' 2>/dev/null || echo 'null')" \
  --argjson paths "$(d "$PATHS")" \
  --argjson referrers "$(d "$REFERRERS")" \
  --argjson countries "$(d "$COUNTRIES")" \
  --argjson devices "$(d "$DEVICES")" \
  --argjson utm_sources "$(d "$UTM_SRC")" \
  --argjson utm_campaigns "$(d "$UTM_CMP")" \
  --arg window "$WINDOW" --arg from "$FROM" --arg to "$TO" --arg project "$PROJECT" \
  '{
    ts: (now | todate),
    project: $project,
    window: $window, from: $from, to: $to,
    visitors: $ov.devices, pageviews: $ov.total,
    realtime_30m: (if $rt then {visitors: $rt.devices, pageviews: $rt.total} else null end),
    top_paths:     [$paths[]     | {path: .key,     views: .total, visitors: .devices}],
    referrers:     [$referrers[] | {referrer: .key, views: .total, visitors: .devices}],
    utm_sources:   [$utm_sources[]   | {source: .key,   views: .total, visitors: .devices}],
    utm_campaigns: [$utm_campaigns[] | {campaign: .key, views: .total, visitors: .devices}],
    countries:     [$countries[]  | {country: .key, views: .total, visitors: .devices}],
    devices:       [$devices[]    | {device: .key,  views: .total, visitors: .devices}]
  }'
