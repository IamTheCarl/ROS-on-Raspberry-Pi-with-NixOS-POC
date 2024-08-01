{ pkgs ? import <nixpkgs> {} }:
let
  ros = import ../../ros.nix {};
in
ros.rosPackages.humble.buildRosPackage {
  pname = "piper_interface";
  version = "0.1.0";
  src = ./.;

  buildType = "ament_cmake";
  buildInputs = [ ros.rosPackages.humble.ament-cmake ros.rosPackages.humble.rosidl-default-generators ];
  propagatedBuildInputs = [ ros.rosPackages.humble.rosidl-default-runtime ];
  nativeBuildInputs = [ ros.rosPackages.humble.ament-cmake ros.rosPackages.humble.rosidl-default-generators ];

  meta = {
    description = "Provides messages and services for piper node";
  };
}
