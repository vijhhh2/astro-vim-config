return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
        surrounds = {
          ["t"] = {
            add = function()
              local config = require "nvim-surround.config"
              local input = config.get_input "Enter the HTML tag: "
              if input then
                local element = input:match "^<?([%w-]+)"
                local attributes = input:match "%s+([^>]+)>?$"
                if not element then return nil end

                local open = attributes and element .. " " .. attributes or element
                local close = element

                return { { "<" .. open .. ">" }, { "</" .. close .. ">" } }
              end
            end,
            delete = "^(%b<>)().-(%b<>)()$",
            change = {
              target = "^<([%w-]*)().-([^/]*)()>$",
              replacement = function()
                local element = get_input "Enter the HTML element: "
                if element then return { { element }, { element } } end
              end,
            },
          },
        },
      }
    end,
  },
}
