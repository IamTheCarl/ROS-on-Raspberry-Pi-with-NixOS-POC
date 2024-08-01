{ pkgs ? import <nixpkgs> {} }:
let
  ros = import ./ros.nix {};
in
(ros.rosPackages.humble.buildEnv {
  paths = [
    pkgs.vim
    ros.rosPackages.humble.ros-core
    (import ./nodes/piper {})
  ];
})
