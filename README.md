<!-- MarkdownTOC levels="1,2,3,4,5" autolink="true" bracket="round" -->
- [1 - Repository Configurtion](#1-add-this-repository-to-your-apt-sources)
- [2 - Add Repo Signing Key](#2-add-the-repository-signing-key)
- [3 - Sync Package Database](#3-resync-the-package-database)
- [4 - Install Skywire](#4-install-skywire)
- [5 - Configure Additional Visors](#5-configuring-additional-visors)
- [6 - Updating Your System And The Skywire Installation](#6-updating-your-system-and-the-skywire-installation)
- [Manual Download / instalation and Instructions for users in China - 中国境内用户使用说明 ](#users-in-china)

 [PACKAGE RELEASE NOTES](/NOTE.md)

## Package Repository

[This Repository](https://the-skycoin-project.github.io/deb) acts as a debian package repository which can be used to install skywire on .deb based systems
These packages are updated as new upstream versions are released.

Users are encouraged to configure [this package repository](https://the-skycoin-project.github.io/deb) in their APT sources in order to have access to updated versions of the software packages in this repo.

## To Use This Package Repository (with any existing deb system) -

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
apt install skywire-bin
```

provided is the packaged binary release of skywire, latest version


At the point you have completed the above, skywire should be running. The output of the package installation should provide a link to the hypervisor UI where you an check it in your web browser.

### 5) Configuring additional visors

the following script included with the package accepts one argument - the remote hypervisor key
```
skywire-hypervisorkey <remote-hypervisor-key>
```

remember to substituite a public key in the command above

### 6) Updating your system and the skywire installation.
**PLEASE DO NOT USE THE UPDATE BUTTON IN THE SKYWIRE UI**
**PLEASE DO NOT USE THE UPDATE BUTTON IN THE SKYWIRE UI**

Any new version of packages which are added to repositories you have configured in your apt sources will be installed with the following commands (as root or use sudo):
```
apt update
apt upgrade
```

Additionally, refer to the notes on the current skywire release at the beginning of this document for details on any manual intervention which is necessary for updates to work. And remember:

**PLEASE DO NOT USE THE UPDATE BUTTON IN THE SKYWIRE UI**


### Users In China

**NOTE: THE PACKAGE REPOSITORY DOES NOT WORK IN CHINA**

**注意：包裹存放区在中国不起作用**

Current versions of skycoin packages for ARMHF, ARM64, AMD64 are available via [the repository](https://github.com/the-skycoin-project/deb).
**All versions are available for [direct download](https://github.com/the-skycoin-project/deb/releases/tag/archive) in the release section**

Users inside China can download and install the package like this:

( 中国境内的用户可以像这样下载并安装软件包 )

( 从下面的选项中选择与目标计算机的体系结构相对应的软件包的适当体系结构。 从您要在其上安装skywire的计算机的SSH会话或终端中执行以下命令 )

用于橙色pi ARM64
For ARM64 https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.1-4_arm64.deb
```
wget -O skywire_0.4.1-4_arm64.deb https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.1-4_arm64.deb
dpkg -i skywire_0.4.1-4_arm64.deb
```

用于树莓派ARMHF
For ARMHF
https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.1-4_armhf.deb
```
wget -O skywire-bin_0.4.1-4_armhf.deb https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.1-4_armhf.deb
dpkg -i skywire-bin_0.4.1-4_armhf.deb
```

用于台式机AMD64
For AMD64
https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.1-4_amd64.deb
```
wget -O skywire-bin_0.4.1-4_amd64.deb https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.1-4_amd64.deb
dpkg -i skywire-bin_0.4.1-4_amd64.deb
```

If you recieve an error about missing dependancies, try using the `--ignore-depends` flag with dpkg

( 如果收到关于缺少依赖项的错误，请尝试在dpkg中使用`--ignore-depends`标志 )

Remember, you will not have access to automatic updates

( 请记住，您将无权访问自动更新 )
