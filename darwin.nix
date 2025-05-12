{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
    nonUS.remapTilde = false;
  };

  system.defaults = {
    # function keys behavior
    NSGlobalDomain = {
      "com.apple.keyboard.fnState" = true; # make F keys be F keys
      "com.apple.keyboardlayout.all" = [ "ru" "en" ];
      AppleKeyboardUIMode = 3;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      ApplePressAndHoldEnabled = false;
    };

    dock = {
      autohide = true;
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
  };

  # homebrew minimal
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    brews = [
      "orbstack"
    ];
    casks = [
      "karabiner-elements"
    ];
  };

  # environment
  environment = {
    shells = [ pkgs.bash ];
    loginShell = pkgs.bash;
    systemPackages = with pkgs; [ coreutils ];
  };
}
