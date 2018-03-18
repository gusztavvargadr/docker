param (
  [string]$Name = "ping"
)

docker stack deploy -c $Name/docker-compose.yml $Name
