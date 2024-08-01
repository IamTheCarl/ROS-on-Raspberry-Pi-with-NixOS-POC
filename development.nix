{}:
let
  pkgs = import ./ros.nix {};
in
pkgs.pkgs.mkShell {
  nativeBuildInputs = [
    (pkgs.rosPackages.humble.buildEnv {
      paths = [
        (import ./environment.nix { pkgs = pkgs; })
        pkgs.rosPackages.humble.turtlesim
        pkgs.rosPackages.humble.rqt
        pkgs.rosPackages.humble.rqt-action
        pkgs.rosPackages.humble.rqt-bag
        pkgs.rosPackages.humble.rqt-bag-plugins
        pkgs.rosPackages.humble.rqt-common-plugins
        pkgs.rosPackages.humble.rqt-console
        pkgs.rosPackages.humble.rqt-controller-manager
        pkgs.rosPackages.humble.rqt-gauges
        pkgs.rosPackages.humble.rqt-graph
        pkgs.rosPackages.humble.rqt-gui
        pkgs.rosPackages.humble.rqt-gui-cpp
        pkgs.rosPackages.humble.rqt-gui-py
        pkgs.rosPackages.humble.rqt-image-overlay
        pkgs.rosPackages.humble.rqt-image-overlay-layer
        pkgs.rosPackages.humble.rqt-image-view
        pkgs.rosPackages.humble.rqt-joint-trajectory-controller
        pkgs.rosPackages.humble.rqt-mocap4r2-control
        pkgs.rosPackages.humble.rqt-moveit
        pkgs.rosPackages.humble.rqt-msg
        pkgs.rosPackages.humble.rqt-plot
        pkgs.rosPackages.humble.rqt-publisher
        pkgs.rosPackages.humble.rqt-py-common
        pkgs.rosPackages.humble.rqt-py-console
        pkgs.rosPackages.humble.rqt-reconfigure
        pkgs.rosPackages.humble.rqt-robot-dashboard
        pkgs.rosPackages.humble.rqt-robot-monitor
        pkgs.rosPackages.humble.rqt-robot-steering
        pkgs.rosPackages.humble.rqt-runtime-monitor
        pkgs.rosPackages.humble.rqt-service-caller
        pkgs.rosPackages.humble.rqt-shell
        pkgs.rosPackages.humble.rqt-srv
        pkgs.rosPackages.humble.rqt-tf-tree
        pkgs.rosPackages.humble.rqt-topic
      ];
    })
  ];
  shellHook = ''
    eval "$(register-python-argcomplete ros2)"
    eval "$(register-python-argcomplete colcon)"
    eval "$(register-python-argcomplete rosidl)"
  '';
}
