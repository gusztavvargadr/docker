param (
  [string]$name,
  [string]$provider
)

$env:MACHINE_STORAGE_PATH=$(Join-Path $pwd ".docker/machine")

docker-machine create `
  -d generic `
  --generic-ip-address $name `
  --generic-ssh-user vagrant `
  --generic-ssh-key $(Join-Path $pwd ".vagrant/machines/$name/$provider/private_key").Replace("\", "/").Replace(":", "").Substring(1) `
  $name

docker-machine env $name | Invoke-Expression
