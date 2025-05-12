{ pkgs, ... }: {
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # essentials
    ripgrep
    fd
    bat
    eza
    fzf
    jq

    # dev
    rustup
    go
    nodejs_22
  ];

  programs.git = {
    enable = true;
    userName = "realbikmaev";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  programs.direnv.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      l = "eza -l";
      ll = "eza -la";
      tree = "eza --tree";
      cat = "bat";
      g = "git";
      gs = "git status -sb";
      gl = "git log --oneline";
      gd = "git diff";
      gp = "git push";
      gpl = "git pull";
      gc = "git commit";
      gca = "git commit --amend";
      gco = "git checkout";
      gb = "git branch";
      ga = "git add";
      gaa = "git add -A";
      grb = "git rebase";
      gst = "git stash";
      gstp = "git stash pop";
    };
    initExtra = ''
      eval "$(direnv hook bash)"
    '';
  };
}
