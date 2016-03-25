# VSCode

To install [vscode](https://code.visualstudio.com/Docs/editor/setup#_linux):

```
curl -L https://go.microsoft.com/fwlink/?LinkID=620884 > /tmp/vscode.zip
unzip -qq /tmp/vscode.zip -d /tmp
sudo cp -r /tmp/VSCode-linux-x64 /opt/vscode
sudo ln -s /opt/vscode/Code /usr/local/bin/vscode
sudo rm -rf /tmp/VSCode-linux-x64
sudo rm -f /tmp/vscode.zip
sudo touch /usr/share/applications/vscode.desktop
sudo chmod 777 /usr/share/applications/vscode.desktop
sudo echo -e "[Desktop Entry]\nName=VSCode\nComment=Visual Studio Code\nExec=/opt/vscode/Code\nIcon=/opt/vscode/resources/app/resources/linux/code.png\nType=Application\nVersion=1.0\nTerminal=false\nCategories=Development" > /usr/share/applications/vscode.desktop
sudo chmod 644 /usr/share/applications/vscode.desktop
```

## Extensions

- [ext install vscode-eslint][1] - Validates JS code
- [ext install eg2.tslint][2] - Validates TS code
- [ext install vscode-todo][3] - Lists TODOs in code
- [ext install vscode-docker][4] - Better support for Docker files
- [ext install Spell][5] - Spell check
- [ext install addDocComments][6] - Add JSDoc comments
- [ext install lorem-ipsum][7] - Generates lorem ipsum text
- [ext install change-case][8] - Change word casing
- [ext install vscode-spotify][9] - Adds spotify on status bar

 [1]: https://marketplace.visualstudio.com/items/dbaeumer.vscode-eslint
 [2]: https://marketplace.visualstudio.com/items/eg2.tslint
 [3]: https://marketplace.visualstudio.com/items/MattiasPernhult.vscode-todo
 [4]: https://marketplace.visualstudio.com/items/PeterJausovec.vscode-docker
 [5]: https://marketplace.visualstudio.com/items/seanmcbreen.Spell
 [6]: https://marketplace.visualstudio.com/items/stevencl.addDocComments
 [7]: https://marketplace.visualstudio.com/items/Tyriar.lorem-ipsum
 [8]: https://marketplace.visualstudio.com/items/wmaurer.change-case
 [9]: https://marketplace.visualstudio.com/items/shyykoserhiy.vscode-spotify