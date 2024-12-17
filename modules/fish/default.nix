{ pkgs, config, ... }:
{
  programs.fish = {
	package = pkgs.fish;

    shellInit = ''
      # disable fish greeting
      set fish_greeting
      fish_config theme choose "ayu Dark"

      # Ensure Nix paths are first in PATH
      set -gx fish_user_paths $fish_user_paths
      fish_add_path -p ~/.nix-profile/bin /nix/var/nix/profiles/default/bin
      set -a fish_complete_path ~/.nix-profile/share/fish/completions/ ~/.nix-profile/share/fish/vendor_completions.d/
    '';

    loginShellInit = ''
      # Added by Windsurf
      fish_add_path ~/.codeium/windsurf/bin
    '';

    interactiveShellInit = ''
      ${if pkgs.stdenv.isDarwin then "source /opt/homebrew/opt/asdf/libexec/asdf.fish" else ""}
      ${if pkgs.stdenv.isDarwin then "source ~/.config/op/plugins.sh" else ""}
      ${if pkgs.stdenv.isDarwin then "eval (chef shell-init fish)" else ""}
    '';

    functions = {
      update_git = ''
        git checkout main
        git pull
        git sync
      '';
    };

    shellAbbrs = {
      # Docker
      d = "docker";
      dp = "podman";
      cat = "bat";
      cnpg = "kubectl-cnpg";

      # Git abbreviations
      g = "git";
      ggp = "git push origin";
      grhh = "git reset --hard HEAD $argv";
      gl = "git pull --prune";
      glg = "git log --graph --decorate --oneline --abbrev-commit";
      glga = "glg --all";
      gp = "git push origin HEAD";
      gpa = "git push origin --all";
      gd = "git diff";
      gc = "git commit -s";
      gca = "git commit -sa";
      gco = "git checkout";
      gb = "git branch -v";
      ga = "git add";
      gaa = "git add -A";
      gs = "git status -sb";
      gw = "git switch";
      gm = "git switch (git main-branch)";
      ug = "update_git";

      # Editor
      vim = "nvim";
      update_lazy = "nvim --headless \"+Lazy! sync\" +qa &>/dev/null";

      # Terraform
      tf = "terraform";
      tfp = "terraform plan";
      tfa = "terraform apply";
      tfi = "terraform init";

      # Kitchen/Chef
      kitchen = "chef exec kitchen";
      kl = "chef exec kitchen list";
      kt = "chef exec kitchen test";
      kc = "chef exec kitchen converge";
      kd = "chef exec kitchen destroy";
      kli = "chef exec kitchen login";
      kv = "chef exec kitchen verify";
    };
  };
}
