param (
  [Parameter(Mandatory=$true)]
  [string]$Name
)

mkdir -Force /ProgramData/docker/certs.d
Copy-Item .docker/machine/machines/$Name/ca.pem /ProgramData/docker/certs.d
Copy-Item .docker/machine/machines/$Name/server.pem /ProgramData/docker/certs.d
Copy-Item .docker/machine/machines/$Name/server-key.pem /ProgramData/docker/certs.d

mkdir -Force /ProgramData/docker/config
Copy-Item .docker/machine/machines/$Name/daemon.json /ProgramData/docker/config

Restart-Service *docker*
