param (
  [string]$Name
)

docker run --interactive --tty gusztavvargadr/$($Name):latest $argumentList
