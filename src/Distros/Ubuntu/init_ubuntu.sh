#!/usr/bin/env bash

main(){
  give_permission_to_execute
  ./base_apt_installations.sh
  ./flatpak.sh
  ./brave.sh
}

give_permission_to_execute(){
  echo "Giving permission to execute"
  chmod +x ./base_apt_installations.sh
  chmod +x ./flatpak.sh
  chmod +x ./brave.sh
}