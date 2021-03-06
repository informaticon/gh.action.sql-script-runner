workflow "Build and Publish" {
  on = "push"
  resolves = "Build"
}

action "Shell Lint" {
  uses = "actions/bin/shellcheck@master"
  args = "entrypoint.sh"
}

# action "Test" {
#   uses = "actions/bin/bats@master"
#   args = "test/*.bats"
# }

# action "Integration Test" {
#   uses = "./"
#   args = "version"
# }

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}


action "Build" {
  # "Test", "Integration Test",
  needs = ["Shell Lint", "Docker Lint"]
  uses = "actions/docker/cli@master"
  args = "build -t ssr ."
}

# action "Docker Tag" {
#   needs = ["Build"]
#   uses = "actions/docker/tag@master"
#   args = "npm github/npm --no-latest"
# }

# action "Publish Filter" {
#   needs = ["Build"]
#   uses = "actions/bin/filter@master"
#   args = "branch master"
# }

# action "Docker Login" {
#   needs = ["Publish Filter"]
#   uses = "actions/docker/login@master"
#   secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
# }

# action "Docker Publish" {
#   needs = ["Docker Tag", "Docker Login"]
#   uses = "actions/docker/cli@master"
#   args = "push github/npm"
# }
