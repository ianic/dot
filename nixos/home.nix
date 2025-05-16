{ config, pkgs, ... }: let

in
{


  imports = [
    ./packages.nix
    ./gnome.nix
  ];

  home.username = "ianic";
  home.homeDirectory = "/home/ianic";

  fonts.fontconfig.enable = true;

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

  xdg.configFile."doom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dot/doom";

  # ref: https://github.com/zigtools/zls/blob/master/schema.json
  xdg.configFile."zls.json".text = ''
    {
      "warn_style": true,
      "highlight_global_var_declarations": true,
      "include_at_in_builtins": true,
      "enable_autofix": true,

      "inlay_hints_show_parameter_name": false,
      "inlay_hints_show_struct_literal_field_type": false,
      "inlay_hints_show_variable_type_hints": false,

      "enable_build_on_save": true
    }
    '';
}
