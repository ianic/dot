{  pkgs,  config, lib, ...}: {

  home.packages = with pkgs; [
    gnomeExtensions.vitals
    gnomeExtensions.gsconnect
    gnomeExtensions.tactile
    gnomeExtensions.move-clock
  ];

  dconf = {
    enable = true;

    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        vitals.extensionUuid
        gsconnect.extensionUuid
        tactile.extensionUuid
        move-clock.extensionUuid
      ];
    };

    # settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    settings."org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 300;
      repeat-interval = lib.hm.gvariant.mkUint32 30;
    };

    # Pined apps in dock, accessible with shortcut
    settings."org/gnome/shell" = {
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "emacsclient.desktop"
        "google-chrome.desktop"
      ];
    };

    settings."org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = ["<Control>Left"];
      switch-to-workspace-right = ["<Control>Right"];
      close=["<Super>q"];
    };

    settings."org/gnome/shell/keybindings" = {
      screenshot=["<Shift><Super>5"];
      screenshot-window=["<Shift><Super>3"];
      show-screenshot-ui=["<Shift><Super>4"];
    };
  };
}
