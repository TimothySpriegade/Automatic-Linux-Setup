#!/usr/bin/env bash

main(){
  give_permission_to_execute
  ./update_system.sh
  ./flatpak.sh
  ./brave.sh
}

give_permission_to_execute(){
  echo "Giving permission to execute"
  sudo chmod +x ./update_system.sh
  sudo chmod +x ./flatpak.sh
  sudo chmod +x ./brave.sh
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi