{ pkgs, ... }: {
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
    nonUS.remapTilde = false;
  };

  # input sources
  system.defaults.NSGlobalDomain = {
    "com.apple.keyboard.fnState" = true; # make F keys be F keys
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

  # input method
  system.keyboard.userKeyMapping = [
    {
      HIDKeyboardModifierMappingSrc = 30064771129;
      HIDKeyboardModifierMappingDst = 30064771296;
    }
  ];

  system.inputMethod = {
    enabled = "com.apple.keylayout.ABC";
    enabledInputSources = [
      { InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 252; }  # ABC
      { InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 0; }    # US
      { InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 19; }   # Russian
    ];
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
