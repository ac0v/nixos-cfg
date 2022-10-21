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
      apps = {
        rofi.enable = true;
        waybar.enable = true;
        bitwarden.enable = true;
        # godot.enable = true;
        remotedesktopmanager.enable = true;
      };
      com = {
        discord.enable = true;
        slack.enable = true;
        teams.enable = true;
        skype.enable = true;
        mattermost.enable = true;
      };
      browsers = {
        default = "chrome";
        chrome.enable = true;
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
        graphics.enable = true;
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
      };
    };
    dev = {
      node.enable = true;
      rust.enable = true;
      # python.enable = true;
    };
    editors = {
      default = "nano";
      emacs = {
        enable = true;
        doom.enable = true;
      };
      nano.enable = true;
      vim.enable = true;
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
    };
    theme.active = "alucard";
  };


  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;

  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        devices = [ "nodev" ];
        useOSProber = true;
        gfxmodeEfi = "1024x768";
      };
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };
  };
}
