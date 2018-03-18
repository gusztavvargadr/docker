param (
  [string]$Name = "hello-world"
)

docker run --interactive --tty gusztavvargadr/$($Name):latest $argumentList
