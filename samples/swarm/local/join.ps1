param (
  [string]$address,
  [string]$role
)

$token = Get-Content /data/docker/swarm/$($role).token
"docker swarm join --token $token $($address):2377" | Invoke-Expression
