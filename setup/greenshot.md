# Greenshot

```
$greenshotLatest=(((curl http://getgreenshot.org/version-history/).Content | select-string -pattern '(https.*?Greenshot.*?RELEASE.exe)').Matches.Groups[1]).Value;
wget $greenshotLatest -OutFile (join-path $env:TEMP greenshot.exe); Start-Process (join-path $env:TEMP greenshot.exe)
```
