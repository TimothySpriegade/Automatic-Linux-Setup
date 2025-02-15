#!/usr/bin/env bats

load "$BATS_TEST_DIRNAME/../src/init.sh"

@test "check_root fails when not root" {
  # Given
  id() { [[ "$1" == "-u" ]] && echo 1000; }

  # When
  run check_root

  # Then
  [ "$status" -eq 1 ]
  [ "$output" = "This script must be run as root" ]
}

@test "detect_distro fails when /etc/os-release missing" {
  # Given
  has_os_release_file() { return 1; }

  # When
  run detect_distro

  # Then
  [ "$status" -eq 1 ]
  [ "$output" = "This script requires a system with /etc/os-release" ]
}

setup() {
  export DISTRO=""
}

@test "main runs Ubuntu installation" {
  # Given
  check_root() { :; }
  detect_distro() { DISTRO="Ubuntu"; }
  install_ubuntu() { echo "install_ubuntu called"; }

  # When
  run main

  # Then
  [ "$status" -eq 0 ]
  [[ "$output" == *"Detected Debian-Based Linux"* ]]
  [[ "$output" == *"install_ubuntu called"* ]]
}

@test "main runs Fedora installation" {
  # Given
  check_root() { :; }
  detect_distro() { DISTRO="Fedora Linux"; }
  install_fedora() { echo "install_fedora called"; }

  # When
  run main

  # Then
  [ "$status" -eq 0 ]
  [[ "$output" == *"Detected Fedora Linux"* ]]
  [[ "$output" == *"install_fedora called"* ]]
}

@test "main exits on unknown distribution" {
  # Given
  check_root() { :; }
  detect_distro() { DISTRO="Alpine"; }

  # When
  run main

  # Then
  [ "$status" -eq 1 ]
  [[ "$output" == *"Unknown distribution: Alpine - Exiting"* ]]
}