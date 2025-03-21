{ config, lib, pkgs, ... }:

{
  # Enable the KDE Plasma 6 Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    khelpcenter
  ];

  # Some themes
  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    capitaine-cursors
    adw-gtk3
  ];

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    audio.enable = true;
    jack.enable = true;
    pulse.enable = true;
  };

  # Add fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      hanazono
      sarasa-gothic
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Serif CJK SC" "Noto Serif CJK TC" "Noto Serif CJK JP" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK SC" "Noto Sans CJK TC" "Noto Sans CJK JP" ];
        monospace = [ "Sarasa Mono SC" "Sarasa Mono TC" "Sarasa Mono J" ];
      };
    };
  };

  # Enable input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [ fcitx5-gtk fcitx5-mozc fcitx5-rime ];
    };
  };

  # Auto unlock kwallet
  security.pam.services.naiki = {
    kwallet = {
      enable = true;
      package = pkgs.kdePackages.kwallet-pam;
    };
  };

  # Enable plymouth
    boot = {
      plymouth = {
        enable = true;
        theme = "spinner";
      };

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      loader.timeout = 0;
  };

  # Enable network gui tools
  services.v2raya.enable = true;
}
