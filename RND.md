# DÉPARTEMENT R&D — couplé à la Distribution

Mission : garder une longueur d'avance. La distribution EXÉCUTE ; la R&D trouve QUOI exécuter ensuite
(formats, canaux, tactiques, produits) et le PROUVE avant de le passer en prod. Boucle fermée avec DISTRIBUTION.md.

## Le couplage R&D ↔ Distribution (la règle centrale)
- R&D produit des **paris testables** (hypothèse + prototype/preuve + comment mesurer) → poussés dans `rnd/EXPERIMENTS.md`.
- La Distribution EXÉCUTE le pari, colle l'UTM/analytics, et écrit le RÉSULTAT dans `rnd/EXPERIMENTS.md`.
- R&D lit les résultats, tue ce qui échoue, double ce qui marche. Rien n'entre en prod sans hypothèse + métrique.
- Contexte partagé : DECISIONS/distribution.md (ce qui tourne), distro-dept/* (canaux), STATE.md.

## Spécialistes (chacun : recherche datée 2026 + PROTOTYPE/preuve réelle, pas que du texte + reco actionnable)
- **RND-VIDEO** — pipeline vidéo agent-operable (Remotion React→vidéo vs alternatives ffmpeg / capture HTML). Monter un rendu
  MINIMAL qui marche + 1 clip promo échantillon. Débloque pins vidéo / Shorts / X natif (moins pénalisés que les liens).
- **RND-EXPERIMENTS** — framework de mesure + backlog d'expériences priorisées (hooks, prix, styles de pin, angles) + le fichier
  `rnd/EXPERIMENTS.md` (backlog+résultats) que la distro met à jour. Définit la métrique nord + seuils kill/scale.
- **RND-EMERGING** — scoute les canaux/tactiques/tendances 2026 ÉMERGENTS pour produits numériques indie (au-delà de DISTRO) :
  ce qui marche MAINTENANT, validé par preuves, classé en expériences.
- **RND-PRODUCT** — prochains produits intrinsèquement DISTRIBUABLES (validés par la demande) pour élargir le catalogue ;
  classe par (demande × shareabilité × effort).

## Livrable → rnd/<NOM>.md + résumé bus/broadcast/<NOM>.md + paris ajoutés à rnd/EXPERIMENTS.md
