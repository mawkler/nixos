{ rootPath, ... }:
let
  iconPath = "${rootPath}/assets/nix.svg";
  notifyDone = "notify-send --icon ${iconPath} NixOS Done";
  hms = "nh home switch";
  nhOs = cmd: "sudo true && nh os ${cmd} && ${hms} || ${notifyDone}";
in {
  n = "nh";
  nos = nhOs "switch";
  noS = "sudo true && nh os switch";
  nou = nhOs "switch --update";
  not = nhOs "test";
  nob = "nh os build || ${notifyDone}";
  hms = "${hms} || ${notifyDone}";
  hm = "home-manager --flake ${rootPath}";
  nr = "nix run nixpkgs#%";

  dots = "dot status";

  src = "exec zsh";
  screenkey = "screenkey -t 1.5 -s small";
  Bat = "bat --pager='less - mgi - -underline-special - -SILENT'";
  myip = "hostname -i";
  mv = "mv -i";
  ag = "ag --hidden --pager='less -R'";
  rg = "rg --hidden --smart-case";
  fd = "fd --hidden";
  mvc = "mullvad connect";
  mvd = "mullvad disconnect";
  mvr = "mullvad reconnect";

  g = "git";
  gs = "git status";
  gl = "git log --decorate";
  gd = "git diff -- :!package-lock.json :!yarn.lock :!Cargo.lock";
  gds = "git diff --staged -- :!package-lock.json :!yarn.lock :!Cargo.lock";
  gc = "git commit -v";
  gco = "git checkout";
  gcom = "git checkout `_master_branch`";
  gmm = "git merge master";
  gp = "git pull --autostash";
  gP = "git push";
  gb = "git branch";
  gw = "git whatchanged";
  ga = "git add";
  gai = "git add --intent-to-add";
  gcm = "git commit -mv";
  gcam = "git commit -avm";
  gca = "git commit -av";
  gcaa = "git commit -av --amend";
  gcA = "git commit -v --amend";
  gu = "git diff HEAD@{1} HEAD";
  gly = "git log --since='yesterday'";
  gr = "git reset";
  grc = "git rebase --continue";
  gra = "git rebase --abort";
  gdm = "git diff `_master_branch`..HEAD";
  gdu = "diff upstream/`_master_branch`";
  gru = "git pull --rebase --autostash upstream `_master_branch`";
  gsp = "git stash pop";
  gss = "git stash show -p";
  glm = "git log `_master_branch`";
  gldm = "git log --decorate --oneline `_master_branch`..";

  cd = "z";
  zoxide-add-directories =
    "fd --type directory --max-depth 1 | xargs zoxide add";
}
