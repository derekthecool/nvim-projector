---@class Output
---@field meta { [string]: any } Table that holds output's metadata
---@field status "inactive"|"hidden"|"active" Status of the output (hidden or active)
---@field _callback_success fun() Anonymous callback function on successful output completion
---@field _callback_problem fun() Anonymous callback function on problematic output completion
local Output = {}

function Output:new(opts)
  opts = opts or {}

  local on_success = function () end
  if opts.on_success and type(opts.on_success) == "function" then
    on_success = opts.on_success
  end

  local on_problem = function () end
  if opts.on_problem and type(opts.on_problem) == "function" then
    on_problem = opts.on_problem
  end

  local o = {
    meta = {
      name = opts.name or "[empty output name]",
    },
    status = "inactive",
    _callback_success = on_success,
    _callback_problem = on_problem,
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

-- function that should run after the task is done
-- for background tasks, this should trigger when the task is fully running
-- DO NOT OVERWRITE
---@param ok boolean
function Output:done(ok)
  if ok then
    self._callback_success()
  else
    self._callback_problem()
  end
end

-- Function that initializes the output (runs the command)
---@param configuration Configuration
---@diagnostic disable-next-line: unused-local
function Output:init(configuration)
  error("not_implemented")
end

-- function that opens the output (shows it on screen)
function Output:open()
  error("not_implemented")
end

-- function that closes the output (hides it from screen)
function Output:close()
  error("not_implemented")
end

-- function that kills the output (stops the task and deactivates the output)
function Output:kill()
  error("not_implemented")
end

-- Function that shows available actions of the running output
---@return Action[]|nil
function Output:list_actions()
  error("not_implemented")
end

return Output
