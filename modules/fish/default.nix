{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    shellInit = ''
      set fish_greeting
      fish_config theme choose "ayu Dark"
    '';

    interactiveShellInit = ''
      source ~/.config/op/plugins.sh
      # Nix paths and completions
      fish_add_path -p ~/.nix-profile/bin /nix/var/nix/profiles/default/bin
      set -a fish_complete_path ~/.nix-profile/share/fish/completions/ ~/.nix-profile/share/fish/vendor_completions.d/

      # Direnv
      direnv hook fish | source

      # ASDF
      source ${pkgs.asdf-vm}/share/asdf-vm/asdf.fish
      set -a fish_complete_path ${pkgs.asdf-vm}/share/asdf-vm/completions.fish

	  # Chef
      if test -x /usr/local/bin/chef
        eval (chef shell-init fish)
      end

      # Windsurf
      if test -f ~/.codeium/windsurf/bin/windsurf
        fish_add_path ~/.codeium/windsurf/bin
      end
    '';

    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair-fish.src;
      }
    ];

    functions = {
      update_git = ''
        git checkout main
        git pull
        git sync
      '';
    };

    shellAbbrs = {
      # Container tools
      d = "docker";
      dp = "podman";
      cat = "bat";
      cnpg = "kubectl-cnpg";

      # Git operations
      g = "git";
      ggp = "git push origin";
      grhh = "git reset --hard HEAD";
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
      gst = "git status";
      gw = "git switch";
      gm = "git switch (git main-branch)";
      gwt = "git worktree add -b";
      ug = "update_git";

      # Editor and tools
      vim = "nvim";

      # Infrastructure tools
      tfp = "terraform plan";
      tfa = "terraform apply";
      tfi = "terraform init";

      # Kitchen/Chef tools
      kitchen = "chef exec kitchen";
      kl = "chef exec kitchen list";
      kt = "chef exec kitchen test";
      kc = "chef exec kitchen converge";
      kd = "chef exec kitchen destroy";
      kli = "chef exec kitchen login";
      kv = "chef exec kitchen verify";

      # Container tools
      tf = "aws-vault exec $AWS_PROFILE -- docker compose run --rm terraform";
    };
  };
}
