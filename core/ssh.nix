{ username, ... }:
{
  services = {
    openssh = {
      enable = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ username ];
      };

    };
    fail2ban.enable = true;
  };
}
