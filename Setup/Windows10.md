# Windows 10 setup

```
Set-ExecutionPolicy RemoteSigned
Install-PackageProvider Chocolatey
Set-PackageSource Chocolatey -Trusted

Install-Package VisualStudio2015Community
Install-Package VisualStudioCode
Install-Package atom
Install-Package notepadplusplus
Install-Package vim -ProviderName chocolatey
Install-Package GoogleChrome
Install-Package Firefox
```