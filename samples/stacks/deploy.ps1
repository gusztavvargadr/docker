param (
  [string]$Name
)

docker stack deploy -c $Name/docker-compose.yml $Name
