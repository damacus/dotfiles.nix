{pkgs, config, ...}: {
  home.packages = if pkgs.stdenv.isLinux then with pkgs; [
    docker-compose
    podman
    podman-compose
    podman-tui      # status of containers in the terminal
    buildah         # build container images
    skopeo         # transfer container images between registries
    runc           # container runtime
    fuse-overlayfs # needed for rootless containers
  ] else [];

  xdg.configFile = {
    "containers/containers.conf" = {
      text = ''
        [network]
        network_backend="netavark"

        [machine]
        cpus=2
        memory=2048
      '';
    };

    # Storage configuration
    "containers/storage.conf" = {
      text = ''
        [storage]
        driver = "overlay"
        runroot = "/run/user/1000"
        graphroot = "/home/${config.home.username}/.local/share/containers/storage"

        [storage.options]
        mount_program = "/usr/bin/fuse-overlayfs"
        additionalimagestores = [
          "/var/lib/shared/containers/storage"
        ]

        [storage.options.overlay]
        mountopt = "nodev,metacopy=on"

        [storage.options.tls]
        min_version = "1.3"
      '';
    };
  };
}
