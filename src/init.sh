#!/usr/bin/env bash

check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 1>&2
    exit 1
  fi
}

has_os_release_file() {
  [ -f /etc/os-release ]
}

detect_distro() {
  if has_os_release_file; then
    . /etc/os-release
    OS=$NAME
  else
    echo "This script requires a system with /etc/os-release" 1>&2
    exit 1
  fi
}

main() {
  check_root
  detect_distro

  case "$DISTRO" in
    "Ubuntu")
      echo "Detected Debian-Based Linux"
      install_ubuntu
      ;;
    "Fedora Linux")
      echo "Detected Fedora Linux"
      install_fedora
      ;;
    *)
      echo "Unknown distribution: $DISTRO - Exiting" 1>&2
      exit 1
      ;;
  esac
}

install_ubuntu() {
  ./install_ubuntu.sh
}

install_fedora() {
  ./install_fedora.sh
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi