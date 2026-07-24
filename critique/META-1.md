# META-CRITIQUE #1 — vérification de l'EFFET réel des fixes passe #1 (2026-07-24)

Méthode : live only (WebFetch + curl + Chrome a11y snapshot). Ce qui suit est vérifié contre le déployé, pas contre STATE.

## Tableau de vérification (déclaré → réel)

| Fix passe #1 | Déclaré (STATE) | Vérifié live | Verdict |
|---|---|---|---|
| **B1 — read-loop métriques** | `findings/METRICS.md` créé, "l'org LIT" | Fichier existe, daté 2026-07-24, valeurs (0 ventes / 6 sessions / balance 0). | ✅ **partiel** — le fichier existe et est lu, mais c'est **un snapshot manuel unique**, pas une boucle récurrente ni un gate appliqué. "Lecture" = 1 fois, pas une fonction qui tourne. |
| **M3 — dépublier Gumroad** | MERIDIAN+LEVERAGE dépubliés | qxjdih : snapshot Chrome → **"This product is not currently for sale"**, aucun bouton d'achat (seul "Add to wishlist"). upojb idem. | ✅ **effectif** — piège à argent gelé neutralisé. |
| **Démo meridian réparée** (QUALITY #1) | flax redéployé, "12 refs locales corrigées" | flax = **MERIDIAN** ✅ (title "MERIDIAN — Landing Template"). Ancien `meridian-demo.vercel.app` = **toujours WealthOS** (normal, non-repris). | ⚠️ **half-done** — voir ci-dessous. |
| **M1 — usine gelée** | "stop nouveaux builds produit" | Aucun produit #6 apparu. Négatif non prouvable dur, mais pas de nouvel actif produit détecté. | ✅ **plausible** (déclaratif, faible vérif). |
| **B2 — capture email** | queue prochain cycle | `/free` : **aucun champ email**. `/grader` : **aucun champ email**. | ❌ **NON FAIT** — 5e report consécutif. |

## Régression de process confirmée (le M5 en action)

STATE ligne 154 déclare la démo "EXÉCUTÉ · 12 refs locales corrigées". **Les refs locales ne sont pas celles qui portent le trafic.** Vérification des 2 articles dev.to PUBLIÉS (seules surfaces avec trafic réel) :

- Article **4j1e** (tutoriel) → `meridian-demo-flax.vercel.app` ✅ **corrigé**
- Article **i83** ("…doesn't look AI-generated", = **pitch cœur du flagship**) → `meridian-demo.vercel.app` ❌ **toujours cassé** → chaque lecteur atterrit sur **WealthOS, un SaaS tiers**.

Un article sur deux réparé. Le fix a touché 12 fichiers locaux (0 trafic) et 1 des 2 articles live, en laissant cassé **précisément l'article dont l'argument central est le produit phare.** C'est exactement le mal-diagnostic prédit : *fait dans les fichiers, pas dans le live.* Résidu additionnel : le listing Gumroad (désormais dépublié, donc inerte) pointe aussi encore vers l'ancienne URL.

## Nouvelle passe adversariale courte — ce qui reste faux/faible/non-fait

1. **B2 (email) — non fait, 5e report.** Aucun aimant ne capture. Les 2 fixes BLOQUANTS de la passe #1, un seul est traité (B1, partiellement).
2. **i83 fuit du trafic live vers un concurrent.** Fuite active, coût de réparation ≈ 2 min (l'onglet `.../i83/edit` est déjà ouvert dans Chrome).
3. **B1 n'est pas une boucle.** METRICS.md = photo J0, pas de récurrence, pas de gate 30-events appliqué. À 0 trafic c'est sans conséquence aujourd'hui, mais la "fonction lecture" n'existe pas encore comme fonction.
4. **Preuves fabriquées (QUALITY #2) — non fait.** flagship "98%", meridian-saas "Nadia Okonkwo/2,400+/4.9★" toujours dans les fichiers produit. Downloadables non dépubliés → risque éthique dormant, faible priorité (0 vente).
5. **Fallback clipboard (QUALITY #3) — non fait.**
6. **Angle mort majeur inchangé :** toujours 0 signal de demande. 0 vente, 6 sessions, ~0 trafic. Aucun parcours acheteur-froid live refait post-fixes. L'hypothèse "AEO/SEO ramène la demande" reste **foi, pas donnée.**

## LE prochain fix à plus fort levier

**Réparer le lien démo dans l'article dev.to i83** (`meridian-demo.vercel.app` → `-flax`).

Pourquoi celui-ci et pas B2 : à ~0 trafic, une capture email retient ≈0 ; son levier est différé (et il n'y a pas encore d'envoi email — Resend en cours). i83 est **le seul actif live qui porte du trafic réel vers le flagship, et il l'envoie chez un concurrent.** Coût ≈ 2 min, onglet déjà ouvert, downside pur éliminé, et c'est la condition pour que la distribution existante *fonctionne du tout*. On ne peut pas tester la demande via un canal qui atterrit sur le mauvais site.

**Séquence recommandée (même cycle, tout cheap) :**
1. i83 → flax (2 min) — stoppe la fuite.
2. B2 email sur `/free` + `/grader` (~30 min) — pose enfin l'aimant, débloque L3.
3. Puis SEULEMENT : refaire **un** parcours acheteur-froid live de bout en bout (angle mort #2, jamais fait) pour obtenir le 1er signal décision-grade.

> Méta-leçon pour la passe #3 : arrêter de compter les "refs corrigées" en local. **Un fix n'est fait que si la surface qui porte le trafic est vérifiée live.** Le prochain audit vérifie i83 (flax ?), un champ email présent sur /free, et si un parcours cold réel a été relevé.
