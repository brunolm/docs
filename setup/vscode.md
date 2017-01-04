# VSCode

To install [vscode](https://code.visualstudio.com/):

## Windows

```
curl https://go.microsoft.com/fwlink/?LinkID=623230 -OutFile (join-path $env:TEMP vscode.exe); Start-Process (join-path $env:TEMP vscode.exe)
```

## Linux

```
curl -L https://go.microsoft.com/fwlink/?LinkID=760868 > /tmp/vscode.deb
sudo dpkg -i /tmp/vscode.deb && sudo apt-get install -f
```

## Extensions

```
code --install-extension aeschli.vscode-css-formatter
code --install-extension alefragnani.Bookmarks
code --install-extension christian-kohler.path-intellisense
code --install-extension cssho.vscode-svgviewer
code --install-extension donjayamanne.githistory
code --install-extension EditorConfig.EditorConfig
code --install-extension eg2.tslint
code --install-extension MattiasPernhult.vscode-todo
code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.PowerShell
code --install-extension PeterJausovec.vscode-docker
code --install-extension seanmcbreen.Spell
code --install-extension Shan.code-settings-sync
code --install-extension wmaurer.change-case
```

- **aeschli.vscode-css-formatter**: Add support to autoformat CSS
- **alefragnani.Bookmarks**: Add bookmarks on lines and jump directly into them even in different files
- **christian-kohler.path-intellisense**: Finds files in the path you type and show auto-complete
- **cssho.vscode-svgviewer**: Preview SVG files
- **donjayamanne.githistory**: View git history, line history...
- **EditorConfig.EditorConfig**: Automatically keep format consistency in the project
- **eg2.tslint**: Lint for TypeScript
- **MattiasPernhult.vscode-todo**: View all todo comments
- **ms-vscode.csharp**: C# language support
- **ms-vscode.PowerShell**: Powershell language support
- **PeterJausovec.vscode-docker**: Docker language support
- **seanmcbreen.Spell**: Spell check
- **Shan.code-settings-sync**: Sync VSCode settings across machines
- **wmaurer.change-case**: Change text casing (camelCase, Title Case, snake_case...)
