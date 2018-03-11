param (
  [string]$address,
  [string]$token
)

netsh advfirewall set allprofiles state off

"docker swarm join --token $token $($address):2377" | Invoke-Expression
