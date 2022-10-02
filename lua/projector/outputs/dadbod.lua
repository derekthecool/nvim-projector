local Output = require 'projector.contract.output'
local has_dadbod_ui = vim.fn.exists(":DBUI") == 2

---@type Output
local DadbodOutput = Output:new()

---@param configuration Configuration
---@diagnostic disable-next-line: unused-local
function DadbodOutput:init(configuration)
  -- apply dadbod configuration variables
  if not configuration then
    self:done(false)
    return
  end

  -- TODO: filter for specific fields (don't set everything as global var)
  for setting, config in pairs(configuration) do
    vim.g[setting] = config
  end

  if has_dadbod_ui then
    self.status = "hidden"
    self:open()
  else
    self.status = "inactive"
  end

  self:done(true)
end

function DadbodOutput:open()
  if has_dadbod_ui then
    vim.cmd(":DBUI")

    -- Autocommand for current buffer
    vim.api.nvim_create_autocmd({ 'BufDelete', 'BufUnload' },
      { buffer = vim.fn.bufnr(),
        callback = function()
          self.status = "hidden"
        end })

    self.status = "active"
  end
end

function DadbodOutput:close()
  if has_dadbod_ui then
    vim.cmd('execute "normal \\<Plug>(DBUI_Quit)"')
    self.status = "hidden"
  end
end

function DadbodOutput:kill()
  self:close()
end

---@return Action[]|nil
function DadbodOutput:list_actions()
end

return DadbodOutput
