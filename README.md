# github-config

Les dépôts GitHub du compte ororck et leurs protections de branche, gérés en Terraform.

## Ce que ça fait

Crée chaque dépôt déclaré, avec son ruleset de branche, ses alertes de
vulnérabilité et ses réglages de merge. Un réglage modifié dans l'interface
GitHub ressort au `terraform plan` suivant.

Le ruleset posé sur la branche par défaut impose une pull request pour toute
modification, interdit le force push et la suppression de branche, et n'accorde
aucun contournement, pas même au propriétaire du compte.

## Comment ça marche

`repositories.yml` liste les dépôts. `main.tf` boucle dessus et passe chaque
entrée au module `modules/repo`, qui porte les règles communes. Ajouter un dépôt
tient en une entrée et un apply.

```yaml
mon-nouveau-depot:
  description: "Ce que fait ce dépôt"
  topics: ["devops"]
```

```bash
export GITHUB_TOKEN="$(gh auth token)"
terraform init
terraform apply
```

Les dépôts sont forcés en public dans le module. Sur le plan GitHub actuel, un
dépôt privé n'a pas de ruleset, donc le passer en privé reviendrait à perdre sa
protection sans avertissement.

Le state est dans Azure Blob Storage, avec versioning et suppression réversible.
L'authentification passe par Entra ID, le verrouillage par un bail sur le blob.

## Dépendances

- Terraform 1.9 ou plus
- `gh` authentifié, qui fournit le jeton GitHub
- Le rôle Storage Blob Data Contributor sur le compte de stockage du state
