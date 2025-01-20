{ pkgs, lib, ... }:
{
  imports = [
    ./fish
    ./podman.nix
    ./ssh
    ./starship.nix
  ];

  home = {
    username = if pkgs.stdenv.isDarwin
    then "damacus"
    else "u.7862791-1";
    homeDirectory = if pkgs.stdenv.isDarwin
      then "/Users/damacus"
      else "/home/u.7862791-1";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;
  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    asdf-vm
    aws-vault
    awscli2
    bat
    devcontainer
    direnv
    git-credential-manager
    glab
    htop
    jq
    neovim
    netcat-gnu
    tabby
    terraform
    vault-bin
    vscode
    yamllint
    yq
    zoxide
  ];

  home.sessionVariables = {
    LC_ALL = "en_GB.UTF-8";
    LC_CTYPE = "en_GB.UTF-8";
    PROJECTS = "$HOME/repos";
    SHELL = "${pkgs.fish}/bin/fish";
  };

  # ensures ~/repos folder exists.
  # this folder is later assumed by other activations, specially on darwin.
  home.activation.developer = ''
    mkdir -p ~/repos
  '';
}
