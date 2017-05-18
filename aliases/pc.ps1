function Disable-Beep() {
  Set-PSReadlineOption -BellStyle None
  # set-service beep -startuptype disabled
}

function Start-Powershell() {
  Start-Process powershell -Verb runAs
}

Disable-Beep
