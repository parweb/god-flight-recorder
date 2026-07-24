# QUALITY — audit soir 2026-07-24

Périmètre: subject-line-scorer, OSS grader repo, schema JSON-LD, viral share loop grader, cohérence.

## Défauts RÉELS trouvés + corrigés

1. **README OSS landing-copy-grader — taille fausse** → "One HTML file, ~19 KB" alors que grader.html = 14740 o (14.4 KB).
   - Fix: "~19 KB" → "~15 KB". Commit 1730b89 pushé sur main.
   - Vérif: `raw.githubusercontent.com/.../README.md` renvoie "~15 KB". ✅

## Vérifié SAIN (aucun défaut)

- **subject-line-scorer scoring**: testé 10 cas limites (vide, "x", ALL CAPS, pile emoji, "FREE!!! $$$ ACT NOW WINNER"→30, "Cut churn 30% in 14 days"→80, "[First name]…"→88, 200 chars, "50% off limited time act now!!!"→50). Aucune erreur JS, scores défendables, dimensions somment à 100. Disclaimer "not a guarantee" présent. Live == local (score() identique).
- **README examples**: grade() exécuté en node → Example1=32, Example2=100, MATCH exact des chiffres cités. grade() = 40 lignes (README dit ~40). ✅
- **Standalone file://**: seuls appels réseau = 2 preconnect + 1 stylesheet Google Fonts, fallback system serif/mono (font-family). grade()/run() zéro réseau. Offline OK, conforme README.
- **Schema JSON-LD**: Product ×2 (/), WebApplication ×2 (/grader, /tools/subject-line-scorer). Types + champs valides schema.org, aucune propriété inventée, prix cohérents (17/19 €).
- **Viral share loops** (grader + subject): texte conditionnel score≥60 correct, ego-positif dans les 2 branches, UTM corrects (utm_source=grader-share/subject-share&utm_medium=viral&utm_campaign=result).
- **Cohérence liens/prix**: tous endpoints live 200 (/ /grader /tools /tools/* /free /faq). Cross-sell → vraies URLs. SKUs (meridian/leverage/bundle) présents dans _assets.js, prix alignés (1700/1900/3200). Sitemap inclut subject-line-scorer.
- **"Featured on" homepage**: substantié par vraies soumissions confirmées (Launching Next ID 142021, Startup Project/Twelve Tools/Wired Business "submitted"). Pas de fausse stat/faux avis.

## Bilan
1 défaut réel (README OSS) trouvé + corrigé + vérifié. Reste = sain. Aucune fausse stat détectée.
