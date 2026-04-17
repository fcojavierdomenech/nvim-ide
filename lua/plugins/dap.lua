-- Debug Adapter Protocol (DAP) Configuration
local dap = require('dap')
local dapui = require('dapui')
local dap_python = require('dap-python')
local dap_go = require('dap-go')

-- Setup dap-python
-- Use system debugpy installation
dap_python.setup('/usr/bin/python3')

-- Setup dap-go
dap_go.setup()

-- Setup dap-ui
dapui.setup({
  controls = {
    element = "repl",
    enabled = true,
    icons = {
      disconnect = "",
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = ""
    }
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = "single",
    mappings = {
      close = { "q", "<Esc>" }
    }
  },
  force_buffers = true,
  icons = {
    collapsed = "",
    current_frame = "",
    expanded = ""
  },
  layouts = { {
      elements = { {
          id = "scopes",
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.25
        } },
      position = "left",
      size = 40
    }, {
      elements = { {
          id = "repl",
          size = 0.5
        }, {
          id = "console",
          size = 0.5
        } },
      position = "bottom",
      size = 10
    } },
  mappings = {
    edit = "e",
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    repl = "r",
    toggle = "t"
  },
  render = {
    indent = 1,
    max_value_lines = 100
  }
})

-- Setup virtual text
require('nvim-dap-virtual-text').setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  clear_on_continue = false,
  display_callback = function(variable, buf, stackframe, node, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value
    else
      return variable.name .. ' = ' .. variable.value
    end
  end,
  virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil
})

-- Auto open/close dapui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Set up key mappings
vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Set Conditional Breakpoint' })
vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Debug: Set Log Point' })
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Debug: Open REPL' })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Debug: Run Last' })
vim.keymap.set({'n', 'v'}, '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Debug: Hover' })
vim.keymap.set({'n', 'v'}, '<leader>dp', function() require('dap.ui.widgets').preview() end, { desc = 'Debug: Preview' })
vim.keymap.set('n', '<leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = 'Debug: Frames' })
vim.keymap.set('n', '<leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = 'Debug: Scopes' })

-- Python specific mappings
vim.keymap.set('n', '<leader>dn', function() dap_python.test_method() end, { desc = 'Debug: Test Method' })
vim.keymap.set('n', '<leader>dc', function() dap_python.test_class() end, { desc = 'Debug: Test Class' })
vim.keymap.set('v', '<leader>ds', function() dap_python.debug_selection() end, { desc = 'Debug: Debug Selection' })

-- Go specific mappings
vim.keymap.set('n', '<leader>dgt', function() require('dap-go').debug_test() end, { desc = 'Debug: Go Test' })
vim.keymap.set('n', '<leader>dgl', function() require('dap-go').debug_last_test() end, { desc = 'Debug: Go Last Test' })

-- DAP signs
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🟡', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='💬', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='→', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})