-- Copyright 2021 SkyTheCodeMaster - All Rights Reserved.
-- This is the server side that goes along with `src/main/skyos/timeserver.lua`. Run it on a computer w/ a modem.
local receiveChannel = 27793
local sendChannel = 27794

local modem = peripheral.wrap(SkyOS.modems.timeServer)
if modem == nil then error("Modem not detected!") end
modem.open(receiveChannel)

term.setBackgroundColour(colours.blue)
term.setTextColour(colours.white)
term.setCursorPos(1,1)
term.clear()
term.write("Sky Timerserver v1.1.0")
term.setCursorPos(1,2)
term.write("Receive Channel: " .. tostring(receiveChannel))
term.setCursorPos(1,3)
term.write("Send Channel: " .. tostring(sendChannel))

local function main()
  while true do
    local _,_,_,replyChannel,offset = os.pullEvent("modem_message")
    term.setCursorPos(1,4)
    term.clearLine()
    term.write("Last Client: " .. tostring(replyChannel))
    offset = offset or 0
    if not tonumber(offset) then offset = 0 end
    local epoch = math.floor(os.epoch("utc") / 1000) + (3600 * tonumber(offset))
    local t = os.date("!*t",epoch)
    local returnTable = {}

    returnTable[1] = t
    
    local hour,min,sec = tostring(t.hour),tostring(t.min),tostring(t.sec)
    if #hour == 1 then hour = "0"..hour end
    if #min == 1 then min = "0"..min end
    if #sec == 1 then sec = "0"..sec end
    
    returnTable[2] = hour .. ":" .. min .. ":" .. sec
    returnTable[3] = hour .. ":" .. min
    
    modem.transmit(replyChannel,receiveChannel,returnTable)
  end
end

local function send()
  while true do
    local t = os.date("!*t")
    modem.transmit(sendChannel,receiveChannel,t)
    sleep(60)
  end
end

parallel.waitForAny(main,send)
