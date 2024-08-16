{ lib, ... }:
let
  pkgs = import ./ros.nix {}; 
  env = (import ./environment.nix { pkgs = pkgs; });

  getSshKeys = username:
    lib.splitString "\n"
      (builtins.readFile
        (builtins.fetchurl
          "https://github.com/${username}.keys"));
in
{
  system.stateVersion = "24.04";

  # Networking
  systemd.network.enable = true;
  networking.useNetworkd = true;
  networking.hostName = "rosetta";

  # SSH
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  users.extraUsers.root.openssh.authorizedKeys.keys = getSshKeys "IamTheCarl";

  # imports = let
  #   nix-ros-overlay = builtins.fetchTarball {
  #     url = https://github.com/lopsided98/nix-ros-overlay/archive/69219f8f35e5ae08e4ccff256529355744bc06ba.tar.gz;
  #     sha256 = "146nng97pgplv703y18y30ybl4z9zdj9sr7c4jiyalhgl7jcwvsj";
  #   };
  # in [ (nix-ros-overlay + "/modules") ];

  # Install system packages.
  environment.systemPackages = [
    pkgs.vim
    pkgs.htop
    env
  ];

  # services.ros2 = {
  #   enable = true;
  #   distro = "humble";
  #   domainId = 0;
  #   nodes = {
  #     piper = {
  #       package = "piper";
  #       env = env;
  #       node = "piper";
  #       args = [];
  #       rosArgs = [];
  #       params = {};
  #     };
  #   };
  # };
}
