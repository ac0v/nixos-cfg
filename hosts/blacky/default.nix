{ pkgs, config, lib, ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      sway = {
        enable = true;
        scale = "1.5";
      };
      i3.enable = true;
      apps = {
        waybar.enable = true;
        bitwarden.enable = true;
        remmina.enable = true;
        remotedesktopmanager.enable = true;
      };
      com = {
        discord.enable = true;
        slack.enable = true;
        teams.enable = true;
        skype.enable = true;
        mattermost.enable = true;
        evolution.enable = true;
      };
      browsers = {
        default = "google-chrome";
        google-chrome.enable = true;
        firefox.enable = true;
      };
      gaming = {
        # steam.enable = true;
        # emulators.enable = true;
        # emulators.psx.enable = true;
      };
      media = {
        daw.enable = true;
        documents.enable = true;
#        graphics.enable = true;
        mpv.enable = true;
        recording.enable = true;
        spotify.enable = true;
      };
      term = {
        default = "alacritty";
        alacritty.enable = true;
      };
      vm = {
        qemu.enable = true;
        virtualbox.enable = true;
        virt-manager.enable = true;
      };
    };
    dev = {
      node.enable = true;
      rust.enable = true;
      cc.enable = true;
      nix.enable = true;
      jdk.enable = true;
      python.enable = false;
    };
    editors = {
      default = "nano";
      emacs = {
        enable = true;
        doom.enable = true;
      };
      nano.enable = true;
      vim.enable = true;
      idea-ultimate.enable = true;
      clion.enable = true;
    };
    shell = {
      adl.enable = true;
      vaultwarden.enable = true;
      direnv.enable = true;
      git.enable    = true;
      gnupg.enable  = true;
      tmux.enable   = true;
      zsh.enable    = true;
    };
    services = {
      ssh.enable = true;
      docker.enable = true;
      blueman.enable = true;
      # onedrive.enable = true;
      mlocate.enable = true;
      greetd.enable = true;
      gnome-keyring.enable = true;
#      flameshot.enable = true;
    };
    hardware = {
      wifi.enable = true;
      bluetooth.enable = true;
      hidpi.enable = true;
    };
    theme = {
      active = "alucard";
      browser = "google-chrome-stable";
    };
  };

  services = {
#    gnome-keyring.enable = true;
    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
    };
    tlp = {
      enable = true;
      settings = {
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "off";
      };
    };
  };

  ## Local config
  #programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  user.extraGroups = [ "networkmanager" ];
  networking.domain = "local";
}
