{ pkgs, lib, ... }:
{
  imports = [
    ./ssh
    ./1password
  ./fish
  ./podman.nix
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
#   programs.fzf = {
#     enable = true;
#     enableFishIntegration = true;
#   };

  home.packages = with pkgs; [
    glab
    aws-vault
    bat
    asdf
    zoxide
    yamllint
    yq
    jq
    netcat-gnu
      (if pkgs.stdenv.isLinux then
        (pkgs.gitkraken.override {
          cacert = "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem";
        })
      else
        gitkraken)
    vscode
    vault-bin
    terraform
    awscli2
    tabby
    neovim
    htop
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # GTK modules (Linux only)
    gtk3
    packagekit
    libcanberra
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
