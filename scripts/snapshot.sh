#!/usr/bin/env bash
# Capture des métriques publiques de l'org. Aucun secret requis.
# Sortie: JSON sur stdout.
set -uo pipefail

REPOS="parweb/mcp-ai-slop-checker parweb/landing-copy-grader parweb/claude-swarm-starter parweb/leverage-dev-rules parweb/studio-starter parweb/god-flight-recorder"
PRS="punkpeye/awesome-mcp-servers#10875 steven2358/awesome-generative-ai#1112 e2b-dev/awesome-ai-agents#1306 dalisoft/awesome-ai-coding#81 nibzard/awesome-agentic-patterns#120 TensorBlock/awesome-mcp-servers#1380 preetmishra/awesome-bootstrapped-software#18 GetBindu/awesome-claude-code-and-skills#129"
STORE="https://1h-money-store.vercel.app"
PAGES="/ /sounds-ai /grader /live /leaderboard /operator /affiliate /free /tools /compare"
BSKY_HANDLE="parweb.bsky.social"
NPUB="npub1htrdcxp9gvdgjxxy8lzweqpa8h0s98f7g4zvhldgm7aw7k8nywcstw7wpx"
WHATTHEAI="https://whattheai.tech/tools/does-my-text-sound-ai"

api() { curl -sS -m 20 -H "Accept: application/vnd.github+json" ${GITHUB_TOKEN:+-H "Authorization: Bearer $GITHUB_TOKEN"} "https://api.github.com/$1"; }

repos_json="{}"
for r in $REPOS; do
  j=$(api "repos/$r")
  repos_json=$(jq -c --arg k "$r" --argjson v "$(echo "$j" | jq -c '{stars:(.stargazers_count//null),forks:(.forks_count//null),watchers:(.subscribers_count//null),issues:(.open_issues_count//null)}')" '. + {($k):$v}' <<<"$repos_json")
done

prs_json="{}"
for p in $PRS; do
  repo="${p%%#*}"; num="${p##*#}"
  j=$(api "repos/$repo/pulls/$num")
  prs_json=$(jq -c --arg k "$p" --argjson v "$(echo "$j" | jq -c '{state:(.state//"unknown"),merged:(if has("merged") then .merged else null end),comments:(.comments//null),updated_at:(.updated_at//null)}')" '. + {($k):$v}' <<<"$prs_json")
done

pages_json="{}"
for u in $PAGES; do
  code=$(curl -sS -o /dev/null -m 20 -w '%{http_code}' "$STORE$u" || echo 000)
  pages_json=$(jq -c --arg k "$u" --argjson v "$code" '. + {($k):$v}' <<<"$pages_json")
done

bsky=$(curl -sS -m 20 "https://public.api.bsky.app/xrpc/app.bsky.actor.getProfile?actor=$BSKY_HANDLE" \
  | jq -c '{followers:(.followersCount//null),follows:(.followsCount//null),posts:(.postsCount//null)}' 2>/dev/null || echo 'null')

nostr=$(curl -sS -m 10 "https://api.nostr.band/v0/stats/profile/$NPUB" \
  | jq -c --arg n "$NPUB" '(.stats[$n]//{}) | {followers:(.followers_pubkey_count//null),notes:(.pub_note_count//null),zaps:(.zapped_msats//null)}' 2>/dev/null || echo 'null')

wta=$(curl -sS -o /dev/null -m 20 -w '%{http_code}' "$WHATTHEAI" || echo 000)

jq -n --arg ts "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
      --argjson repos "$repos_json" --argjson prs "$prs_json" --argjson pages "$pages_json" \
      --argjson bsky "${bsky:-null}" --argjson nostr "${nostr:-null}" --argjson wta "$wta" \
  '{ts:$ts, repos:$repos, prs:$prs, pages:$pages, bluesky:$bsky, nostr:$nostr, whattheai_listing_http:$wta}'
