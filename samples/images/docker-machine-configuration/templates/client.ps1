param (
  [Parameter(Mandatory=$true)]
  [string]$Name
)

$env:MACHINE_STORAGE_PATH=$PSScriptRoot

docker-machine env $Name | Invoke-Expression
