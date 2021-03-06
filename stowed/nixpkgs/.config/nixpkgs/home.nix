{ config, pkgs, ... }:

{

  imports = [ ./doom ./email ./python ./neovim ./tmux ./zsh ];

  home.username = "chris";
  home.homeDirectory = "/home/chris";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    curl
    direnv
    fd
    gcc
    gnumake
    gnutls
    htop
    jq
    lastpass-cli
    neofetch
    ripgrep
    signal-desktop
    tree
    wget
    write_stylus
    xclip
  ];

  programs.git = {
    enable = true;
    userName = "Chris Cummings";
    userEmail = "chris@thesogu.com";
    extraConfig = { pull.rebase = true; };
  };

  services.lorri.enable = true;
}
