{
  services.logind.settings.Login = {
    # `sleep` will default to `suspend-then-hibernate` if available, otherwise
    # `suspend`, and then `hibernate`
    HandleLidSwitch = "sleep";
    HandlePowerKey = "sleep";
  };
  systemd.sleep.settings.Sleep.HibernateDelaySec = "30min";
}
