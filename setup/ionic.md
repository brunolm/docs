# Ionic setup

## Installation

```
# Windows only
npm install --global --production windows-build-tools

npm install -g cordova ionic
```

- Install [Java JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- Install [Gradle](https://gradle.org/install/)
- Install [Android Studio](https://developer.android.com/studio/index.html)
  - (Windows) Install Windows build tools (link appears when trying to run a project)
  - Install HAXM (link appears when trying to create an emulator)

Make sure your $PATH includes:

```bash
# Unix (.bashrc / .zshrc)
export PATH=$HOME/Library/Android/sdk/tools:$PATH
export PATH=$HOME/Library/Android/sdk/tools/bin:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
```

```powershell
# Windows
$p = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User);
$x = ($p -split ';') + @(
  "${env:HOMEDRIVE}${env:HOMEPATH}\AppData\Local\Android\Sdk\platform-tools"
  "${env:HOMEDRIVE}${env:HOMEPATH}\AppData\Local\Android\Sdk\tools"
  "${env:HOMEDRIVE}${env:HOMEPATH}\AppData\Local\Android\Sdk\tools\bin");
$x = ($x | Where-Object { $_ }) -join ';';
[Environment]::SetEnvironmentVariable("Path", $x, [System.EnvironmentVariableTarget]::User)
```

After you install Java JDK and Android SDK you have to run a command to accept the licenses:

```bash
# sdkmanager is located at /Android/Sdk/tools/bin/
# which should now be in your path
sdkmanager --licenses

# press y in all options
```

### Mac only

- Install [XCode from App Store](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
- Open XCode for the first time (find from LunchPad)
- [Point xcode-select to the Xcode app Developer directory using the following command](https://stackoverflow.com/a/17980786/340760):

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

In case you have JDK other than v8:

```bash
# add to .bashrc or .zshrc
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_162.jdk/Contents/Home/"
```

## Run

### Android

With a device on USB port (check if connect with `adb devices`)

```bash
ionic cordova run android --device --livereload
```

#### Connect via wi-fi

With the device connect on USB:

```bash
adb tcpip 5555
```

Disconnect.

```bash
adb connect <device ip>
```

Done, use it as if it was connect.

### iOS

Before you run the first time see instructions bellow.

```bash
ionic cordova run ios --device --livereload
```

#### Before run

To run directly on a device you need to sign your app. To do that you can open the project on XCode. The project file is located under `/platforms/ios`.

On the project is open select the first item on the tree (should come selected by default), go to Signing and select/create a team. If you don't do this you will get `Error code 65 for command: xcodebuild with args`.

After that try to run the command, you will get error 1. To fix that:

- Go to your device Settings > General > DeviceManagement
  - Trust your account/team

## Install plugins

With the following versions:

```bash
ionic -v
# 3.19.1
cordova -v
# 8.0.0
```

Use `cordova-android@6.4.0` (v7+ doesn't work).

```bash
npm i -S cordova-android@6.4.0
```

Follow [steps at their documentation](https://ionicframework.com/docs/native/image-picker/) and go from there.
