# Powershell

## Profile config

```
try {
  Set-ExecutionPolicy RemoteSigned
} catch { }
#cd D:\
#cls
#echo $Profile

Function projs($path) {
  cd "D:\BrunoLM\Projects\$path"
}

Function source-profile {
  . $Profile
}

Function edit-profile {
  echo $Profile
  code $Profile
}

Function edit-aliases() {
  code $env:Home/aliases
}

Function edit-hosts {
  echo "C:\Windows\System32\drivers\etc\hosts"
  start -verb runas code "C:\Windows\System32\drivers\etc\hosts"
}

function prompt {
  Write-Host -NoNewline -ForegroundColor Cyan "PS "
  $location = $(get-location)

  $parts =  $location.ProviderPath.Split('\\')

  Write-Host -NoNewline -ForegroundColor Green "$($location.Drive): $($parts[$($parts.Length) - 1])"

  $gitbranch = $(git rev-parse --abbrev-ref HEAD)
  if ($gitbranch) {
    Write-Host -NoNewline -ForegroundColor White " ("
    Write-Host -NoNewline -ForegroundColor Red $gitbranch
    Write-Host -ForegroundColor White ")"
  }

  if ($env:ConEmuBaseDir -ne $null) {
    & ConEmuC.exe -StoreCWD "$dir"
  }
  return "> "
}

if (Test-Path $env:HOME) {
    Get-ChildItem $env:Home/aliases -Filter *.ps1  |
    Foreach-Object {
        . $_.FullName
    }
}
```
