{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
    nonUS.remapTilde = false;
  };

  system.defaults.NSGlobalDomain = {
    # keyboard
    "com.apple.keyboard.fnState" = true;
    "com.apple.keyboard.modifiermapping.1452-630-0" = [
      {
        HIDKeyboardModifierMappingSrc = 30064771129;
        HIDKeyboardModifierMappingDst = 30064771296;
      }
    ];
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

  system.defaults.dock = {
    autohide = true;
    show-recents = false;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    _FXShowPosixPathInTitle = true;
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
