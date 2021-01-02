## Package Repository

**NOTE: THE PACKAGE REPOSITORY DOES NOT WORK IN CHINA**

**注意：包裹存放区在中国不起作用**

Users inside China can download and install the package like this:

( 中国境内的用户可以像这样下载并安装软件包 )

```
wget -O skywire_0.3.0-3_arm64.deb https://github.com/the-skycoin-project/deb/blob/master/pool/main/s/skywire/skywire_0.3.0-3_arm64.deb?raw=true
dpkg -i skywire_0.3.0-3_arm64.deb
```

If you recieve an error about missing dependancies, try using the `--ignore-depends` flag with dpkg

( 如果收到关于缺少依赖项的错误，请尝试在dpkg中使用`--ignore-depends`标志 )

Remember, you will not have access to automatic updates

( 请记住，您将无权访问自动更新 )


[This Repository](https://the-skycoin-project.github.io/deb) acts as a debian package repository which can be used to install skywire on .deb based systems of supported architectures (Currently: amd64 arm64 armhf)

These packages are updated as new upstream versions are released.

## [CURRENT PACKAGE MINOR RELEASE NOTES](/NOTE.md)

## To Use This Package Repository (with an existing debian system) -

**ALL COMMANDS SHOULD BE RUN AS ROOT OR WITH SUDO**

### 1) Add this repository to your apt sources
(as root or use sudo):
```
add-apt-repository 'deb http://the-skycoin-project.github.io/deb sid main'
```

If `add-apt-repository` is not be available, install it with `apt install software-properties-common`
or just manually edit your `/etc/apt/sources.list` (as root or use sudo):
```
nano /etc/apt/sources.list
```

Add the following:
```
deb http://the-skycoin-project.github.io/deb sid main
#deb-src http://the-skycoin-project.github.io/deb sid main
```

### 2) Add the repository signing key
as root:
```
curl -L http://the-skycoin-project.github.io/deb/KEY.asc | apt-key add -
```
with sudo this would be:
```
curl -L http://the-skycoin-project.github.io/deb/KEY.asc | sudo apt-key add -
```

### 3) Resync the package database:
(as root or use sudo)
```
apt update
```

### 4) Install skywire:
(as root or use sudo)
```
apt install skywire
```

**PLEASE NOTE THIS MAY FAIL ON RASPBIAN DUE TO NOT HAVING THE REPREPRO DEPENDANCY AVAILABLE**
If this is the case, install with --nodeps
(as root or use sudo)
```
apt install --nodeps skywire
```

At the point you have completed the above, skywire should be running. The output of the package installation should provide a link to the hypervisor UI where you an check it in your web browser.

### 5) Configuring additional visors
**PLEASE NOTE THIS MAY NOT WORK FULLY ON RASPBIAN, PLEASE REFER TO THE ALTERNATIVE METHODS**

Generate the distributable hypervisor public key package
(as root or use sudo)
```
keypkg-gen
```

You will be prompted to configure a repository on the remote machines like was done in step 1

**Don't forget to configure this repository including adding the key** on the remote machines as well so that they are able to install skywire also.

After you have completed the prompt and steps 1, 2, and 3 on this page, you may then install the `hypervisorkey` package on the remote machines (as root or use sudo):
```
apt install hypervisorkey
```

Skywire will be installed as a dependancy of this package and the new visor should appear in your hypervisor UI at the point the command has completed

### Alternative methods

**if for some reason step 4 does not work** or if you have difficulty, forgo the local apt repository and copy the built hypervisorkey .deb package from `/opt/skywire/pkgcache` to `/opt/skywire/skycache` and then run `skycache` or start the `skycache` systemd service. The contents of `/opt/skywire/apt/repo` are made available on port :8079 of the local host. Fetch this package to the other SBCs using wget or your preferred method and install with `dpkg -i`

Another alternative would be to copy the built hypervisorkey package along with the skywire package to a USB drive. Mount the drive on the SBCs and install skywire first, then install the hypervisorkey package.

### 5) Updating your system and the skywire installation.
**PLEASE DO NOT USE THE UPDATE BUTTON IN THE SKYWIRE UI**
**PLEASE DO NOT USE THE UPDATE BUTTON IN THE SKYWIRE UI**

Any new version of packages which are added to repositories you have configured in your apt sources will be installed with the following commands (as root or use sudo):
```
apt update
apt upgrade
```

Additionally, refer to the notes on the current skywire release at the beginning of this document for details on any manual intervention which is necessary for updates to work. And remember:

**PLEASE DO NOT USE THE UPDATE BUTTON IN THE SKYWIRE UI**
