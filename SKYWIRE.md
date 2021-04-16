# Skywire .deb Package Hierarchy

### Storage Paths

#### Binaries
- respectively located in `/opt/skywire/bin`:
  - `skywire-cli` symlinked to `/usr/bin/skywire-cli`
  - `skywire-visor` symlinked to `/usr/bin/skywire`

#### Systemd Service Files
- Skywire hypervisor systemd service file is located in `/etc/systemd/system/skywire.service` and relies on the config at `/opt/skywire/skywire.json`
- Skywire visor systemd service file is located in `/etc/systemd/system/skywire-visor.service`  and relies on the config at `/opt/skywire/skywire-visor.json`

#### Skywire Visor Config
- Skywire visor file is located in `/opt/skywire/skywire-visor.json`
- Skywire hypervisor file is located in `/opt/skywire/skywire.json`
- All other config paths should be inside `/opt/skywire`

#### Apps
- App binaries are located in `/opt/skywire/apps` and symlinked to `/usr/bin`:
  - `skychat`
  - `skysocks`
  - `skysocks-client`
  - `vpn-client`
  - `vpn-server`
