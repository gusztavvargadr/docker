param (
  [string]$address,
  [string]$role
)

netsh advfirewall set allprofiles state off

$token = Get-Content /vagrant/.docker/swarm/$($role).token
"docker swarm join --token $token $($address):2377" | Invoke-Expression
