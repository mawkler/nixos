{ rootPath, ... }: {
  services.hyprpaper = {
    enable = true;

    settings =
      let moony-mountains = "${rootPath}/home/hyprpaper/moony-mountains.jpg";
      in {
        preload = [ moony-mountains ];
        wallpaper = ", ${moony-mountains}";
      };
  };
}
