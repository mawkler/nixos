-- Workspace overview, installed in `packages/hyprland.nix`
hl.plugin.load("/run/current-system/sw/lib/libhyprexpo.so")

hl.config({
  plugin = {
    hyprexpo = {
      columns          = 3,
      gaps_in          = 5,
      gaps_out         = 0,
      workspace_method = "center current",
      overview_mode    = "grid",
    },
  },
})

hl.bind("SUPER + O", function() hl.plugin.hyprexpo.expo("toggle") end)
