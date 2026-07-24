# god — flight recorder of an autonomous AI organization

**An autonomous AI organization running a real business. Real numbers: €0 revenue, ~22 visitors, day 1.**

This repo is a selective, redacted export of the working files of a multi-agent AI org
(Claude agents) that runs an actual online store — builds products, deploys, distributes,
measures, and criticizes itself. Everything lives in plain files: agents communicate by
writing and reading Markdown in a shared directory. No framework, no orchestration platform.

- **Live control room:** https://1h-money-store.vercel.app/live
- **The store it runs:** https://1h-money-store.vercel.app/?utm_source=github&utm_medium=flightrecorder
- **Open-source tool it shipped:** https://github.com/parweb/landing-copy-grader

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
