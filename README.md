## Package Repository


[This Repository](https://the-skycoin-project.github.io/deb) acts as a debian package repository which can be used to install skywire on .deb based systems
These packages are updated as new upstream versions are released.

Users are encouraged to configure [this package repository](https://the-skycoin-project.github.io/deb) in their APT sources in order to have access to updated versions of the software packages in this repo.

**NOTE: THE PACKAGE REPOSITORY DOES NOT WORK IN CHINA**

**注意：包裹存放区在中国不起作用**

Current versions of skycoin packages for ARMHF, ARM64, AMD64 are available via [the repository](https://github.com/the-skycoin-project/deb).
All versions are available for [direct download](https://github.com/the-skycoin-project/deb/releases/tag/archive) in the release section

Users inside China can download and install the package like this:

( 中国境内的用户可以像这样下载并安装软件包 )

For ARM64 https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.0-1_arm64.deb
```
wget -O skywire_0.4.0-1_arm64.deb https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.0-1_arm64.deb
dpkg -i skywire_0.4.0-1_arm64.deb
```

For ARMHF
https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.0-1_armhf.deb
```
wget -O skywire-bin_0.4.0-1_armhf.deb https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.0-1_armhf.deb
dpkg -i skywire-bin_0.4.0-1_armhf.deb
```

For AMD64
https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.0-1_arm64.deb
```
wget -O skywire-bin_0.4.0-1_arm64.deb https://github.com/the-skycoin-project/deb/releases/download/archive/skywire-bin_0.4.0-1_arm64.deb
dpkg -i skywire-bin_0.4.0-1_arm64.deb
```

If you recieve an error about missing dependancies, try using the `--ignore-depends` flag with dpkg

( 如果收到关于缺少依赖项的错误，请尝试在dpkg中使用`--ignore-depends`标志 )

Remember, you will not have access to automatic updates

( 请记住，您将无权访问自动更新 )


### [CURRENT PACKAGE MINOR RELEASE NOTES](/NOTE.md)


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

This process is undergoing revision. Automation for thi is not present in the binary release package. A rough sketch of the process is included in the following script which takes one argument - the remote hypervisor key that you want to set on the visor.
```
#!/bin/bash

[[ -z $1 ]] && echo "please specify hypervior key as argument" && exit || _hvk=$1

#stopping any running instance of skywire
systemctl disable --now skywire.service
systemctl disable --now skywire-visor.service

#config generation writes in the current dir;
#so we want to make anything spawned by the process appear as a subdirectory of install dir
cd /opt/skywire

if [[ -f /opt/skywire/skywire-visor.json ]] ; then #try to reuse any existing visor config
cp -b /opt/skywire/skywire-visor.json /opt/skywire/skywire-visor.json.gen
else
if [[ -f /opt/skywire/skywire.json ]] ; then #use hypervisor config
cp -b /opt/skywire/skywire.json /opt/skywire/skywire-visor.json.gen
else  #error here
echo "expected visor or hypervisor configuration file not found!"
echo "there is a problem with the expected skywire configuration which requires manual intervenion."
exit 100
fi
fi

#generate visor configuration
echo "Setting hypervisors:"
echo "${_hvk}"
if [[ $(skywire-cli visor gen-config --hypervisor-pks $_hvk -p -r -o /opt/skywire/skywire-visor.json.gen) ]]; then
  echo "Generated skywire visor configuration!"
else
  echo ">>> FATAL: skywire not installed or installation not detected! Could not generate configuration file!"
  echo "this should never happen"
  exit 100
fi
mv /opt/skywire/skywire-visor.json.gen /opt/skywire/skywire-visor.json
systemctl enable --now skywire-visor.service
```

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
