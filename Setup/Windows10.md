# Windows 10 setup

```
Set-ExecutionPolicy RemoteSigned
Install-PackageProvider Chocolatey
Set-PackageSource Chocolatey -Trusted
```

## Browsers

```
Install-Package GoogleChrome
Install-Package Firefox
```

## Communication

```
Install-Package Slack
Install-Package Discord
Install-Package Skype
```

## IDE / Editors

```
Install-Package VisualStudio2015Community
Install-Package VisualStudioCode
Install-Package atom
Install-Package notepadplusplus
Install-Package vim -ProviderName chocolatey
```

## Games
```
Install-Package Steam
Install-Package OBS
```

## Programming

```
Install-Package nodejs
Install-Package docker
```

### npm

```
npm i -g typescript
```

## Utils

```
Install-Package 7zip
Install-Package greenshot
Install-Package procexp
Install-Package windirstat
```