return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
      -- 1. Fondamentale per dire al tema di usare i colori SCURI
      vim.o.background = "dark"

      -- Configurazione PRIMA del caricamento
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1 -- Usiamo 1 invece di true
      vim.g.gruvbox_material_background = "hard" -- Variante hard

      -- 0 per opaco, 1 per trasparente
      vim.g.gruvbox_material_transparent_background = 0

      -- RIMOSSO: vim.cmd.colorscheme("gruvbox-material")
      -- Lasciamo che sia LazyVim a gestirlo sotto
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
