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

  # Config
  # install -Dm 644 "${srcdir}"/honeygain-manager.conf "${pkgdir}"/etc/honeygain.conf

  # Script
  # install -Dm 755 "${srcdir}"/honeygain-manager.sh "${pkgdir}"/usr/bin/honeygain-manager
  # chmod +x "${pkgdir}"/usr/bin/honeygain-manager

  # Service
  # install -Dm 644 "${srcdir}"/honeygain-manager.service -t "${pkgdir}"/usr/lib/systemd/system


  # mkdir -p "${pkgdir}"$HOME/.config/
  # cp -f "${srcdir}"/honeygain-manager.conf "${pkgdir}"$HOME/.config/honeygain-manager.conf
  # chmod 777 "${pkgdir}"$HOME/.config/honeygain-manager.conf


  # mkdir -p "${pkgdir}"$HOME/.local/bin
  # cp -f "${srcdir}"/honeygain-manager.sh "${pkgdir}"$HOME/.local/bin/honeygain-manager
  # chmod 777 "${pkgdir}"$HOME/.local/bin/honeygain-manager
  # chmod +x "${pkgdir}"$HOME/.local/bin/honeygain-manager


  # # install -Dm 644 "${srcdir}"/honeygain-manager.service -t "${pkgdir}"/usr/lib/systemd/user
  # install -Dm 644 "${srcdir}"/honeygain-manager.service -t "${pkgdir}"$HOME/.config/systemd/user



  install -Dm 777 "${srcdir}"/honeygain-manager.conf "${pkgdir}"$HOME/.config/honeygain-manager.conf

  install -Dm 755 "${srcdir}"/honeygain-manager.sh "${pkgdir}"/usr/bin/honeygain-manager
  chmod +x "${pkgdir}"/usr/bin/honeygain-manager

  install -Dm 644 "${srcdir}"/honeygain-manager.service -t "${pkgdir}"$HOME/.config/systemd/user

}
