# Action to run SQL scripts on Google Cloud SQL

```
workflow "run sql scripts" {
  on = "push"
  resolves = ["execute scripts"]
}

action "auth on gcp" {
  uses = "actions/gcloud/auth@1a017b23ef5762d20aeb3972079a7bce2c4a8bfe"
  secrets = ["GCLOUD_AUTH"]
}

action "execute scripts" {
  uses = "informaticon/gh.action.sql-script-runner@master"
  needs = ["auth on gcp"]
  env = {
    SSR_DB_USER = "ssr_test"
    SSR_DB_DATABASE = "ssr_test"
    SSR_GCS_PROXY = "informaticon-devops:europe-west1:devops"
  }
  secrets = ["SSR_DB_PASSWORD"]
}

```
