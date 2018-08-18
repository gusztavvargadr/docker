param (
  [string]$Name
)

# touch $PSScriptRoot/$Name/docker-compose.override.yml
# docker stack deploy --compose-file $PSScriptRoot/$Name/docker-compose.yml --compose-file $PSScriptRoot/$Name/docker-compose.override.yml $Name
docker stack deploy --compose-file $PSScriptRoot/$Name/docker-compose.yml $Name
