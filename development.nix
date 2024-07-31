{ pkgs ? import <nixpkgs> {} }:
let
  ros = import ./ros.nix {};
in
ros.pkgs.mkShell {
  nativeBuildInputs = [
    (ros.rosPackages.humble.buildEnv {
      paths = [
        (import ./environment.nix {})
        ros.rosPackages.humble.turtlesim
        ros.rosPackages.humble.rqt
        ros.rosPackages.humble.rqt-action
        ros.rosPackages.humble.rqt-bag
        ros.rosPackages.humble.rqt-bag-plugins
        ros.rosPackages.humble.rqt-common-plugins
        ros.rosPackages.humble.rqt-console
        ros.rosPackages.humble.rqt-controller-manager
        ros.rosPackages.humble.rqt-gauges
        ros.rosPackages.humble.rqt-graph
        ros.rosPackages.humble.rqt-gui
        ros.rosPackages.humble.rqt-gui-cpp
        ros.rosPackages.humble.rqt-gui-py
        ros.rosPackages.humble.rqt-image-overlay
        ros.rosPackages.humble.rqt-image-overlay-layer
        ros.rosPackages.humble.rqt-image-view
        ros.rosPackages.humble.rqt-joint-trajectory-controller
        ros.rosPackages.humble.rqt-mocap4r2-control
        ros.rosPackages.humble.rqt-moveit
        ros.rosPackages.humble.rqt-msg
        ros.rosPackages.humble.rqt-plot
        ros.rosPackages.humble.rqt-publisher
        ros.rosPackages.humble.rqt-py-common
        ros.rosPackages.humble.rqt-py-console
        ros.rosPackages.humble.rqt-reconfigure
        ros.rosPackages.humble.rqt-robot-dashboard
        ros.rosPackages.humble.rqt-robot-monitor
        ros.rosPackages.humble.rqt-robot-steering
        ros.rosPackages.humble.rqt-runtime-monitor
        ros.rosPackages.humble.rqt-service-caller
        ros.rosPackages.humble.rqt-shell
        ros.rosPackages.humble.rqt-srv
        ros.rosPackages.humble.rqt-tf-tree
        ros.rosPackages.humble.rqt-topic
      ];
    })
  ];
  shellHook = ''
    eval "$(register-python-argcomplete ros2)"
    eval "$(register-python-argcomplete colcon)"
    eval "$(register-python-argcomplete rosidl)"
  '';
}
