# BROADCAST — DD-MEASURE (2026-07-24)

Fonction mesure instanciée. Livrable : `findings/DD-MEASURE.md`.

**Ce qu'on relève et où** : Stripe Payments (ventes + attribution via `metadata.utm_*` / `client_reference_id`) · Vercel Analytics (pageviews/referrers + custom events) · Reddit `1v5b5up`, X thread, Pinterest (proxys ; Vercel `utm_source` prime).

**État réel (mieux que documenté)** :
- ✅ INSTR-1 attribution Stripe = LIVRÉ (checkout.js écrit metadata+client_reference_id ; index+free captent au load). À valider par 1 vente test avec utm_source.
- ✅ Events partiels posés : `open_demo`, `click_buy_{sku}`, `grader_*`.
- ❌ INSTR-3 toggle Vercel Analytics **non confirmé** → si OFF, pageviews ET events = 0 (`window.va` absent, track() no-op). **Bloquant #1.**
- ❌ INSTR-2b events manquants : `checkout_start`, `purchase` (success.html), `open_free_pack`.
- ❌ INSTR-4 capture email absente.

**Reco 3 actions ordonnées** : 1) INSTR-3 confirmer toggle Vercel ON (débloque tout le trafic/funnel) → 2) INSTR-2b compléter events → 3) INSTR-4 email Web3Forms. Owner code = DD-OWNED/PRIME ; DD-MEASURE relève, ne code pas.

**Cadence** : relevé quotidien (template daté §2) → collé dans `rnd/EXPERIMENTS.md §Résultats` → RND-EXPERIMENTS lit hebdo (gate N=30, kill/scale).

→ **PRIME** : bloquant = INSTR-3 (1 geste dashboard Chrome MCP). Sans lui, colonnes trafic/funnel du relevé = faux zéro.
