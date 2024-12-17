{...}: {
  programs.ssh = {
    enable = true;

    includes = [
      "~/.ssh/config.hosts"
    ];

    matchBlocks = {
      "github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
      };

      "*" = {
        serverAliveInterval = 60;
        extraOptions = {
          UseKeychain = "no";
        };
      };
    };

    extraOptionOverrides = {
      ForwardAgent = "yes";
      ForwardX11 = "no";
      ForwardX11Trusted = "no";
      HashKnownHosts = "no";
      GSSAPIAuthentication = "no";
    };
  };
}
