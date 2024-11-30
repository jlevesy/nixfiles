{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.packages = with pkgs; [
    ripgrep
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      gruvbox.enable = true;
    };

    opts = {
      # Line Numbering.
      number = true;
      relativenumber = true; # Shows Relative Line Numbers.

      # Tabs and Indent
      tabstop = 2; # 2 spaces for tabs.
      shiftwidth = 2; # 2 spaces for indent width.
      expandtab = true; # Expand tabs to spaces.
      autoindent = true; # Copy indent from current line when opening a new one.

      wrap = false; # Do not wrap lines.

      # Cursor setup.
      cursorline = true; # Highlights cursor on line.
      cursorcolumn = true; # Highligths cursor on column.

      termguicolors = true; # Enable 24bits termgui colors.
      background = "dark"; # Prefer dark scheme.
      signcolumn = "yes"; # Always shows the sign comlum.

      showmatch = true; # Show matching brackets!
      cc = "120"; # 120 and chars, not above!

      hlsearch = true; # Turns on search highlights.
      incsearch = true; # Shows search matching as it is typed.
      ignorecase = true; # ignore case when searching
      smartcase = true; # if you include mixed case in your search, assumes you want case-sensitive

      swapfile = false; # No swapfile.
      backup = false; # Turn off backup deletion or whatever.
      undofile = true; # Writes undo history into a file and be able to restore it.
      cmdheight = 0; # Do not show command line by default.

      clipboard = {
        providers = {
          wl-copy.enable = true; # Wayland
        };
      };

      # Start scrolling when the cursor is X lines away from the top/bottom
      scrolloff = 5;
    };

    globals = {
      mapleader = ",";
    };

    keymaps = [
      {
        mode = "";
        key = "<leader>o";
        action = "<C-O>";
        options = {
          desc = "Jump back";
        };
      }
      {
        mode = "";
        key = "<leader>nh";
        action = ":nohl<cr>";
        options = {
          desc = "Clear search highlights";
        };
      }
      {
        mode = "";
        key = "<F12>";
        action = ":NvimTreeToggle<cr>";
        options = {
          desc = "Toggle File Tree";
        };
      }
      # Session Management.
      {
        mode = "";
        key = "<leader>sr";
        action = "<cmd>SessionRestore<cr>";
        options = {
          desc = "Restore Session for CWD";
        };
      }
      {
        mode = "";
        key = "<leader>ss";
        action = "<cmd>SessionSave<cr>";
        options = {
          desc = "Save Session for CWD";
        };
      }
    ];

    plugins = {
      zellij = {
        enable = true;
        settings = {
          vimTmuxNavigatorKeybinds = true;
        };
      };

      lualine = {
        enable = true;
        settings = {
          theme = "gruvbox_dark";
        };
      };

      web-devicons = {
        enable = true;
      };

      nvim-tree = {
        enable = true;
      };

      which-key = {
        enable = true;
      };

      auto-session = {
        enable = true;
      };

      dressing = {
        enable = true;
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>p" = {
            action = "find_files";
            options = {
              desc = "Search files";
            };
          };
          ";" = {
            action = "oldfiles";
            options = {
              desc = "Lookup recently opened files";
            };
          };
          "<leader>f" = {
            action = "live_grep";
            options = {
              desc = "Fuzzy search string";
            };
          };
          "<leader>ff" = {
            action = "grep_string";
            options = {
              desc = "Find string under cursor";
            };
          };
        };
      };

      treesitter = {
        enable = true;

        settings = {
          auto_install = false;
          ensure_installed = [
            "bash"
            "c"
            "cmake"
            "cpp"
            "css"
            "csv"
            "diff"
            "dockerfile"
            "git_config"
            "git_rebase"
            "gitcommit"
            "gitignore"
            "go"
            "gomod"
            "gosum"
            "gotmpl"
            "gowork"
            "helm"
            "html"
            "ini"
            "java"
            "javascript"
            "jsonc"
            "make"
            "nix"
            "promql"
            "proto"
            "python"
            "ruby"
            "rust"
            "scss"
            "sql"
            "terraform"
            "toml"
            "typescript"
            "vim"
            "vimdoc"
            "xml"
            "yaml"
          ];
          highlight = {
            enable = true;
          };
          indent = {
            enable = true;
          };
          autotag = {
            enable = true;
          };
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };
      };

      treesitter-textobjects = {
        enable = true;
      };

      indent-blankline = {
        enable = true;
        settings = {
          exclude = {
            buftypes = [
              "terminal"
              "quickfix"
            ];
            filetypes = [
              ""
              "checkhealth"
              "help"
              "lspinfo"
              "packer"
              "TelescopePrompt"
              "TelescopeResults"
              "yaml"
            ];
          };
          indent = {
            char = "│";
          };
          scope = {
            show_end = false;
            show_exact_scope = true;
            show_start = false;
          };
        };
      };

      luasnip = {
        enable = true;
      };

      cmp_luasnip = {
        enable = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "emoji";}
            {name = "buffer";}
            {name = "path";}
          ];
          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<cr>" = "cmp.mapping.confirm({ select = false })";
          };

          window = {
            completion = {border = "solid";};
            documentation = {border = "solid";};
          };
        };
      };

      cmp-emoji = {
        enable = true;
      };

      cmp-path = {
        enable = true; # file system paths
      };

      cmp-buffer = {
        enable = true;
      };

      cmp-nvim-lsp = {
        enable = true; # LSP
      };

      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          ellipsisChar = "...";
          maxWidth = 50;
        };
      };

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };

      ts-context-commentstring = {
        enable = true;
      };

      comment = {
        enable = true;
        settings = {
          toggler = {
            line = "gcc";
            block = "gbc";
          };
          opleader = {
            line = "gc";
            block = "gb";
          };
          pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
          post_hook = ''
            function(ctx)
                if ctx.range.srow == ctx.range.erow then
                    -- do something with the current line
                else
                    -- do something with lines range
                end
            end
          '';
        };
      };

      nvim-surround = {
        enable = true;
      };

      conform-nvim = {
        enable = true;

        settings = {
          format_on_save = {
            lsp_format = "fallback";
            timeoutMs = 500;
          };
          notify_on_error = true;
          log_level = "debug";

          formatters_by_ft = {
            nix = ["alejandra"];
            go = ["gofumpt" "goimports"];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true; # TS/JS
          cssls.enable = true; # CSS
          html.enable = true; # HTML
          pyright.enable = true; # Python
          marksman.enable = true; # Markdown
          nil_ls.enable = true; # Nix
          dockerls.enable = true; # Docker
          bashls.enable = true; # Bash
          clangd.enable = true; # C/C++
          csharp_ls.enable = true; # C#
          yamlls.enable = true; # YAML
          gopls.enable = true; # Go
          terraform_lsp.enable = true; # Terraform
          protols = {
            enable = true; # Protobuf
            package = pkgs.protols;
          };
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          ruby_lsp.enable = true; # Ruby.
          helm_ls.enable = true; # Helm.
        };

        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>d" = {
              action = "open_float";
              desc = "Show line diagnostics";
            };
            "[d" = {
              action = "goto_prev";
              desc = "Goto to previous diagnostic";
            };
            "d]" = {
              action = "goto_next";
              desc = "Goto to next diagnostic";
            };
          };
          lspBuf = {
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>rn" = {
              action = "rename";
              desc = "Rename";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "Show code actions";
            };
          };

          extra = [
            {
              mode = "n";
              key = "gR";
              action = "<cmd>Telescope lsp_references<cr>";
              options = {
                desc = "Show symbol references";
              };
            }
            {
              mode = "n";
              key = "gd";
              action = "<cmd>Telescope lsp_definitions<cr>";
              options = {
                desc = "Show LSP definitions";
              };
            }
            {
              mode = "n";
              key = "gi";
              action = "<cmd>Telescope lsp_implementations<cr>";
              options = {
                desc = "Show LSP implentations";
              };
            }
            {
              mode = "n";
              key = "gt";
              action = "<cmd>Telescope lsp_type_definitions<cr>";
              options = {
                desc = "Show LSP implentations";
              };
            }
            {
              mode = "n";
              key = "gt";
              action = "<cmd>Telescope lsp_type_definitions<cr>";
              options = {
                desc = "Show LSP implentations";
              };
            }
            {
              mode = "n";
              key = "<leader>D";
              action = "<cmd>Telescope diagnostics bufnr=0<cr>";
              options = {
                desc = "Show Diagnostics";
              };
            }
            {
              mode = "n";
              key = "<leader>rs";
              action = "<cmd>LspRestart<cr>";
              options = {
                desc = "Restart LSP server";
              };
            }
          ];
        };
      };
    };
  };
}
