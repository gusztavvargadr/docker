param (
  [string]$Name
)

docker build --tag gusztavvargadr/$Name $Name $argumentList
