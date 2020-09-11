[This Repository](https://github.com/skyfleet/armbian) contains [Skybian](https://github.com/skycoin/skybian) and Skyraspbian images which have been modified with a package-based [Skywire](https://github.com/SkycoinProject/skywire-mainnet) installation.

This repository acts as a debian package repository which can be used by adding  configured in `/etc/apt/sources.list`

**NOTE: THE REPOSITORY HAS ALREADY BEEN CONFIGURED AND THE SKYWIRE PACKAGE HAS BEEN INSTALLED IN THE RELEASE IMAGES**

**PLEASE DO NOT DO THE FOLLOWING STEPS IF YOU ARE USING A RELEASE IMAGE**

NOTE: because the skywire package has been installed over the existing skywire installation in skybian and skyraspbian, the release images can be used with skyimager in order to generate fully configured ip-preset images.

## To Use This Package Repository (with an existing debian system) -

**ALL COMMANDS SHOULD BE RUN AS ROOT OR WITH SUDO**

### 1) Add this repository to your apt sources

(as root or use sudo):
```
add-apt-repository 'deb http://skyfleet.github.io/armbian sid main'
```

If `add-apt-repository` is not be available; `apt install software-properties-common`
or manually edit your `/etc/apt/sources.list` (as root or use sudo):
```
nano /etc/apt/sources.list
```

Add the following:
```
deb http://skyfleet.github.io/armbian sid main
# deb-src http://skyfleet.github.io/armbian sid main
```

### 2) Add the repository signing key

(as root or use sudo)
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

At the point you have completed the above, skywire is installed.

**However**, you must still create and edit the skywire-hypervisor and skywire-visor .json files

These files **must** be at the following paths for the included skywire-visor and skywire-hypervisor systemd services to work.
```
/etc/skywire-hypervisor.json
/etc/skywire-visor.json
```

Please follow the documentation [in the readme of skywire-mainnet](https://github.com/skycoinproject/skywire-mainnet)
or ask in [the skywire telegram channel](https://t.me/skywire)

When you have completed the configuration, start the hypervisor and/or visor systemd service, then view the hypervisor's web interface to make sure everything worked.

### 5) Updating your system and the skywire installation.
(as root)
```
apt update
apt upgrade
```
