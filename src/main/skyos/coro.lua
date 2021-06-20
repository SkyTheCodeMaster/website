--- Coroutine manager for SkyOS. Might work, might not, who knows.
-- @module[kind=skyos] coro

local crash = require("libraries.crash") -- Crash reporting!

--- Currently running coroutines. This is stored in `SkyOS.coro.coros`
local coros = {}

--- The amount of processes that have been created.
local pids = 0

local running = true

--- Events that are blocked for non active coroutines. (aka not on top)
local blocked = {
  ["mouse_click"] = true,
  ["mouse_drag"] = true,
  ["mouse_scroll"] = true,
  ["mouse_up"] = true, 
  ["paste"] = true,
  ["key"] = true,
  ["key_up"] = true,
  ["char"] = true
}

--- Make a new coroutine and add it to the currently running list.
-- @tparam function func Function to run forever.
-- @tparam[opt] string name Name of the coroutine, defaults to `coro`.
-- @treturn number PID of the coroutine. This shouldn't change.
local function newCoro(func,name)
  local pid = pids + 1
  pids = pid
  table.insert(coros,{coro=coroutine.create(func),filter=nil,name=name or "coro",pid = pid})
  return pid
end

--- Kill a coroutine, and remove it from the coroutine table.
-- @param coro Coroutine to kill, accepts a number (index in table) or a string (name of coroutine).
local function killCoro(coro)
  if type(coro) == "number" then
    if coros[coro] then coros[coro] = nil end
  elseif type(coro) == "string" then
    for i=1,#coros do
      if coros[i].name == coro then
        coros[i] = nil
        break
      end
    end
  end
end

--- Run the coroutines. This doesn't take any parameters nor does it return any.
local function runCoros()
  local e = {n = 0}
  while running do
    for k,v in pairs(coros) do
      if coroutine.status(v.coro) == "dead" then
        coros[k] = nil
      else
        if not v.filter or v.filter == e[1] or e[1] == "terminate" then -- If unfiltered, pass all events, if filtered, pass only filter
          local ok,filter = coroutine.resume(v.coro,table.unpack(e))
          if ok then
            v.filter = filter -- okie dokie
          else
            local traceback = debug.traceback(v.coro)
            crash(traceback,filter)
            if SkyOS then -- We be inside of SkyOS environment
              SkyOS.displayError(v.name .. ":" .. filter .. ":" .. debug.traceback(v.coro))
            else 
              error(filter)
            end
          end
        end
      end
    end
    e = table.pack(os.pullEventRaw())
  end
  running = true
end

--- Stop the coroutine manager, halting all threads after current loop. Note that this will not stop it immediately.
local function stop()
  running = false
end

return {
  coros = coros,
  newCoro = newCoro,
  killCoro = killCoro,
  runCoros = runCoros,
  stop = stop,
}