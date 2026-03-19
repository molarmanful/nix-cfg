inputs:
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    (import ./nix/internal.nix inputs)
  ];

  config = {
    settings.config_directory = ./.;

    specs = {
      base = {
        extraPackages = with pkgs; [
          nil
          nixfmt
          statix
          deadnix
          lua-language-server
          stylua
          selene
          taplo
        ];
        data = config.nvim-lib.plugins (
          plugins: with plugins; [
            lze
            lzextras
          ]
        );
      };

      lazy = {
        after = [ "base" ];
        lazy = true;
        extraPackages = with pkgs; [
          ripgrep
          fd
        ];
        data = config.nvim-lib.plugins (
          plugins: with plugins; [
            config.nvchad.base46
            nvchad-ui
            nvim-web-devicons
            blink-indent
            nvim-tree-lua
            which-key-nvim
            gitsigns-nvim
            nvim-lspconfig
            blink-cmp
            friendly-snippets
            luasnip
            nvim-autopairs
            telescope-nvim
            telescope-fzf-native-nvim
            telescope-ui-select-nvim
            telescope-file-browser-nvim
            nvim-treesitter.withAllGrammars
            vim-repeat
            leap-nvim
            none-ls-nvim
            persisted-nvim
            diffview-nvim
            neogit
            parinfer-rust
            render-markdown-nvim
            obsidian-nvim
            jj-diffconflicts
            vim-suda
            guess-indent-nvim
            rustaceanvim
            lazydev-nvim
            lsp-format-nvim
            nvim-metals
            nvim-ts-autotag
            nvim-surround
          ]
        );
      };
    };
  };
}
