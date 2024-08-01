{ pkgs ? import <nixpkgs> {} }:
let
  ros = import ../../ros.nix {};
in
ros.rosPackages.humble.buildRosPackage {
  pname = "piper";
  version = "0.1.0";
  src = ./.;

  buildType = "ament_python";

  # Nix packages to be provided in the runtime environment.
  propagatedBuildInputs = [
    pkgs.piper-tts
    pkgs.alsa-utils
    (pkgs.python3.withPackages (
      python-pkgs: [
        python-pkgs.pyxdg
      ]
    ))
    (import ./voice_models/en_US-hfc_male-medium/default.nix {})
    (import ../piper_interface/default.nix {})
  ];

  meta = {
    description = "Provides service to play audio with piper";
  };
}
