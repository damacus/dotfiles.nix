{ config, ... }:
{
  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
  ];

  programs.fish.interactiveShellInit = ''
    fish_add_path -p ~/.cargo/bin/
  '';
}
