--- A simple button api with the option of drawing an image on the button.
-- https://gist.github.com/SkyTheCodeMaster/c127ca042ee4d178693e45983ce42da4
-- @module[kind=misc] button

local expect = require("cc.expect").expect
local idLength = 6 -- This is the length of the unique identifiers for buttons.
local strictImage = true -- This confirms that the image is the same height as the button.
local buttons = {}

local function genRandID(length)
  local str = ""
  for i=1,length do
    local num = math.random(48,109)
    if num >= 58 then num = num + 7 end
    if num >= 91 then num = num + 6 end
    str = str .. string.char(num)
  end
  return str
end

--[[- newButton makes a new button, adds it to the button table, and returns the ID of it.
  @tparam number x x coordinate of the button
  @tparam number y y coordinate of the button
  @tparam number width width of the button
  @tparam number height height of the button
  @tparam function function function to be run when the button is clicked.
  @tparam table|nil image blit table to draw where the button is.
  @tparam boolean|nil enabled whether or not to enable the button, defaults true.
  @treturn string id id of the button
]]
local function newButton(nX,nY,nW,nH,fFunc,tDraw,enabled) -- tDraw is a table of blit lines. This function will check they're the same length.
  expect(1,nX,"number")
  expect(1,nY,"number")
  expect(1,nW,"number")
  expect(1,nH,"number")
  expect(1,fFunc,"function")
  expect(1,tDraw,"table","nil")
  expect(1,enabled,"boolean","nil")
  enabled = enabled or true -- retain old behaviour

  local mX,mY = term.getCursorPos()

  if tDraw then -- If a blit table is passed, loop through it and make sure it's a valid (ish) table, and make sure it's the same height & width as the button.
    if strictImage then
      if #tDraw ~= nH then
        error("Image must be same height as button")
      end
    end
    for i=1,#tDraw do
      if #tDraw[i][1] ~= #tDraw[i][2] or #tDraw[i][1] ~= #tDraw[i][3] then
        error("tDraw line" .. tostring(i) .. "is not equal to other lines")
      end
      if strictImage then
        if #tDraw[i][1] ~= nW then
          error("Image must be same width as button")
        end
      end
    end
  end

  local id = genRandID(idLength)

  buttons[id] = { -- Store the information about the button in the buttons table.
    x = nX,
    y = nY,
    w = nW,
    h = nH,
    fFunc = fFunc,
    tDraw = tDraw,
    enabled = enabled,
  }

  if tDraw then -- If a blit table is passed, loop through it and draw it.
    for i=1,#tDraw do
      local frame = tDraw[i]
      term.setCursorPos(nX,nY+i)
      term.blit(frame[1],frame[2],frame[3])
    end
  term.setCursorPos(mX,mY)
  end

  return id
end

--- deleteButton removes a button from the table, but doesn't remove the image.
-- @tparam string id button id to remove.
local function deleteButton(id) -- This doesn't remove the image if any!
  if buttons[id] then
    buttons[id] = nil
  end
end

--- enableButton takes a button ID and enables it or disables it.
-- @tparam string button id
-- @tparam boolean enable the button
local function enableButton(id,enable)
  if not buttons[id] then error("Button " .. id .. " does not exist.") end
  buttons[id].enabled = enable
end

--- executeButtons takes an event, checks it's a mouse_click, and sees if it's within a button.
-- @tparam table event event table to check for mouse_click and coords.
-- @tparam boolean drag enable trigger on drag events, defaults to false
local function executeButtons(tEvent,bDrag)
  bDrag = bDrag or false
  if tEvent[1] == "mouse_click" or (bDrag and tEvent[1] == "mouse_drag") then
    local x,y = tEvent[3],tEvent[4]
    for i,v in pairs(buttons) do
      if v.enabled and x >= v.x and x <= v.x + v.w - 1 and y >= v.y and y <= v.y + v.h - 1 then
        v.fFunc()
      end
    end
  end
end

return {
  newButton = newButton,
  deleteButton = deleteButton,
  enableButton = enableButton,
  executeButtons = executeButtons,
}