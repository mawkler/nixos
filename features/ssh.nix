{ username, ... }:
{
  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ username ];
      };

    };
    fail2ban.enable = true;
  };
}
