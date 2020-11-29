**PENDING UPDATE ; RETAINED FROM REPOSITORY MIGRATION. PLEASE DISREGARD AT THIS TIME.**

## Release Images
The [release section](https://github.com/Skyfleet/armbian/releases) of [this repository](https://github.com/skyfleet/armbian) contains [Skybian](https://github.com/skycoin/skybian) and [Skyraspbian](https://github.com/asxtree/skybian/tree/skyraspbian) images which have been modified with a package-based [Skywire](https://github.com/skycoin/skywire) installation.

These images are updated as new upstream versions are released:

* Download [skyfleet_skybian_v0.1.2-1](https://github.com/Skyfleet/armbian/releases/download/images/skyfleet_skybian_v0.1.2-1.img.tar.gz) for orange pi prime
* Download [skyfleet-skyraspbian-v0.1.2-1](https://github.com/Skyfleet/armbian/releases/download/images/skyfleet-skyraspbian-v0.1.2-1.img.tar.gz) for rpi3 / rpi4

NOTE: The skywire package has been installed over the existing skywire installation (of skybian and skyraspbian). The release images _can be used with skyimager_ in order to generate fully configured ip-preset images; refer to the [skyimager user guide](https://github.com/skycoin/skywire/wiki/Skyimager-User-Guide) in the skywire wiki for details on using skyimager and writing an image to a microSD card.

These images may also be used on their own with additional manual configuration (see step 4).



**NOTE: THE REPOSITORY HAS ALREADY BEEN CONFIGURED AND THE SKYWIRE PACKAGE HAS BEEN INSTALLED IN THE RELEASE IMAGES**

It is recommended to regenerate the configuration files and then edit them; adding the hypervisor key as specified in [the readme of skywire-mainnet](https://github.com/skycoin/skywire).

**PLEASE DO NOT DO THE FOLLOWING STEPS IF YOU ARE USING A RELEASE IMAGE**


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
