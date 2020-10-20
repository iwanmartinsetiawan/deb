## Release Images

The [release section](https://github.com/Skyfleet/armbian/releases) of [this repository](https://github.com/skyfleet/armbian) contains [Skybian](https://github.com/skycoin/skybian) and [Skyraspbian](https://github.com/asxtree/skybian/tree/skyraspbian) images which have been modified with a package-based [Skywire](https://github.com/skycoin/skywire) installation.

These images are updated as new upstream versions are released:

* Download [skyfleet_skybian_v0.1.2-1](https://github.com/Skyfleet/armbian/releases/download/images/skyfleet_skybian_v0.1.2-1.img.tar.gz) for orange pi prime
* Download [skyfleet-skyraspbian-v0.1.2-1](https://github.com/Skyfleet/armbian/releases/download/images/skyfleet-skyraspbian-v0.1.2-1.img.tar.gz) for rpi3 / rpi4

NOTE: The skywire package has been installed over the existing skywire installation (of skybian and skyraspbian). The release images _can be used with skyimager_ in order to generate fully configured ip-preset images; refer to the [skyimager user guide](https://github.com/skycoin/skywire/wiki/Skyimager-User-Guide) in the skywire wiki for details on using skyimager and writing an image to a microSD card.

These images may also be used on their own with additional manual configuration (see step 4).

## Package Repository

**NOTE: THE REPOSITORY HAS ALREADY BEEN CONFIGURED AND THE SKYWIRE PACKAGE HAS BEEN INSTALLED IN THE RELEASE IMAGES**

**NOTE: THE PACKAGE REPOSITORY DOES NOT WORK IN CHINA**
**注意：包裹存放区在中国不起作用**

Users inside China can download and install the package like this:
( 中国境内的用户可以像这样下载并安装软件包 )
```
wget -O skywire_0.3.0-1_arm64.deb https://github.com/Skyfleet/armbian/blob/master/pool/main/s/skywire/skywire_0.3.0-1_arm64.deb?raw=true
dpkg -i skywire_0.3.0-1_arm64.deb
```
Remember, you will not have access to automatic updates
( 请记住，您将无权访问自动更新 )

[This Repository](https://skyfleet.github.io/armbian) acts as a debian package repository which can be used to install skywire on .deb based systems of supported architectures (amd64 arm64 armhf)

These packages are updated as new upstream versions are released.

## CURRENT PACKAGE RELEASE NOTES

###Version: 0.3.0

The 0.3.0 release has changed the config file format; the old format and any existing configuration files will not work with the new visor version. See [this issue](https://github.com/skycoin/skywire/issues/564).

It is recommended to regenerate the configuration files and then edit them; adding the hypervisor key as specified in [the readme of skywire-mainnet](https://github.com/skycoin/skywire).

**PLEASE DO NOT DO THE FOLLOWING STEPS IF YOU ARE USING A RELEASE IMAGE**

## To Use This Package Repository (with an existing debian system) -

**ALL COMMANDS SHOULD BE RUN AS ROOT OR WITH SUDO**

### 1) Add this repository to your apt sources

(as root or use sudo):
```
add-apt-repository 'deb http://skyfleet.github.io/armbian sid main'
```

If `add-apt-repository` is not be available, install it with `apt install software-properties-common`
or just manually edit your `/etc/apt/sources.list` (as root or use sudo):
```
nano /etc/apt/sources.list
```

Add the following:
```
deb http://skyfleet.github.io/armbian sid main
# deb-src http://skyfleet.github.io/armbian sid main
```

### 2) Add the repository signing key

as root:
```
curl -L http://skyfleet.github.io/armbian/KEY.asc | apt-key add -
```
with sudo this would be:
```
curl -L http://skyfleet.github.io/armbian/KEY.asc | sudo apt-key add -
```

### 3) Resync the package database:
```
apt update
```

### 4) Install skywire (as root or use sudo):
```
apt install skywire
```

### 5) Configure skywire (as root or use sudo):

At the point you have completed step 4 (or if you are using a release image) skywire is installed.

**However**, you must still create and edit the skywire-hypervisor and skywire-visor .json files

These files **must** be at the following paths for the included skywire-visor and skywire-hypervisor systemd services to work.
```
/etc/skywire-hypervisor.json
/etc/skywire-visor.json
```

Please follow the documentation [in the readme of skywire-mainnet](https://github.com/skycoin/skywire)
or ask in [the skywire telegram channel](https://t.me/skywire)

A brief example of genrating a hypervisor and visor configuration and setting the hypervisor public key is as follows:
```
#generate the hypervisor config:
sudo skywire-hypervisor gen-config -ro /etc/skywire-hypervisor.json
#generate the visor config
sudo skywire-cli visor gen-config -ro /etc/skywire-visor.json
#copy the hypervisor key; to print the file into the terminal use the following command:
cat /etc/skywire-hypervisor.json
#edit the visor's config and add the hypervisor key as it says in the readme for skywire
sudo nano /etc/skywire-visor.json
```

When you have completed the configuration, start the hypervisor and/or visor systemd service:
```
sudo systemctl start skywire-hypervisor
sudo systemctl start skywire-visor
```

Then, view the hypervisor's web interface to make sure everything worked.

**PLEASE NOTE:** the above configuration steps represent only part of the configuration that is created by skyimager. Please refer to the [skybian](https://github.com/skycoin/skybian) repository and / or the skywire wiki for additional information on this configuration.

**Update Tip**
To more easily manage skywire via systemd you can add the following to your `~/.bashrc` or `/etc/profile`
```
##skywire mnagement
alias startvis='sudo systemctl start skywire-visor'
alias stopvis='sudo systemctl stop skywire-visor'
alias starthvis='sudo systemctl start skywire-hypervisor'
alias stophvis='sudo systemctl stop skywire-hypervisor'
```
then you can turn the visor on or off with `startvis` or `stopvis`

**Testing Tip**
The easiest way to tell if skywire is working correctly is to start the visor __manually__ in the terminal. To do this, first symlink the skwire apps directory into your home folder
```
sudo ln -s /usr/bin/apps ~/
```
Then you can start a visor manually with:
```
sudo skywire-visor /etc/skywire-visor.json
```
(Be sure to start the visor via systemd for normal use)

### 5) Updating your system and the skywire installation.
**PLEASE DO NOT USE THE UPDATE BUTTON IN THE HYPERVISOR UI**
**PLEASE DO NOT USE THE UPDATE BUTTON IN THE HYPERVISOR UI**

as root:
```
apt update
apt upgrade
```

Additionally, refer to the notes on the current skywire release at the beginning of this document for details on any manual intervention which is necessary for updates to work. And remember:

**PLEASE DO NOT USE THE UPDATE BUTTON IN THE HYPERVISOR UI**
