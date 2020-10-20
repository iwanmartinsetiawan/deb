# Maintainer: Moses Narrow <moe_narrow@use.startmail.com>
# Maintainer: Rudi [KittyCash] <rudi@skycoinmail.com>
_projectname=skycoin
_pkgarch=amd64
pkgname=skywire
_pkgname=skywire
_pkgname1=skywire-mainnet
_githuborg=${projectname}
pkgdesc="Skywire: Building a New Internet. Skycoin.com"
_pkgver1='0.2.4'
_tag_ver='v0.2.4'
pkgver=${_pkgver1//-/.}
_pkggopath="github.com/${_githuborg}/${_pkgname1}"
pkgrel=1
arch=('any')
url="https://${_pkggopath}"
license=()
makedepends=(git skycoin-keyring)
depends=()
#_debdeps="reprepro"
_debdeps=""
provides=(skywire)
source=("git+${url}.git#branch=${BRANCH:-master}"
#"postinst.sh"
'skywire-hypervisor.service'
'skywire-visor.service'
'certificate.cnf'
'generate.sh'
#'readonlycache.go')
sha256sums=('SKIP'
#            '4f0d45eee6050871875011618e0ba989d723c18108e8c996a76d47fba24ec2fb'
            '99a01866a21a02b7c972262cb054da718419d4e8d37dcd36cefbb5b17d877867'
            'd891297b28463e9ac8f765a95fc1d0488b51d01f47692a7aa62a3ac0baa443ac'
            'eafd78dd0cc9875eabac1017478d4f06361abf2021bd94ad052056284f7bb3d9'
            '7c7e7713c14a949f44faac18c3badee87e3c99987aaaa28a6ebef5022dd13f86')
            #'a44f65d1d3b218512556d8a4a44fbe9c65f4d64cc699859157aa9568cee5422e')

_buildamd64=(env GOOS=linux GOARCH=amd64)
_buildarm64=(env GOOS=linux GOARCH=arm64)
_buildarmhf=(env GOOS=linux GOARCH=arm GOARM=6)

prepare() {
  # https://wiki.archlinux.org/index.php/Go_package_guidelines
	mkdir -p ${srcdir}/go/src/github.com/${_githuborg}/ ${srcdir}/go/binamd64 ${srcdir}/go/appsamd64 ${srcdir}/go/binarm64 ${srcdir}/go/appsarm64 ${srcdir}/go/binarmhf ${srcdir}/go/appsarmhf
  ln -rTsf ${srcdir}/${_pkgname1} ${srcdir}/go/src/${_pkggopath}
  cd ${srcdir}/go/src/${_pkggopath}/
}


build() {
  cd ${srcdir}/go/src/${_pkggopath}
  #build hypervisor UI
  make install-deps-ui
  make lint-ui
  make build-ui

  build1()
  build2()
  build3()
}

build1() {
  _pkgarch=amd64
  export GOPATH=${srcdir}/go
  export GOBIN=${GOPATH}/bin-${_pkgarch}
  export GOAPPS=${GOPATH}/apps-${_pkgarch}
  export PATH=${GOPATH}/bin:${PATH}
  #build binaries
  _cmddir=${srcdir}/go/src/${_pkggopath}/cmd
  #using go build for determinism
  msg2 'building skychat binary'
	cd ${_cmddir}/apps/skychat
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skysocks binary'
  cd ${_cmddir}/apps/skysocks
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skysocks-client binary'
  cd ${_cmddir}/apps/skysocks-client
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building vpn-client binary'
  cd ${_cmddir}/apps/vpn-client
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building vpn-server binary'
  cd ${_cmddir}/apps/vpn-server
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skywire-visor binary'
  cd ${_cmddir}/skywire-visor
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building skywire-cli binary'
  cd ${_cmddir}/skywire-cli
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building setup-node binary'
	cd ${_cmddir}/setup-node
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building hypervisor binary'
	cd ${_cmddir}/hypervisor
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  #binary transparency
  cd $GOBIN
  msg2 'binary sha256sums'
  sha256sum $(ls)
  cd $GOAPPS
  sha256sum $(ls)

#fix name of hypervisor binary
mv $GOBIN/hypervisor $GOBIN/${_pkgname}-hypervisor

#create control file for the debian package
echo "Package: skywire" > ${srcdir}/control-${_pkgarch}
echo "Version: ${pkgver}-${pkgrel}" >> ${srcdir}/control-${_pkgarch}
echo "Priority: optional" >> ${srcdir}/control-${_pkgarch}
echo "Section: web" >> ${srcdir}/control-${_pkgarch}
echo "Architecture: ${_pkgarch}" >> ${srcdir}/control-${_pkgarch}
echo "Depends: ${_debdeps}" >> ${srcdir}/control-${_pkgarch}
echo "Maintainer: Skyfleet" >> ${srcdir}/control-${_pkgarch}
echo "Description: ${pkgdesc}" >> ${srcdir}/control-${_pkgarch}

}

build2() {
  _pkgarch=arm64
  export GOPATH=${srcdir}/go
  export GOBIN=${GOPATH}/bin-${_pkgarch}
  export GOAPPS=${GOPATH}/apps-${_pkgarch}
  export PATH=${GOPATH}/bin:${PATH}
  #build binaries
  _cmddir=${srcdir}/go/src/${_pkggopath}/cmd
  #using go build for determinism
  msg2 'building skychat binary'
	cd ${_cmddir}/apps/skychat
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skysocks binary'
  cd ${_cmddir}/apps/skysocks
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skysocks-client binary'
  cd ${_cmddir}/apps/skysocks-client
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building vpn-client binary'
  cd ${_cmddir}/apps/vpn-client
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building vpn-server binary'
  cd ${_cmddir}/apps/vpn-server
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skywire-visor binary'
  cd ${_cmddir}/skywire-visor
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building skywire-cli binary'
  cd ${_cmddir}/skywire-cli
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building setup-node binary'
	cd ${_cmddir}/setup-node
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building hypervisor binary'
	cd ${_cmddir}/hypervisor
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  #binary transparency
  cd $GOBIN
  msg2 'binary sha256sums'
  sha256sum $(ls)
  cd $GOAPPS
  sha256sum $(ls)

#fix name of hypervisor binary
mv $GOBIN/hypervisor $GOBIN/${_pkgname}-hypervisor

#create control file for the debian package
echo "Package: skywire" > ${srcdir}/control-${_pkgarch}
echo "Version: ${pkgver}-${pkgrel}" >> ${srcdir}/control-${_pkgarch}
echo "Priority: optional" >> ${srcdir}/control-${_pkgarch}
echo "Section: web" >> ${srcdir}/control-${_pkgarch}
echo "Architecture: ${_pkgarch}" >> ${srcdir}/control-${_pkgarch}
echo "Depends: ${_debdeps}" >> ${srcdir}/control-${_pkgarch}
echo "Maintainer: Skyfleet" >> ${srcdir}/control-${_pkgarch}
echo "Description: ${pkgdesc}" >> ${srcdir}/control-${_pkgarch}
}

build3() {
  _pkgarch=armhf
  export GOPATH=${srcdir}/go
  export GOBIN=${GOPATH}/bin-${_pkgarch}
  export GOAPPS=${GOPATH}/apps-${_pkgarch}
  export PATH=${GOPATH}/bin:${PATH}
  #build binaries
  _cmddir=${srcdir}/go/src/${_pkggopath}/cmd
  #using go build for determinism
  msg2 'building skychat binary'
	cd ${_cmddir}/apps/skychat
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skysocks binary'
  cd ${_cmddir}/apps/skysocks
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skysocks-client binary'
  cd ${_cmddir}/apps/skysocks-client
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building vpn-client binary'
  cd ${_cmddir}/apps/vpn-client
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building vpn-server binary'
  cd ${_cmddir}/apps/vpn-server
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOAPPS/ .
  msg2 'building skywire-visor binary'
  cd ${_cmddir}/skywire-visor
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building skywire-cli binary'
  cd ${_cmddir}/skywire-cli
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building setup-node binary'
	cd ${_cmddir}/setup-node
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  msg2 'building hypervisor binary'
	cd ${_cmddir}/hypervisor
  go build -trimpath -ldflags '-extldflags ${LDFLAGS}' -ldflags=-buildid= -o $GOBIN/ .
  #binary transparency
  cd $GOBIN
  msg2 'binary sha256sums'
  sha256sum $(ls)
  cd $GOAPPS
  sha256sum $(ls)

#fix name of hypervisor binary
mv $GOBIN/hypervisor $GOBIN/${_pkgname}-hypervisor

#create control file for the debian package
echo "Package: skywire" > ${srcdir}/control-${_pkgarch}
echo "Version: ${pkgver}-${pkgrel}" >> ${srcdir}/control-${_pkgarch}
echo "Priority: optional" >> ${srcdir}/control-${_pkgarch}
echo "Section: web" >> ${srcdir}/control-${_pkgarch}
echo "Architecture: ${_pkgarch}" >> ${srcdir}/control-${_pkgarch}
echo "Depends: ${_debdeps}" >> ${srcdir}/control-${_pkgarch}
echo "Maintainer: Skyfleet" >> ${srcdir}/control-${_pkgarch}
echo "Description: ${pkgdesc}" >> ${srcdir}/control-${_pkgarch}
}

package() {
  pkg_amd64()
  pkg_arm64()
  pkg_armhf()

exit
}

package1() {
_pkgarch=amd64
export GOPATH=${srcdir}/go
export GOBIN=${GOPATH}/bin-${_pkgarch}
export GOAPPS=${GOPATH}/apps-${_pkgarch}
export PATH=${GOPATH}/bin:${PATH}

#set up to create a .deb package
_debpkgdir=${_pkgname}-${pkgver}-${pkgrel}-${_pkgarch}
_pkgdir=${pkgdir}/${_debpkgdir}

#install skywire binaries
msg2 'installing binaries'
install -Dm755 $GOBIN/${_pkgname}-hypervisor ${_pkgdir}/usr/bin/${_pkgname}-hypervisor
install -Dm755 $GOBIN/${_pkgname}-visor ${_pkgdir}/usr/bin/${_pkgname}-visor
install -Dm755 $GOBIN/${_pkgname}-cli ${_pkgdir}/usr/bin/${_pkgname}-cli
_skywireapps=$( ls $GOAPPS )
for i in ${_skywireapps}; do
  install -Dm755 ${srcdir}/apps/${i} ${_pkgdir}/usr/bin/apps/${i}
done

#install the system.d services
install -Dm644 ${srcdir}/${_pkgname}-hypervisor.service ${_pkgdir}/etc/systemd/system/${_pkgname}-hypervisor.service
install -Dm644 ${srcdir}/${_pkgname}-visor.service ${_pkgdir}/etc/systemd/system/${_pkgname}-visor.service

#tls key and certificate generation
install -Dm755 ${srcdir}/generate.sh ${_pkgdir}/usr/lib/skycoin/skywire/ssl/generate.sh
ln -rTsf ${_pkgdir}/usr/lib/skycoin/skywire/ssl/generate.sh ${_pkgdir}/usr/bin/skywire-tls-gen
install -Dm644 ${srcdir}/certificate.cnf ${_pkgdir}/usr/lib/skycoin/skywire/ssl/certificate.cnf

#install the readonly-cache binary
#install -Dm755 ${srcdir}/readonlycache ${_pkgdir}/usr/bin/readonlycache

#install the control file and postinst script for the debian package
install -Dm755 ${srcdir}/control${_pkgarch} ${_pkgdir}/DEBIAN/control
#install -Dm755 ${srcdir}/postinst.sh ${_pkgdir}/DEBIAN/postinst

#create the debian package
cd $pkgdir
dpkg-deb --build ${_debpkgdir}
mv *.deb ../../
}

package2() {
  _pkgarch=arm64
  export GOPATH=${srcdir}/go
  export GOBIN=${GOPATH}/bin-${_pkgarch}
  export GOAPPS=${GOPATH}/apps-${_pkgarch}
  export PATH=${GOPATH}/bin:${PATH}

  #set up to create a .deb package
  _debpkgdir=${_pkgname}-${pkgver}-${pkgrel}-${_pkgarch}
  _pkgdir=${pkgdir}/${_debpkgdir}

  #install skywire binaries
  msg2 'installing binaries'
  install -Dm755 $GOBIN/${_pkgname}-hypervisor ${_pkgdir}/usr/bin/${_pkgname}-hypervisor
  install -Dm755 $GOBIN/${_pkgname}-visor ${_pkgdir}/usr/bin/${_pkgname}-visor
  install -Dm755 $GOBIN/${_pkgname}-cli ${_pkgdir}/usr/bin/${_pkgname}-cli
  _skywireapps=$( ls $GOAPPS )
  for i in ${_skywireapps}; do
    install -Dm755 ${srcdir}/apps/${i} ${_pkgdir}/usr/bin/apps/${i}
  done

  #install the system.d services
  install -Dm644 ${srcdir}/${_pkgname}-hypervisor.service ${_pkgdir}/etc/systemd/system/${_pkgname}-hypervisor.service
  install -Dm644 ${srcdir}/${_pkgname}-visor.service ${_pkgdir}/etc/systemd/system/${_pkgname}-visor.service

  #tls key and certificate generation
  install -Dm755 ${srcdir}/generate.sh ${_pkgdir}/usr/lib/skycoin/skywire/ssl/generate.sh
  ln -rTsf ${_pkgdir}/usr/lib/skycoin/skywire/ssl/generate.sh ${_pkgdir}/usr/bin/skywire-tls-gen
  install -Dm644 ${srcdir}/certificate.cnf ${_pkgdir}/usr/lib/skycoin/skywire/ssl/certificate.cnf

  #install the readonly-cache binary
  #install -Dm755 ${srcdir}/readonlycache ${_pkgdir}/usr/bin/readonlycache

  #install the control file and postinst script for the debian package
  install -Dm755 ${srcdir}/control${_pkgarch} ${_pkgdir}/DEBIAN/control
  #install -Dm755 ${srcdir}/postinst.sh ${_pkgdir}/DEBIAN/postinst

  #create the debian package
  cd $pkgdir
  dpkg-deb --build ${_debpkgdir}
  mv *.deb ../../
}
package3() {
  _pkgarch=armhf
  export GOPATH=${srcdir}/go
  export GOBIN=${GOPATH}/bin-${_pkgarch}
  export GOAPPS=${GOPATH}/apps-${_pkgarch}
  export PATH=${GOPATH}/bin:${PATH}

  #set up to create a .deb package
  _debpkgdir=${_pkgname}-${pkgver}-${pkgrel}-${_pkgarch}
  _pkgdir=${pkgdir}/${_debpkgdir}

  #install skywire binaries
  msg2 'installing binaries'
  install -Dm755 $GOBIN/${_pkgname}-hypervisor ${_pkgdir}/usr/bin/${_pkgname}-hypervisor
  install -Dm755 $GOBIN/${_pkgname}-visor ${_pkgdir}/usr/bin/${_pkgname}-visor
  install -Dm755 $GOBIN/${_pkgname}-cli ${_pkgdir}/usr/bin/${_pkgname}-cli
  _skywireapps=$( ls $GOAPPS )
  for i in ${_skywireapps}; do
    install -Dm755 ${srcdir}/apps/${i} ${_pkgdir}/usr/bin/apps/${i}
  done

  #install the system.d services
  install -Dm644 ${srcdir}/${_pkgname}-hypervisor.service ${_pkgdir}/etc/systemd/system/${_pkgname}-hypervisor.service
  install -Dm644 ${srcdir}/${_pkgname}-visor.service ${_pkgdir}/etc/systemd/system/${_pkgname}-visor.service

  #tls key and certificate generation
  install -Dm755 ${srcdir}/generate.sh ${_pkgdir}/usr/lib/skycoin/skywire/ssl/generate.sh
  ln -rTsf ${_pkgdir}/usr/lib/skycoin/skywire/ssl/generate.sh ${_pkgdir}/usr/bin/skywire-tls-gen
  install -Dm644 ${srcdir}/certificate.cnf ${_pkgdir}/usr/lib/skycoin/skywire/ssl/certificate.cnf

  #install the readonly-cache binary
  #install -Dm755 ${srcdir}/readonlycache ${_pkgdir}/usr/bin/readonlycache

  #install the control file and postinst script for the debian package
  install -Dm755 ${srcdir}/control${_pkgarch} ${_pkgdir}/DEBIAN/control
  #install -Dm755 ${srcdir}/postinst.sh ${_pkgdir}/DEBIAN/postinst

  #create the debian package
  cd $pkgdir
  dpkg-deb --build ${_debpkgdir}
  mv *.deb ../../
}
