local function raisin(key, name, class)
  local command = hl.dsp.exec_cmd(("raisin %s %s"):format(name, class or ""))
  hl.bind("SUPER +" .. key, command)
end

-- Raise-or-run app launchers
raisin("E", "nautilus")
raisin("T", "ghostty")
raisin("W", "brave")
raisin("B", "beeper")
raisin("N", "neovide")
raisin("S", "spotify")
raisin("D", "onlyoffice-desktopeditors", "onlyoffice")
raisin("A", "teams-for-linux")
raisin("Z", "zen")
raisin("G", "gram")
raisin("SHIFT + S", "slack")
