{ config, pkgs, ... }: let
  doomPath = "${config.home.homeDirectory}/.config/dot/doom";
in
{
  xdg.configFile."doom".source = config.lib.file.mkOutOfStoreSymlink doomPath;

   imports = [
    ./gnome.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ianic";
  home.homeDirectory = "/home/ianic";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    htop
    fortune
    zigpkgs.master
    zlspkgs
    git
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    emacs-gtk

    # doom emacs
    ripgrep
    coreutils
    fd
    clang
    # # da bi mogao buildati vterm u emacs-u
    # # to je sada pokriveno s coreutils vjerujem
    # gnumake
    # cmake
    # gcc
    # libtool

    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    # nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    # ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # # networking tools
    # mtr # A network diagnostic tool
    # iperf3
    # dnsutils  # `dig` + `nslookup`
    # ldns # replacement of `dig`, it provide the command `drill`
    # aria2 # A lightweight multi-protocol & multi-source command-line download utility
    # socat # replacement of openbsd-netcat
    # nmap # A utility for network discovery and security auditing
    # ipcalc  # it is a calculator for the IPv4/v6 addresses

    # # misc
    # cowsay
    # file
    # which
    # tree
    # gnused
    # gnutar
    # gawk
    # zstd
    # gnupg

    # # nix related
    # #
    # # it provides the command `nom` works just like `nix`
    # # with more details log output
    # nix-output-monitor

    # # productivity
    # hugo # static site generator
    # glow # markdown previewer in terminal

    # btop  # replacement of htop/nmon
    # iotop # io monitoring
    # iftop # network monitoring

    # # system call monitoring
    # strace # system call monitoring
    # ltrace # library call monitoring
    # lsof # list open files

    # # system tools
    # sysstat
    # lm_sensors # for `sensors` command
    # ethtool
    # pciutils # lspci
    # usbutils # lsusb

    gnomeExtensions.vitals
    gnomeExtensions.gsconnect
    gnomeExtensions.tactile
  ];

  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        vitals.extensionUuid
        gsconnect.extensionUuid
        tactile.extensionUuid
      ];
    };
  };

  fonts.fontconfig.enable = true;

  programs.git = {
    # package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Igor Anić";
    userEmail = "igor.anic@gmail.com";
    aliases = {
    };
    extraConfig = {
      color = {
        ui = "auto";
      };
      pull = {
        rebase = true;
      };
      core = {
        excludesfile = "~/.gitignore";
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --impure --flake /home/ianic/.config/dot/nixos#nixos";
      d = "eza -l --icons";
      ll = "ls -l";
      e = "emacsclient -n"; # send file to emacs
      doom = "~/.config/emacs/bin/doom";
      zb = "zig build";
      zbf = "zig build -Doptimize=ReleaseFast";
      emacs-restart = "systemctl --user restart emacs";
    };

    # ... # Your zsh config
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.ghostty = {
    enable = true;
    settings =  {
      theme = "GitHub-Light-High-Contrast";
    };
  };
}
