{  pkgs,  config, lib, ...}: {
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
    solaar
    spotify

    # doom emacs
    ripgrep
    coreutils
    fd
    clang
    ispell

    # to build vterm in emacs
    gnumake
    cmake
    #gcc
    libtool

    # shell
    killall
    neofetch
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # archives
    zip
    xz
    unzip
    p7zip
    gnutar
    zstd

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
    # gawk
    # gnupg

    # # nix related
    # #
    # # it provides the command `nom` works just like `nix`
    # # with more details log output
    # nix-output-monitor

    # # productivity
    # hugo # static site generator
    # glow # markdown previewer in terminal
  ];

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
      rebuild = "sudo nixos-rebuild switch --impure --flake /home/ianic/.config/dot/nixos#nixos";
      d = "eza -l --icons always";
      ll = "ls -l";
      cls = "clear";
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

  programs.ghostty = {
    enable = true;
    settings =  {
      theme = "GitHub-Light-High-Contrast";
    };
  };
}
