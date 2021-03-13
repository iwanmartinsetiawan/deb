### skywire-bin Version: 0.4.0 Release: 1

 The skywire 0.4.0 binary release has been added to the package repository.

 This package release includes the autoconfiguration script `skywire-autoconfig` which is included in the skywire package; however due to the nature of a binary release package, I have not included the `skycache` package-cache server binary or the scripts which rely on skycache. This includes the hypervisor key package generation and distribution method.

Previous release notes

### Version: 0.3.0 Release: 2

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
