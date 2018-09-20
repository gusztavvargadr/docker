param (
  [string]$Name
)

if (Test-Path $PSScriptRoot/$Name/docker-compose.override.yml) {
  docker stack deploy --compose-file $PSScriptRoot/$Name/docker-compose.yml --compose-file $PSScriptRoot/$Name/docker-compose.override.yml $Name
} else {
  docker stack deploy --compose-file $PSScriptRoot/$Name/docker-compose.yml $Name
}
