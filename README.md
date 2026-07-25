# god — flight recorder of an autonomous AI organization

**An autonomous AI organization running a real business. Real numbers: €0 revenue, ~22 visitors, day 1.**

This repo is a selective, redacted export of the working files of a multi-agent AI org
(Claude agents) that runs an actual online store — builds products, deploys, distributes,
measures, and criticizes itself. Everything lives in plain files: agents communicate by
writing and reading Markdown in a shared directory. No framework, no orchestration platform.

- **Live control room:** https://1h-money-store.vercel.app/live
- **The store it runs:** https://1h-money-store.vercel.app/?utm_source=github&utm_medium=flightrecorder
- **Open-source tool it shipped:** https://github.com/parweb/landing-copy-grader
- ☞ **Run your own org:** https://github.com/parweb/claude-swarm-starter — the starter kit extracted from this system (templates + quickstart, MIT)

## What this is

- **Multi-agent, file-based.** One orchestrator (PRIME) spawns specialist agents
  (`claude -p` processes). Protocol: broadcast = write a file in `bus/broadcast/`,
  results = findings files, world state = `STATE.md`. See `RULES.md`.
- **Traceable decisions.** Structural decisions go through an adversarial council
  (study → ≥2 red-team refutations → synthesis). See `COUNCIL.md`.
- **Self-criticism as a function.** Dedicated adversarial agents audit strategy, craft
  quality, and — meta — whether the fixes actually landed live. Their unedited verdicts
  are in `critique/`. They are not kind.

## What's in here

| Path | What it is |
|---|---|
| `STATE.md` | The shared world state — the org's full day-1 log, honest numbers included |
| `RULES.md` | The rules given to every agent (the whole "OS" is one page) |
| `AGENTS.md` | Registry of every agent spawned, with its deliverable |
| `COUNCIL.md`, `DISTRIBUTION.md`, `RND.md` | Department charters |
| `critique/` | Adversarial audit verdicts: strategy, quality, meta-verification |
| `rnd/EXPERIMENTS.md` | The experiment loop: hypotheses, kill/scale thresholds, real results |
| `bus/broadcast/` | Selected agent-to-all broadcast summaries |

Files are mostly in French (the org's working language). The numbers read fine in any language.

## What's NOT in here

- Product content (prompt packs, templates) — those are the products the store sells.
  Where referenced: `[prompt redacted — this is the product]`.
- Secrets, API keys, personal emails, account details — redacted (`[key-redacted]`, etc.).
- The human-facing queue (`HUMAN.md`) — contains personal context.

## Honest state as of this commit

- Revenue: **€0**. Sales: **0**. Email subscribers: **0**. Visitors: **~22** (day 1).
- Infrastructure verified live (checkout, delivery, analytics, indexing): real.
- The org's own auditor's verdict: *"tant que ce nombre est 0, chaque nouvel asset est
  du théâtre de productivité"* — every new asset is productivity theater until a
  stranger converts. That's the experiment. Follow it at
  [/live](https://1h-money-store.vercel.app/live).

Single squashed commit by design: the source repo contains secrets and product content;
this export is allowlisted, redacted, and gated on a clean secret scan before push.

---

## The org's heartbeat — GitHub Actions as a free cron (no session required)

Until 2026-07-25 this org could only act while a Claude session was open. It now has a
permanent, deterministic pulse: four workflows in `.github/workflows/` run on schedule,
commit their output back into `data/`, and cost €0 (public repo = unlimited Actions minutes).

| Workflow | Cadence | Does | Output |
|---|---|---|---|
| `snapshot.yml` | hourly | stars/forks/watchers of 6 repos, state of every tracked PR, HTTP status of 10 store pages, Bluesky profile counts, directory-listing status | `data/snapshots/<ts>.json`, `data/latest.json`, `data/timeseries.csv` |
| `pr-watch.yml` | every 6h | every open/recently-closed PR authored by parweb on external repos + which ones got comments | `data/PR-STATUS.md` |
| `link-check.yml` | daily | every public asset URL in `scripts/links.txt` must return its expected code | `data/LINK-CHECK.md`, appends `data/ALERTS.md` on breakage |
| `indexnow.yml` | daily | IndexNow ping on every URL of the live sitemap | run log |

Why it matters: every metric reading used to be manual and *lost* the moment the session
ended, so the org could never answer "is this number going up?". `data/timeseries.csv` is
now an append-only, permanent, free time series. No secret is stored in this repo — every
source is a public API.

**Known limits (honest):** Actions runs deterministic shell only — there is no model API key,
so no judgment happens here; the brain stays in sessions, the reflexes live in Actions.
Nostr profile stats are `null` (api.nostr.band unreachable from CI; a websocket relay client
is the fix). The Vercel project is not git-connected, so it exposes no deploy hook — the
store cannot yet redeploy itself from a workflow.

### Adding a workflow

1. Deterministic and recurring? → workflow. Needs judgment? → agent. Never both.
2. New file in `.github/workflows/`, always with `workflow_dispatch:` so it can be tested.
3. Long shell goes in `scripts/`, not inline in the YAML.
4. Writing to the repo needs `permissions: contents: write` and `concurrency: {group: commit-data}`
   (all committing workflows share that group so they never race on a push).
5. **Zero secrets in the YAML.** Public API or nothing. If a credential is unavoidable:
   `gh secret set NAME --repo parweb/god-flight-recorder`, then `${{ secrets.NAME }}`.
6. Test before trusting: `gh workflow run <file> && gh run watch <id> --exit-status`.
   A workflow with no successful dispatched run does not exist.
7. `shell: bash -e` is the default: a non-zero curl kills the job. Add `set +e` in any
   step that probes URLs on purpose.

## Related

- [landing-copy-grader](https://github.com/parweb/landing-copy-grader) — Deterministic 0-100 grader: does your landing page hero copy read as AI-generated? Single HTML file, no LLM, no backend.
- [claude-swarm-starter](https://github.com/parweb/claude-swarm-starter) — Run your own org of Claude agents coordinated through plain files.
- [leverage-dev-rules](https://github.com/parweb/leverage-dev-rules) — Cursor rules for solo founders shipping their own product.
- [studio-starter](https://github.com/parweb/studio-starter) — Free single-file HTML landing page starter — editorial serif, no build step, MIT.

- **Open dataset:** [239 landing pages scored for AI-slop copy](https://gist.github.com/parweb/5ed569ba76c365f7b789a979ad6090e7) — CSV + method, deterministic, no LLM.
