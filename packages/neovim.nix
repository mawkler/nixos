{ pkgs, ... }:
{
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
    tree-sitter
    neovide

    # Language servers
    bash-language-server
    bicep-lsp
    fish-lsp
    gopls
    hyprls
    just-lsp
    kdePackages.qtdeclarative # qmlls
    languagetool
    lemminx
    ltex-ls-plus
    lua-language-server
    nil
    nixd
    nodePackages.vscode-json-languageserver
    python312Packages.python-lsp-server
    rust-analyzer
    stable.next-ls
    taplo
    tinymist
    typescript-language-server
    typos-lsp
    vim-language-server
    vscode-extensions.dbaeumer.vscode-eslint
    yaml-language-server
    zk

    # Formatters
    keep-sorted
    mdsf
    nixfmt
    alejandra
    prettierd
    shfmt
    rumdl
    kdlfmt

    # Linters
    # vacuum # Relies on an insecure package

    # Debugger adapters
    delve
    lldb
    vscode-extensions.golang.go
    vscode-js-debug
    # bash-debug-adapter # Doesn't exist

    # Plugin dependencies
    mailcap # rest.nvim
  ];
}
