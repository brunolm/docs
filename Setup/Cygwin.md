# Cygwin

```
Install-Package cygwin
```

## Check packages

- ssh
- curl
- wget
- vim
- zsh

## Configure HOME

```
mkpasswd -l -p "$(cygpath -H)" > /etc/passwd
```

* Manually edit `/etc/passwd` to set default to `zsh` or `bash`.

## Configure ZSH

```
git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
```
