#!/usr/bin/env bash

main() {
  check_root
  detect_distro

  case "$DISTRO" in
    "Ubuntu")
      echo "Detected Ubuntu Linux"
      install_ubuntu
      install_common_configurations
      ;;
    "Fedora Linux")
      echo "Detected Fedora Linux"
      install_fedora
      install_common_configurations
      ;;
    *)
      echo "Unknown distribution: $DISTRO - Exiting" 1>&2
      exit 1
      ;;
  esac
}

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
    DISTRO=$NAME
  else
    echo "This script requires a system with /etc/os-release" 1>&2
    exit 1
  fi
}

install_common_configurations() {
  echo "Installing common configurations"
  #./install_common.sh
}

install_ubuntu() {
  echo "Installing Ubuntu specific configurations"
  sudo chmod +x ./Distros/Ubuntu/base_apt_installations.sh
  ./Distros/Ubuntu/init_ubuntu.sh
}

install_fedora() {
  echo "Installing Fedora specific configurations"
  #./init_fedora.sh
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi