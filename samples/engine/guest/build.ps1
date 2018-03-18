param (
  [string]$Name = "hello-world"
)

docker build --tag gusztavvargadr/$Name $Name $argumentList
