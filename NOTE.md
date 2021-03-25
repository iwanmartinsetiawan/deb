## Build System and Sources:

The build of the .deb packages contained in [this repo](https://github.com/the-skycoin-project/deb) uses `makepkg` (provided by `pacman`) and can be preformed on any [Archlinux](https://archlinux.org) system or Arch-flavored OS such as [EndeavourOS](https://endeavouros.com/).

The build sources for the .deb packages are kept most updated in the archlinux [AUR](https://aur.archlinux.org) repository for the corresponding package.

The pre-compiled binaries included in the packages noted as binary releases are sourced from [https://gihub.com/skycoin](https://gihub.com/skycoin) or [https://skycoin.com](https://skycoin.com)

The packages in this repository have minimal makedependencies; however, they do require `dpkg` be installed on the Archlinux system, which is available from the AUR.

A more flexible system using docker containers and the aforementioned system to build these packages is in development.

## skywire-bin Version: 0.4.1 Release: 2

This minor revision fixes the skywire-autoconfig script that was changed during the previous revision and initial move to 0.4.0.

The satellite packages have been eliminated due to the complexity being greater than the reliability.

As an alternative, a script for setting the hypervisor key on the intended visor after installation of skywire has been provided. `skywire-hypervisorkey` takes one argument; the intended key of the hypervisor.

PLEASE NOTE:
As a revised summary of the process; when skywire is installed from this repository, the `skywire-autoconfig` script called by the postinstall script included with the package will configure automatically a running hypervisor instance (a visor which is it's own hypervisor). By default this will happen. From that point, running `skywire-hypervisorkey` and providing as an argument the desired hypervisor public key, a new configuration is generated from the existing one and the skywire-visor systemd service is enabled after the skywire systemd service is halted. These two systemd services each refer to a dedicated configuration file that must exist for the systemd service to work.

Additional measures have also been take to ensure that a residual skywire installation (such as that which may be found in a preconfigured image) is overwritten with redundant symlinks to the skywire installation provided by the package. The old configuration .json files are not touched. 

## skycoin binary release Version: 0.27.1 Release: 1

The skycoin binary release version 0.27.1  has been added to this package repository

Previous release notes:
## skywire-bin Version: 0.4.1 Release: 1
Increment package version

## skywire-bin Version: 0.4.0 Release: 1

 The skywire 0.4.0 binary release has been added to the package repository.

 This package release includes the autoconfiguration script `skywire-autoconfig` which is included in the skywire package; however due to the nature of a binary release package, I have not included the `skycache` package-cache server binary or the scripts which rely on skycache. This includes the hypervisor key package generation and distribution method.


## Version: 0.3.0 Release: 2

This release has been statically compiled using `musl`

The 0.3.0-2 minor release is built to this commit in the develop branch:
[d156980280fdb2ddfc8765ff77cdd55c0b7e9d9c](https://github.com/skycoin/skywire/commit/d156980280fdb2ddfc8765ff77cdd55c0b7e9d9c)

Significantly, the function of the visor and hypervisor have been merged into a single binary, skywire-visor.
Therefore, the hypervisor public key is now __a visor public key__.

The `skywire-visor` binary is symlinked to the executable PATH at `/usr/bin/skywire` and may be called with:
```
skywire
```

The new location for the skywire installation and all of its components is:
```
/opt/skywire
```

The changes to the source have package-level counterparts (postinstall, postremove scripts) which automate configuration generation __at the point of installation__ and will automatically start a hypervisor in secure mode (password protected and https) when the skywire package is installed.

Running in this mode, as hypervisor, is controlled via the `skywire.service` systemd service and relies on the presence of the configuration file at `/opt/skywire/skywire.json`

The process for setting a remote hypervisor has also been automated at the packaging level using a 'satellite' package called `hypervisorkey`. Release images will contain the necessary pre-configuration for additional automation in the future.

After skywire has been installed on the designated SBC, a message prompts the user to 'run `keypkg-gen` to generate the distributable hypervisor public key package.'

* When `keypkg-gen` is run, a .deb package is created which contains a text file with the hypervisor key (the visor's key).
* This `hypervisorkey.deb` package is added to a local apt repository in `/opt/skywire/apt/repo` ; automatically using the `create-apt-repo` script.
* This package repository is then served on the local network with a simple static golang http server called `readonlycache` which has an accompanying systemd service; `readonly-cache.service`.

At the completion of the script, the user is prompted to run `apt-add-repository` or manually edit `/etc/apt/sources.list` on remote machines which are to be configured as remote visors. At that point, the `hypervisorkey` package can be installed on those machines, and (**assuming this package repository is also configured**) skywire will be installed as a dependancy of the hypervisorkey package. The new configuration using the installed hypervisor key is then automatically generated and skywire is re-started using this configuration. So the visor should appear in the list of visors in the hypervisor UI automatically once this `hypervisorkey` package is installed.

Running in this mode, as visor, is controlled via the `skywire-visor.service` systemd service and relies on the presence of the configuration file at `/opt/skywire/skywire-visor.json`

The visor key for both configuration files remains the same, so you will have the same keys no matter which mode you are running in.
