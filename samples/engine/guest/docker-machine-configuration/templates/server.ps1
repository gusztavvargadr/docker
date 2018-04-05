param (
  [Parameter(Mandatory=$true)]
  [string]$Name
)

mkdir -Force /ProgramData/docker/certs.d
Copy-Item .docker/machine/machines/$Name/ca.pem /ProgramData/docker/certs.d
Copy-Item .docker/machine/machines/$Name/server.pem /ProgramData/docker/certs.d
Copy-Item .docker/machine/machines/$Name/server-key.pem /ProgramData/docker/certs.d

mkdir -Force /ProgramData/docker/config
Copy-Item .docker/machine/machines/$Name/server.windows.json /ProgramData/docker/config/daemon.json

Restart-Service *docker*
