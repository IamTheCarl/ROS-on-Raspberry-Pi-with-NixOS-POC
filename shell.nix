# Environment containing basic ROS2 tools

{ pkgs ? import <nixpkgs> {} }:
let
  # Obtain ROS overlays
  ros = import (fetchTarball "https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz") { };
in
ros.pkgs.mkShell {
  nativeBuildInputs = [
    (ros.rosPackages.humble.buildEnv {
      paths = [
        ros.rosPackages.humble.ros-core
        ros.pkgs.colcon
      ];
    })
  ];
}
