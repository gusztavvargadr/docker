param (
  [Parameter(Mandatory=$true)]
  [string]$Name
)

$env:MACHINE_STORAGE_PATH=$(Join-Path $pwd ".docker/machine")

docker-machine env $Name | Invoke-Expression
