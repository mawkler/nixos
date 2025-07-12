{ ... }: {
  services.hyprpaper = {
    enable = true;

    settings = let
      moony-mountains = "~/.config/nixos/home/hyprpaper/moony-mountains.jpg";
    in {
      preload = [ moony-mountains ];
      wallpaper = ", ${moony-mountains}";
    };
  };
}
