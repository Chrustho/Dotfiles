return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        transparent = false,
        dimInactive = false,
        terminalColors = true,

        background = {
          dark = "dragon", -- AGGIORNATO: Ora usa la variante Dragon di default per gli sfondi scuri
          light = "lotus",
        },

        -- La funzione si adatterà automaticamente ai nuovi colori di Dragon
        overrides = function(colors)
          local theme = colors.theme

          local makeDiagnosticColor = function(color)
            local c = require("kanagawa.lib.color")
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
          end

          return {
            -- 1. FILE EXPLORER (Neo-tree)
            NeoTreeNormal = { bg = theme.ui.bg },
            NeoTreeNormalNC = { bg = theme.ui.bg },

            -- 2. FINESTRE FLUTTUANTI E BOX COMANDI (Noice)
            NormalFloat = { bg = theme.ui.bg },
            FloatBorder = { bg = theme.ui.bg },
            FloatTitle = { bg = theme.ui.bg },
            NoiceCmdlinePopup = { bg = theme.ui.bg },
            NoiceCmdlinePopupBorder = { bg = theme.ui.bg },
            NoiceCmdlinePopupTitle = { bg = theme.ui.bg },

            -- 3. TELESCOPE (Ricerca file)
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg },
            TelescopePromptBorder = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
            TelescopeResultsBorder = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
            TelescopePreviewNormal = { bg = theme.ui.bg },
            TelescopePreviewBorder = { fg = theme.ui.fg_dim, bg = theme.ui.bg },

            -- 4. MENU A TENDINA (Autocompletamento)
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- 5. DIAGNOSTICA (Testo degli errori in linea)
            DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
          }
        end,
      }
    end,
  },

  -- AGGIORNATO: Diciamo a LazyVim di forzare direttamente la variante Dragon
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
}
