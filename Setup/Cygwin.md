# Cygwin

```
Install-Package cygwin
```

## Configure HOME

```
mkpasswd -l -p "$(cygpath -H)" > /etc/passwd
```
