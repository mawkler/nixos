{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    # General dependencies
    ascii-image-converter
    gcc
    luajit
    luarocks
    neovide

    # Language servers
    bash-language-server
    bicep-lsp
    gopls
    hyprls
    kdePackages.qtdeclarative # qmlls
    languagetool
    lemminx
    ltex-ls-plus
    lua-language-server
    stable.next-ls
    nil
    nixd
    nodePackages.vscode-json-languageserver
    python312Packages.python-lsp-server
    rust-analyzer
    tinymist
    typescript-language-server
    typos-lsp
    vim-language-server
    vscode-extensions.dbaeumer.vscode-eslint
    yaml-language-server
    zk
    # azure-pipelines-language-server # Doesn't seem to exist

    # Formatters
    keep-sorted
    mdsf
    nixfmt-classic
    prettierd
    shfmt

    # Linters
    # vacuum # Relies on an insecure package

    # Debugger adapters
    delve
    lldb
    vscode-extensions.golang.go
    vscode-js-debug
    # bash-debug-adapter # Doesn't exist
  ];
}
