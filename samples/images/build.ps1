param (
  [string]$Name
)

docker build --tag gusztavvargadr/$Name $PSScriptRoot/$Name $argumentList
