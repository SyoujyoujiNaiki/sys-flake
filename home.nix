{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "naiki";
  home.homeDirectory = "/home/naiki";

  home.packages = with pkgs; [
    # gui apps
    qbittorrent
    haruna
    fractal
  ] ++ (with pkgs.kdePackages; [
    akregator
    kmail
    kmail-account-wizard
  ]);

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    firefox = {
      enable = true;
      languagePacks = [ "zh-CN" "en-US" ];
    };

    bash = {
      enable = true;
      enableCompletion = true;
      bashrcExtra = ''
      '';
    };

    nushell = {
      enable = true;
      extraConfig = ''
        $env.config.show_banner = false

        let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
        }
      '';

    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
