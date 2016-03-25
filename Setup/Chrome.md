# Chrome Setup

## Extensions

```
All Mangas Reader http://allmangasreader.com/
BugMeNot Lite https://chrome.google.com/webstore/detail/bugmenot-lite/lackfehpdclhclidcbbfcemcpolgdgnb?hl=en
Copy Link Name https://chrome.google.com/webstore/detail/copy-link-name/mafjnaphoepgijmgfeemillelgkeigid?hl=en
Hola https://chrome.google.com/webstore/detail/unlimited-free-vpn-hola/gkojfkhlekighikafcpjkiklfbnlmeio?hl=en
Postman https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en
React Developer Tools https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en
Rikaikun https://chrome.google.com/webstore/detail/rikaikun/jipdnfibhldikgcjhfnomkfpcebammhp?hl=en
Stylish https://chrome.google.com/webstore/detail/stylish/fjnbnpbmkenffdnngjfgmeleoegfcffe?hl=en
uBlock Origin https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en
```

## Patch to disable developer warning

```
<# :
@echo off
copy/b "%~f0" "%temp%\%~n0.ps1" >nul
powershell -ExecutionPolicy bypass -noprofile -file "%temp%\%~n0.ps1" "%cd% " "%~1"
del "%temp%\%~n0.ps1"
pause
exit /b
#>
param([string]$cwd='.', [string]$dll)

function main {
    if ($dll -and (gi -literal $dll)) {
        doPatch "DRAG'n'DROPPED" ((gi -literal $dll).directoryName + '\')
        exit
    }
    doPatch CURRENT ((gi -literal $cwd).fullName + '\')
    ('HKLM', 'HKCU') | %{ $hive = $_
        ('', '\Wow6432Node') | %{
            $key = "${hive}:\SOFTWARE$_\Google\Update\Clients"
            gci -ea silentlycontinue $key -r | gp | ?{$_.CommandLine} | %{
                $path = $_.CommandLine -replace '"(.+?\\\d+\.\d+\.\d+\.\d+\\).+', '$1'
                doPatch REGISTRY $path
            }
        }
    }
}

function doPatch([string]$pathLabel, [string]$path) {
    $dll = $path + "chrome.dll"
    if (!(test-path -literal $dll)) {
        return
    }
    "======================="
    "$pathLabel PATH $((gi -literal $dll).DirectoryName)"
    "`tREADING Chrome.dll..."
    $bytes = [IO.File]::ReadAllBytes($dll)

    # process PE headers
    $BC = [BitConverter]
    $coff = $BC::ToUInt32($bytes,0x3C) + 4
    $is64 = $BC::ToUInt16($bytes,$coff) -eq 0x8664
    $opthdr = $coff+20
    $codesize = $BC::ToUInt32($bytes,$opthdr+4)
    if (!$is64) { $imagebase = $BC::ToUInt32($bytes,$opthdr+28) }

    # patch the flag in data section
    $data = $BC::ToString($bytes,$codesize)
    $flag = "ExtensionDeveloperModeWarning"
    $stroffs = $data.IndexOf($BC::ToString($flag[1..99]))/3 - 1
    if ($stroffs -lt 0) {
        write-host -f red "`t$flag not found"
        return
    }
    $stroffs += $codesize
    if ($bytes[$stroffs] -eq 0) {
        write-host -f green "`tALREADY PATCHED"
        return
    }
    $bytes[$stroffs] = 0
    "`tPATCHED $flag flag"

    # patch the channel restriction code for stable/beta
    $code = $BC::ToString($bytes,0,$codesize)
    $codepattern = "83-F8-03-7D-.{1,100}"
    try {
        if ($is64) {
            $pos = 0
            $rx = [regex] "$codepattern-48-8D"
            do {
                $m = $rx.match($code,$pos)
                if (!$m.success) { throw }
                $pos = $m.index + $m.length + 1
                $offs = $BC::ToUInt32($bytes,$pos/3+1)
                $diff = $pos/3+5+$offs - $stroffs
            } until ($diff -ge 0 -and $diff -le 4096 -and $diff % 1024 -eq 0)
        } else {
            $pattern = $BC::ToString($BC::GetBytes($stroffs+$imagebase)) `
                -replace '^(..-)..(.+)', "$codepattern-68-$1..$2"
            $m = [regex]::match($code,$pattern)
            if (!$m.success) { throw }
        }
    } catch {
        write-host -f red "`tUnable to find the channel code, try updating me"
        return
    }
    $bytes[$m.index/3+2] = 9
    "`tPATCHED Chrome release channel restriction"

    "`tWriting to a temporary dll..."
    [IO.File]::WriteAllBytes("$dll.new",$bytes)

    "`tBacking up the original dll..."
    move -literal $dll "$dll.bak" -force

    "`tRenaming the temporary dll as the original dll..."
    move -literal "$dll.new" $dll -force

    "DONE.`n"
}

main
```