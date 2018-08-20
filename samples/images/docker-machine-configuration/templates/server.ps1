param (
  [Parameter(Mandatory=$true)]
  [string]$Name
)

mkdir -Force /ProgramData/docker/certs.d
Copy-Item $PSScriptRoot/machines/$Name/ca.pem /ProgramData/docker/certs.d
Copy-Item $PSScriptRoot/machines/$Name/server.pem /ProgramData/docker/certs.d
Copy-Item $PSScriptRoot/machines/$Name/server-key.pem /ProgramData/docker/certs.d

mkdir -Force /ProgramData/docker/config
Copy-Item $PSScriptRoot/machines/$Name/server.windows.json /ProgramData/docker/config/daemon.json

Restart-Service *docker*

# netsh advfirewall firewall add rule name="Docker Engine" dir=in action=allow protocol=TCP localport=2376
netsh advfirewall set allprofiles state off
