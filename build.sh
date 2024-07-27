nix-build '<nixpkgs/nixos>' --option system aarch64-linux --extra-platforms aarch64-linux -A config.system.build.sdImage -I nixos-config=./rpi4-image.nix
