{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    #colorschemes.gruvbox = {
    #        enable = true;
    #        settings = {
    #                transparent_mode = true;
    #        };
    #};
    defaultEditor = true;
    vimdiffAlias = true;
    enableMan = true;
    vimAlias = true;
    clipboard.register = "unnamedplus";
    globals.mapleader = " ";
    opts = {
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      smartindent = true;
      swapfile = false;
      backup = false;
      shiftwidth = 4;
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      colorcolumn = "80";
      foldmethod = "syntax";
      foldlevelstart = 99;
      spell = true;
      nu = true;
      completeopt = "menuone,noselect";
      updatetime = 250;
      timeoutlen = 300;
      smartcase = true;
      ignorecase = true;
      breakindent = true;
    };
    plugins = {
      lazygit.enable = true;
      indent-blankline.enable = true;
      harpoon = {
        enable = true;
        enableTelescope = true;
      };
      wakatime.enable = true;
      lualine.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      undotree.enable = true;
      trouble.enable = true;
      todo-comments.enable = true;
      fidget.enable = true;
      neotest.enable = true;
      neotest.adapters.plenary.enable = true;
      gitsigns.enable = true;
      blink-cmp.settings = {
        sources.providers = {
          lazydev = {
            name = "LazyDev";
            module = "lazydev.integrations.blink";
            score_offset = 100;
          };
        };
      };
      lsp = {
        enable = true;
        servers = {
          pyright.enable = true;
          tailwindcss.enable = true;
          ts_ls.enable = true;
          eslint.enable = true;
          lua_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          nixd = {
            enable = true;
            settings.formatting.command = [ "nixpkgs-fmt" ];
          };
          gopls.enable = true;
          html.enable = true;
          cssls.enable = true;
          clangd.enable = true;
        };
      };
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      friendly-snippets.enable = true;
      lspkind.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];
      };
      comment.enable = true;
      ts-context-commentstring.enable = true;
      telescope = {
        extensions.fzf-native.enable = true;
        extensions.file-browser.enable = true;
        enable = true;
        keymaps = {
          "<leader>fr" = {
            action = "oldfiles";
            options = {
              desc = "[F]uzzy find [R]ecent files";
            };
          };
          "<leader>gf" = {
            action = "git_files";
            options = {
              desc = "[S]earch [G]it [F]iles";
            };
          };
          "<leader>sf" = {
            action = "find_files";
            options = {
              desc = "[S]earch [F]iles";
            };
          };
          "<leader>sh" = {
            action = "help_tags";
            options = {
              desc = "[S]earch [H]elp";
            };
          };
          "<leader>sw" = {
            action = "grep_string";
            options = {
              desc = "[S]earch current [W]ord";
            };
          };
          "<leader>sg" = {
            action = "live_grep";
            options = {
              desc = "[S]earch by [G]rep";
            };
          };
          "<leader>sd" = {
            action = "diagnostics";
            options = {
              desc = "[S]earch [D]iagnostics";
            };
          };
          "<leader>sr" = {
            action = "diagnostics";
            options = {
              desc = "[S]earch [R]esume";
            };
          };
        };
      };
      oil.enable = true;
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          c
          query
          elixir
          heex
          javascript
          fish
        ];
      };

      luasnip.enable = true;

    };
    extraPlugins = with pkgs.vimPlugins; [
      lazydev-nvim
      nvim-colorizer-lua
      (pkgs.vimUtils.buildVimPlugin {
        name = "crackboard-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "boganworld";
          repo = "crackboard.nvim";
          rev = "main"; # You might want to use a specific commit hash here
          sha256 = "sha256-sScAbpwc3z6i3ZP3FWkiJMlXyMZnMYNuEqvXNsXf5IA=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "cord.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "vyfor";
          repo = "cord.nvim";
          rev = "client-server";
          sha256 = "sha256-D2xOqEr75HptygRXFM4Z2pj2OhVEaOjrvNNFCo5Dz08=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin {
        name = "gruvbox.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "ellisonleao";
          repo = "gruvbox.nvim";
          rev = "main";
          sha256 = "sha256-qasIg1nvAlUWUUzSZLF36jnoNm8PmQa3owgh0tKGgHk=";
        };
      })
    ];
    keymaps = [
      {
        action = "<cmd>Oil<CR>";
        key = "<leader>pv";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>UndotreeToggle<CR>";
        key = "<leader>u";
        options = {
          silent = true;
        };
      }
    ];
    extraConfigLua = ''
      require('crackboard').setup({
        session_key = "",
      })

      require('cord').setup({})

      require('gruvbox').setup({
          transparent_mode = true,
      })
      vim.cmd('colorscheme gruvbox')

      local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
          vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = '*',
      })

      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate " },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next,     -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    
      vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
 

      vim.keymap.set("x", "<leader>p", [["_dP]])
      vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
      vim.keymap.set("n", "<leader>Y", [["+Y]])
      vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
      vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
      vim.api.nvim_set_keymap('x', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', 'K', ":m '>-2<CR>gv=gv", { noremap = true, silent = true })
      vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
      vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    '';
  };
}
