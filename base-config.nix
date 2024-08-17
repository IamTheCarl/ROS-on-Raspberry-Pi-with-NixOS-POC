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

  # You can enable logging in as the ROS user by uncommenting these.
  # users.extraUsers.ros.openssh.authorizedKeys.keys = getSshKeys "IamTheCarl";
  # users.users.ros.isSystemUser = lib.mkForce false;
  # users.users.ros.isNormalUser = lib.mkForce true;

  # Grabs your public keys from Github so you can log in.
  # Replace "IamTheCarl" with your github username.
  users.extraUsers.root.openssh.authorizedKeys.keys = getSshKeys "IamTheCarl";

  imports = let
    nix-ros-overlay = builtins.fetchTarball {
      url = https://github.com/lopsided98/nix-ros-overlay/archive/69219f8f35e5ae08e4ccff256529355744bc06ba.tar.gz;
      sha256 = "146nng97pgplv703y18y30ybl4z9zdj9sr7c4jiyalhgl7jcwvsj";
    };
  in [ (nix-ros-overlay + "/modules") ];

  # Install system packages.
  environment.systemPackages = [
    pkgs.vim
    pkgs.htop
    env
  ];

  # Starting this daemon fixes discovery issues between the ros and root users.
  systemd.services.ros_daemon = {
    description = "ROS discovery daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${env}/bin/ros2 daemon start";
      User = "ros";
      Group = "ros";
    };
    environment = {
      ROS_DOMAIN_ID = "0";
      ROS_HOME = "/var/lib/ros";
    };
  };

  services.ros2 = {
    enable = true;
    distro = "humble";
    domainId = 0;
    nodes = {
      piper = {
        package = "piper";
        env = env;
        node = "piper";
        args = [];
        rosArgs = [];
        params = {};
      };
    };
  };
}
