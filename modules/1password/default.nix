{pkgs, config, ...}: {
  home.packages = with pkgs; [
    _1password-cli
  ];

  # Create the directory for the socket
  home.file.".1password/.keep".text = "";

  # We'll let the SSH config handle the socket path
  programs.ssh.extraOptionOverrides = {
    IdentityAgent = if pkgs.stdenv.isDarwin
      then "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      else "~/.1password/agent.sock";
  };
}
