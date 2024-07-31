{ pkgs ? import <nixpkgs> {} }:
let
  # Obtain ROS overlays
  ros = import (fetchTarball "https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz") { };
in
(ros.rosPackages.humble.buildEnv {
  paths = [
    pkgs.vim
    ros.rosPackages.humble.ros-core
    ros.rosPackages.humble.ros2cli
    ros.pkgs.colcon
  ];
})
