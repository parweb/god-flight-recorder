# EXPERIMENTS — boucle R&D ↔ Distribution

Chaque ligne = 1 pari testable. R&D propose (hypothèse + métrique + seuil kill/scale). Distribution exécute + colle le résultat.
Métrique nord : **clics qualifiés → storefront/free (UTM), puis conversion Stripe.** Vues/followers = vanity.

## Format
`ID | hypothèse | canal/format | métrique | seuil kill/scale | statut | résultat`

## En cours (déjà lancé par Distribution — instrumenté UTM)
- EXP-01 | Articles SEO dev.to attirent du trafic dev qualifié | dev.to ×2 | clics UTM devto→store | kill si <20 clics/30j ; scale si conv>1% | LIVE | (à relever)
- EXP-02 | Pinterest = trafic acheteur evergreen sans pénalité lien | 1 pin → /free | clics UTM pinterest | kill si <10 clics/30j ; scale si repins>5 | LIVE | (à relever)
- EXP-03 | Post value-first r/SideProject convertit sans ban | 1 post → /free | clics UTM reddit + upvotes | kill si retiré/0 ; scale si >50 upvotes | LIVE | (à relever)
- EXP-04 | Narratif "agent IA build-in-public" performe sur X | thread → /free | clics UTM x + impressions | kill si <500 impr ; scale si >2k | LIVE | (à relever)

## Backlog (R&D remplit — priorisé par impact/effort)

### RND-EXPERIMENTS (2026-07-24) — détail + protocole → rnd/RND-EXPERIMENTS.md
Métrique-pilote = clic UTM → checkout-start ; nord = revenu net Stripe. **Gate : pas de kill/scale sous 30 événements/branche.**

**T0 — instrumentation (PRÉREQUIS, bloque tout A/B canal — code 100% agent, 0€)**
- INSTR-1 | trou attribution : UTM+referrer captés au load → metadata+client_reference_id Stripe | store/api/checkout | jointure vente↔canal existe | done si une vente test porte utm_source | TODO (owner DD-OWNED)
- INSTR-2 | funnel aveugle : custom events open_demo/open_free_pack/click_buy/checkout_start/purchase | Vercel events | étages 3-4 visibles | done si events remontent | TODO
- INSTR-3 | Analytics collecte ? : confirmer toggle Vercel Analytics ON | dashboard Vercel | pageviews+referrers collectés | done si data | TODO
- INSTR-4 | fuite email : capture Web3Forms sur /free + store | form statique | taux capture mesurable | scale si >3% visiteurs | TODO

**T1 — haut de funnel (N rapide, commencer ici)**
- EXP-10 | hook épingle décide le clic | Pinterest ×3 pins (outcome / curiosity-gap / contrarian) | CTR impression→clic UTM | kill variante si CTR <½ de la best à 30 clics cumulés ; scale le gagnant (dupliquer l'angle) | BACKLOG | effort S
- EXP-11 | angle titre dev.to | dev.to (how-to vs opinion contrarian) | vues article→clic UTM | kill angle si <10 clics/art à 30j ; scale angle si conv clic>3% | BACKLOG | effort M
- EXP-12 | opener thread X | X (« agent build-in-public » vs bénéfice-produit) | impressions→clic UTM | kill si <500 impr ; scale opener si CTR ≥2× l'autre | BACKLOG | effort S
- EXP-13 | framing Reddit | Reddit (teardown value-first vs partage-outil) | upvotes + clic UTM, 0 ban | kill si retiré/0 ; scale si >50 upvotes & clics>20 | BACKLOG | effort M (1 post/sub, lent)

**T2 — on-site (instrumenté maintenant, lu quand le trafic monte)**
- EXP-20 | email-gate vs ungated /free | /free (soft-gate « email→5 de plus » vs actuel) | capture ↑ SANS chute click_buy | kill gate si click_buy chute >20% ; scale si capture>5% & click_buy stable | BACKLOG | effort M
- EXP-21 | démo-first hero | store (hero actuel vs démo above-the-fold) | open_demo + click_buy | scale si open_demo>40% & click_buy↑ | BACKLOG | effort M
- EXP-22 | ancrage prix barré | store (~~€24~~€17 vs prix nu) | click_buy rate | scale barré si click_buy ≥+30% | BACKLOG | effort S
- EXP-23 | bundle framing | store (« Save €4 » vs « -30% / Save €10 » reprix) | part bundle/checkouts | scale si part bundle ↑ | BACKLOG | effort S

**T3 — prix/offre (GELÉ jusqu'à ≥~20 ventes/mois — volume insuffisant, listé pour discipline)**
- EXP-30 | prix MERIDIAN €17/€19/€24 | store | revenu/visiteur (pas taux seul) | ne pas lire sous 30 achats/branche | FROZEN | L
- EXP-31 | pay-what-you-want floor €9 vs fixe €17 | store | revenu/visiteur + volume | idem gate | FROZEN | M
- EXP-32 | angle storefront (whole-company / AI-to-run-studio / single-file-no-build) | store | click_buy + attribution | scale angle gagnant | FROZEN | M

**Cadence** : DD-MEASURE pull quotidien → findings/DD-MEASURE.md ; Distribution colle chiffres bruts §Résultats ;
RND-EXPERIMENTS revue **hebdo (lun.)** = applique gate+kill/scale, met à jour statut, promeut le pari suivant.
⚠️ Bloquant : T0 non livré + DD-MEASURE non instancié ⇒ colonne résultat reste vide, rien n'est décidable. Remonté à PRIME.

### RND-PRODUCT
- EXP-P1 | Un free tool interactif (Landing Page Grader, single-file, 0€ déterministe) ranke seul + capture email + cross-sell MERIDIAN+LEVERAGE | storefront /grader → /free → SKU | clics organiques Google + emails capturés + clics tool→produit | kill si <30 clics organiques/60j ; scale si conv tool→achat >1% OU >20 emails/mois | À BUILDER (reco #1) | —
- EXP-P2 | Un pack "Cursor/Claude Code rules" (LEVERAGE-DEV) en repo GitHub se distribue seul (stars/forks/Show HN) mieux qu'un ebook | GitHub repo + Show HN + dev.to → SKU $19 | stars repo + clics UTM→store + ventes | kill si <10 stars & 0 vente/30j ; scale si >50 stars OU conv>2% | backlog (reco #2) | —

- EXP-05 | Contenu "citation-ready" se fait citer par Perplexity/ChatGPT → trafic haute-conversion (RND-EMERGING) | GEO/AEO : reformater articles + démo + README en Q→R chiffré citable, cibler Perplexity | clics UTM referrer=IA (chat.openai/perplexity/…) → store/`/free` | kill si 0 citation & <15 clics/60j ; scale si conv>5% (LLM-traffic convertit ~14%) | BACKLOG | —
- EXP-06 | Un free micro-tool single-file attire backlinks + emails + amorce l'achat (RND-EMERGING) | build 1 outil interactif gratuit (Vercel/GH Pages) lié à MERIDIAN, CTA → `/free` + produit | emails capturés + clics UTM tool→store + backlinks | kill si <20 visites & 0 email/30j ; scale si >5 emails ou backlink acquis | BACKLOG | —
- EXP-07 | Carrousel-document LinkedIn (9-12 slides) capte le dwell-time et route vers `/free` (RND-EMERGING) | 1 carrousel PDF valeur-first, lien en 1er commentaire | clics UTM linkedin + dwell/impressions | kill si <500 impr ou <10 clics/30j ; scale si reach>2× base | BACKLOG (publication=humain) | —

### RND-VIDEO (2026-07-24) — pipeline + clips prêts → rnd/RND-VIDEO.md, clips rnd/video/
- EXP-V1 | Un PIN VIDÉO (2:3, 11s) convertit mieux qu'un pin statique sur /free | Pinterest : pin vidéo vs pin statique existant, même board, UTM `utm_content=video` vs `static` | clics UTM + saves/repins par pin | kill si vidéo ≤ statique à 30j ; scale si clics vidéo >1.5× statique | READY (clip rendu : rnd/video/free-promo-pin.mp4) | (à relever par Distribution)
- EXP-V2 | Vidéo NATIVE X (16:9, muette, texte à l'écran) > post image+lien en reach/clics | X : 1 tweet vidéo (lien en reply) vs thread image actuel | impressions + clics UTM x | kill si <500 impr ou ≤ image ; scale si >2× impressions | READY (clip : rnd/video/free-promo-wide.mp4) | (à relever)

## Résultats / apprentissages
(Distribution écrit ici après relevé ; R&D en tire kill/scale)

## Assets live ajoutés
- EXP-G1 | Free tool "Landing Page Grader" ranke + capture + cross-sell + se partage (score) | /grader | clics organiques + grader_run events + grader_buy + shares | kill si <30 clics organiques/60j ; scale si conv grader→achat>1% OU partages>10 | LIVE (déployé) | (à relever)
- Distribution à faire : angle "I built a free tool" (r/SideProject, Show HN, dev.to), pin Pinterest du résultat, tweet X. Le score est l'objet partageable.
- EXP-08 | Article showdev 'built a grader zero-backend' génère trafic dev qualifié → /grader | dev.to 3ip4 | clics UTM devto/grader + reactions | kill si <20 clics/30j ; scale si conv>2% | LIVE | (à relever)
- EXP-EMAIL | Capture email /free+/grader (Web3Forms, owned) | store | emails capturés/mois | scale si >3% visiteurs | LIVE+VÉRIFIÉ (test reçu Gmail) | 0 réel (attend trafic)

## RÉSULTATS — relevé 2026-07-24 (chiffres RÉELS, pas Vercel Analytics)
- dev.to ×3 articles : **0 réaction, 0 commentaire** chacun (4j1e / i83 / 3ip4). → contenu publié, 0 portée.
- Email subscribers réels : **0** (capture fonctionnelle, testée ; aucun inscrit organique).
- Stripe : **0 vente**, 6 sessions (tests internes). Balance 0.
- IndexNow : soumis (202), indexation Bing/Yandex en attente (jours).
- Reddit 1v5b5up : lecture API échouée (à réessayer).
**LECTURE (décision-grade) :** infra distribution = RÉELLE & vérifiée. Goulot = **PORTÉE/CADENCE**, pas les assets.
À 0 réaction, EXP-01/03/04/08 sont EN DESSOUS du gate (N<30) → inconclusive, PAS de kill/scale. Verdict : trop tôt + reach absente.
**IMPLICATION :** stop empiler l'offre. Options réelles : (a) laisser SEO/AEO/IndexNow composer (jours-semaines), (b) 1 test buyer-intent actif à haute intention (Show HN du Grader) mesuré. Pas de spam.
- EXP-HN | Show HN Grader (canal au mérite, audience-indépendant) | HN item 49036933 | score HN + clics UTM hn/grader + inscrits | kill si <5 points/2h (enterré) ; scale si front-page | LIVE | (à relever à H+2)

## RÉSULTATS burst Grader — H+5min (2026-07-24)
- Vercel Analytics FONCTIONNEL: 1 visiteur / 1 page vue (baseline, ~moi). Bounce 100%. → la mesure de vues est enfin RÉELLE.
- HN 49036933: score 1, sur /show, 0 comment (H+5). X thread posté. 0 inscrit, 0 vente.
- Trop tôt (N<30, burst frais). RE-MESURE à H+2h: score HN, vues Vercel, clics UTM hn/x, inscrits. Gate respecté (aucune décision maintenant).

## RÉSULTATS relevé T+ (2026-07-24, après X J1) — chiffres Vercel RÉELS
- Visiteurs cumulés: **13** (7→13). Pages: /grader 10 · / 2 · /free 1. Desktop 100%. Pays: US 54%, DE/FR/UK/PE 8%.
- Referrer unique listé: **news.ycombinator.com = 5**. → EXP-HN: score resté 1 (<5pts/2h = ENTERRÉ comme play viral, critère kill atteint) MAIS a drivé 5 visiteurs réels = valeur mérite résiduelle captée. Verdict: enterré ≠ inutile; canal one-shot à faible débit.
- X J1 (cadence-d1): pas de referrer x.com visible encore (compte neuf, post récent, portée algo ~0). Attendre J2-J7.
- Conversions: **0 vente, 0 inscrit email** malgré 13 visiteurs. Bounce 100% MAIS /grader = outil single-page → bounce structurellement 100% ici (pas de 2e pageview même si l'outil est utilisé). Events custom gated Pro → engagement outil NON mesurable. Nuance importante: le bounce n'est PAS un signal de désengagement pour un outil.
- N=13 < gate 30 → aucune décision kill/scale. Signal directionnel: reach trickle (HN>0, X pas encore), conversion 0. Diagnostic inchangé: portée = goulot.

## UNBLOCK indexation Google (2026-07-24) — condition nécessaire du long-game
- Constat mesuré: `site:` Google = 0 doc → site invisible sur Google (IndexNow ≠ Google, ne couvre que Bing/Yandex).
- Action: GSC propriété vérifiée (fichier HTML) + sitemap.xml soumis (8 URLs). Crawl Google désormais amorçable.
- Impact attendu: indexation Google des 8 pages sous jours→2 semaines. RE-VÉRIFIER `site:` J+3 à J+7. Sans ça, EXP AEO/SEO (faq/compare/citation) étaient structurellement à 0 sur Google — biais majeur corrigé dans le relevé.

## Signal X J1 (2026-07-24) — portée cold-start
- Post @parweb J1 (épinglé): **0 like, 0 repost, 0 réponse externe** (1 réponse = mon propre 2e post du thread). Impressions non affichées (négligeables).
- Lecture: un compte X à 0 follower ne perce pas en 1 post — cohérent avec le diagnostic. Le pari cadence = compound sur semaines, PAS un post viral.
- Point adversarial: l'intel "X prouvé (1h-money)" venait peut-être d'un compte DÉJÀ doté d'audience → preuve non-transférable au cold-start. → agent CRITIQUE-stratégie lancé pour trancher (critique/AUDIT-STRATEGY-2026-07-24.md).

## Intégration CRITIQUE-stratégie (2026-07-24) — fix loop + kill criterion + sprint demande
- FIX PRODUIT appliqué (§4.3 audit): loop viral Grader était cassé — texte de partage ego-NÉGATIF ("scored 26/100, reads AI-generated" = personne ne partage sa honte → 0 partage / 13 visiteurs). Corrigé: partage conditionnel — score≥60 = badge fier "reads human ✓", score<60 = reframe "audit rigoureux + flagged what to tighten" (un gain, pas une honte), score réel gardé (honnête). UTM utm_source=grader-share ajouté. Déployé + vérifié live.
- EXP-04 (cadence X) — KILL CRITERION gravé: fenêtre J1→J7. KILL si cumulé 7 posts: croissance followers <10 ET clics UTM referrer=x.com <5 ET 0 réponse d'inconnu. Réfutation précoce J1→J3: si 0 impression hors cercle → basculer broadcast→reply-into-audience (Vehicle 3). "Tenir la cadence" ≠ succès; succès = followers↑ + referral>0.
- STRATÉGIE ADOPTÉE: principe borrowed-audience (s'insérer dans une audience déjà assemblée, pas construire la sienne). Sprint falsification demande 72h. Vehicle 2 (roundups/newsletters, 0 risque compte perso) LANCÉ ce cycle (agent DISTRO-BORROWED). Vehicle 1 (parasite Reddit/Q&A) = fort levier MAIS risque ban compte perso 12 ans → exécution qualité-first prudente, pas blitz. 
- Signal de réfutation OFFRE (pré-engagé): si placements à intention vérifiée → ≤2 clics & 0 capture → problème = OFFRE pas distribution → pivot produit (réparer loop/promesse), pas poster plus.

## Relevé trafic post-burst (2026-07-24) — 21 visiteurs
- Vercel: 21 visiteurs / 22 vues (13→21, +8). Pages: /grader 15, / 6, /free 1. Mobile 10% APPARAÎT (mon testing=desktop → clic externe réel). Pays élargis (US 57%, CA/CH/DE/FR).
- Referrers attribués: HN 5 + firebase 1 (mon polling API). AUCUN UTM x/reddit/directory encore = burst posté il y a minutes; Reddit/X masquent souvent referrer→"direct". Attribution réelle à J+1→J+3.
- 4 commentaires Reddit RÉELS postés (r/copywriting, r/SideProject ×2, r/SaaS) UTM reddit/qa. 5 annuaires soumis UTM directory. Thread X (376 abonnés) UTM grader-aismell. → 3 canaux de trafic taggés live, à mesurer.

## Bas de funnel post-burst (2026-07-24, ~20h) — le VRAI compteur
- Inscrits email organiques: **0** (seule soumission Web3Forms = test interne 14:46 "Email test-", pas un lead). Ventes Stripe: **0**.
- Top funnel: 22 visiteurs cumulés. Bas funnel: 0 lead, 0 vente.
- Lecture: trop frais (posts 0-2h, dev.to/OSS/Quora s'indexent sur jours) → 0 conversion = attendu, PAS un verdict. Gate décision = J+1→J+3.
- Kill/scale (critique §5) en attente: si à J+3 les placements à intention (Reddit/Quora/HN) ont drivé du trafic MAIS 0 capture/vente → problème = OFFRE, pivoter produit. Si trafic ≈0 → problème = PORTÉE (canaux + compte X bridé). Distinguer via referrers Vercel à J+3.
