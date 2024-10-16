local builtin = require('telescope.builtin')

-- vim.ui.select = 'telescope'

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

vim.keymap.set('v', '<leader>fj', function()
  local text = vim.getVisualSelection()
  builtin.grep_string({
    default_text = text,
    additional_args = {
      '--hidden'
    }
  });
end)

vim.keymap.set('n', '<leader>fj', function()
  builtin.live_grep({
    additional_args = {
      '--hidden'
    }
  });
end)

vim.keymap.set('n', '<leader><Space>', builtin.buffers, {})

local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')

require('telescope').setup {
  pickers = {
    buffers = {
      initial_mode = "normal",
      mappings = {
        n = {
          ["x"] = actions.delete_buffer
        }
      },
      sort_lastused = true
    },
    find_files = {
      hidden = true
    },
    grep_string = {
      initial_mode = 'normal'
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-p>"] = actions_layout.toggle_preview
      },
      n = {
        ["<C-p>"] = actions_layout.toggle_preview
      },
    },
    preview = {
      hide_on_startup = true
    },
    borderchars = { "╌", "╎", "╌", "╎", "┌", "┐", "┘", "└" },
    results_title = "",
    prompt_prefix = " ▶ ",
    selection_caret = " ",
    entry_prefix = " ",
    file_ignore_patterns = {
      "^.git/",
      "^node_modules/"
    },
    dynamic_preview_title = true,
    path_display = {
      "smart"
    },
    layout_config = {
      prompt_position = "bottom"
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        initial_mode = "normal"
      }
    }
  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")
