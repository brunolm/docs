# Node

## Windows

```
$nodeLatest=((curl https://nodejs.org/download/release/latest/).Content | findstr x64.msi) -replace "<(.*?)>", "" -replace "\s+.+", "";
wget "https://nodejs.org/download/release/latest/$nodeLatest" -OutFile (join-path $env:TEMP node.msi); Start-Process (join-path $env:TEMP node.msi) #"/quiet"

# wget https://nodejs.org/download/release/latest/win-x64/node.exe -OutFile 'C:\Program Files\nodejs\node.exe'
# npm i -g npm
```

## Linux

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
echo ". ~/.nvm/nvm.sh" >> ~/.zshrc
source ~/.zshrc
nvm install stable
nvm use stable
n=$(which node);n=${n%/bin/node}; sudo chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
```

### npm

```
npm i -g typescript
npm i -g ts-node
npm i -g rimraf
```