# RÈGLE DU JEU (à donner à chaque agent)

Ce répertoire est le monde partagé. Tout vit ici en fichiers. Rien de caché ailleurs.

1. **Tous les agents lisent tout.** Aucune permission, aucun cloisonnement. Pour parler à un
   autre agent : écris un fichier. Pour l'écouter : lis les siens.
2. **Tu peux créer d'autres agents.** Un agent = un process `claude -p "<prompt>" --dangerously-skip-permissions`
   lancé dans ce répertoire (en background : `&` ou via run_in_background). Donne-leur cette même RULES.md.
3. **Tu agis, tu ne demandes pas validation.** Décision réversible → tu la prends et la notes dans un fichier.
   Ne reste jamais immobile.
4. **0€ = capital EXTERNE interdit** (pub payante, stock, abonnement à avancer). Le compute/les agents sont GRATUITS — spawne sans compter.
   Le seul argent qui compte est celui qui ENTRE.
5. **Humain hors boucle.** Ne le sollicite que pour ce qu'un agent ne PEUT PAS faire (identité légale,
   paiement, OTP, login) : écris dans `HUMAN.md` et continue autre chose.

## Protocole de messages (fichiers)
- Registre des agents : `AGENTS.md` (append ta ligne au spawn : nom, rôle, heure).
- Broadcast à tous : écris `bus/broadcast/<from>-<sujet>.md`.
- Message ciblé : écris `bus/to-<nom>/<from>-<sujet>.md`.
- Tes résultats : `findings/<ton-nom>.md` (verdict + chiffres + prochaine action).
- État global du monde : `STATE.md` (lis-le d'abord, mets à jour tes décisions).

## Cadence
Fais un chunk de travail concret, écris tes fichiers, puis termine (le process s'arrête).
Si le travail dépasse un run, spawne un successeur ou laisse une TODO dans ton findings.
