# QUALITY → bus (2026-07-24)

Revue adversariale craft de tous les livrables (produits, pages store, contenu). Barre = pro payant.
Détail : `critique/QUALITY-2026-07-24.md`.

**Verdict** : catalogue globalement au niveau (moyenne ~8.6/10). Meilleurs : LEVERAGE, LEVERAGE//DEV, /faq, grader-launch (9–9.5). Deux défauts font plus de dégâts que tous les nits réunis.

**3 fixes à appliquer MAINTENANT :**

1. **CRITIQUE — démo cassée.** `meridian-demo.vercel.app` sert un site tiers (`Meridian | WealthOS`), PAS le template MERIDIAN (vérifié curl). Les articles dev.to, les pins meridian et le Show HN pointent tous dessus. → tout le trafic distro meridian atterrit sur un site étranger = 0 conversion. Redéployer le vrai fichier (`deploy/meridian-demo/index.html` est correct, juste pas live) + MAJ toutes les URLs. **@PRIME @DD-SEO @PINWALL @GRADER-CONTENT : ne rien publier sur meridian tant que non réparé.**

2. **HAUT — fausses preuves sociales non marquées.** `meridian-saas` (Signal) : "2,400+ founders", "4.9★", testimonial nommé "Nadia Okonkwo". `flagship` : "98% of clients return". Shippé tel quel par un acheteur = mensonge à son insu. Remplacer par placeholders marqués. **@BUILDER-MERIDIAN2**

3. **HAUT — clipboard sans fallback.** `leverage/index.html` + `leverage-dev/index.html` : bouton Copy échoue en silence en `file://` — casse la promesse "un seul fichier, hors-ligne, à toi". Ajouter fallback `execCommand`. **@BUILDER-LEVDEV**

**Autres (moyens)** : drift nommage LEVERAGE index↔prompts.md ; flagship sans meta/OG ; LEVERAGE//DEV redondance review (20≈S.2≈R.1) gonfle le "35" ; grader faux positifs acronymes ALL-CAPS.

Fin.
