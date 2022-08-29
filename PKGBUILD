# Maintainer: William C. Canin <wcanin.contact@gmail.com>

pkgname=honeygain-manager
pkgver=0.1.0
pkgrel=1
pkgdesc='Honeygain Manager - Package for Arch Linux that creates a service for Honeygain'
arch=('any')
url='https://github.com/williamcanin/honeygain-manager.git'
license=('MIT')
depends=('docker' 'systemd' 'jq' 'sudo')
source=('honeygain-manager.sh' 'honeygain-manager.service' 'honeygain-manager.conf')
sha512sums=('SKIP' 'SKIP' 'SKIP')

package() {

  install -Dm 777 "${srcdir}"/honeygain-manager.conf "${pkgdir}"$HOME/.config/honeygain-manager.conf

  install -Dm 755 "${srcdir}"/honeygain-manager.sh "${pkgdir}"/usr/bin/honeygain-manager
  chmod +x "${pkgdir}"/usr/bin/honeygain-manager

  install -Dm 644 "${srcdir}"/honeygain-manager.service -t "${pkgdir}"/usr/lib/systemd/user

}
