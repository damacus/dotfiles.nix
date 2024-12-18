{ ... }:
{
  imports = [
    ./starship.nix
	./fzf.nix
  ];

  programs.zoxide.enable = true;
}
