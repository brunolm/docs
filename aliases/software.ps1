function Update-SW-Chrome () {
  Invoke-WebRequest "http://dl.google.com/chrome/install/stable/chrome_installer.exe" -OutFile (join-path $env:TEMP chrome.exe);
  Start-Process (join-path $env:TEMP chrome.exe);
}

function Update-SW-GOMPlayer() {
  Invoke-WebRequest "https://cdn.gomlab.com/gretech/player/new_chrome/GOMPLAYERGLOBALSETUP.EXE" -OutFile (join-path $env:TEMP gom.exe);
  Start-Process (join-path $env:TEMP gom.exe);
}

function Update-SW-Node() {
  $nodeLatest=((Invoke-WebRequest https://nodejs.org/download/release/latest/).Content | findstr x64.msi) -replace "<(.*?)>", "" -replace "\s+.+", "";
  Invoke-WebRequest "https://nodejs.org/download/release/latest/$nodeLatest" -OutFile (join-path $env:TEMP node.msi);
  Start-Process (join-path $env:TEMP node.msi);
}

function Update-SW-Sqlectron() {
  $versionLink = [regex]::Match((Invoke-WebRequest "https://github.com/sqlectron/sqlectron-gui/releases").Content, "/sqlectron/sqlectron-gui/releases/download/[^""]+(exe(?=""))").Groups[0].Value;
  $version = [regex]::Match($versionLink, "/v(.*?)/").Groups[1].Value;
  $file = "${env:TEMP}\sqlectron-$version.exe";
  Write-Output "Installing $version..."
  Invoke-WebRequest "https://github.com${versionLink}" -OutFile $file;
  Start-Process $file;
}

function Update-SW-Steam() {
  Invoke-WebRequest "https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe" -OutFile (join-path $env:TEMP steam.exe);
  Start-Process (join-path $env:TEMP steam.exe);
}

function Update-SW-VSCode() {
  $file = "${env:TEMP}\vscode.exe";
  Invoke-WebRequest "https://go.microsoft.com/fwlink/?LinkID=623230" -OutFile $file;
  Start-Process $file;
}

function Update-SW-uTorrent() {
  Invoke-WebRequest "http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows" -OutFile (join-path $env:TEMP utorrent.exe);
  Start-Process (join-path $env:TEMP utorrent.exe);
}
