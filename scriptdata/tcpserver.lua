-- Copyright 2021 SkyTheCodeMaster - All Rights Reserved.
local redrun = require("redrun")

local modem = peripheral.find("modem")
local sha256 = require("sha256")
modem.open(30000)
local myid = os.getComputerID()

-- Sha256 digest but pre hexed
local function hash(data)
  local dataHash = sha256.digest(data)
  return dataHash:toHex()
end

local function transmit(id,packet,type)
  local data = {
    id=id,
    sendid=myid,
    packet=packet,
    hash=hash(packet),
    type=type
  }
  modem.transmit(30000,30000,data)
end

local function tcpServer()
  while true do
    local event = {os.pullEvent()}
    if event[1] == "tcp_send" then
      local message = event[2]
      if type(message) == "table" then
        if message.type == "data" then
          local sender = message.sendid
          repeat
            modem.transmit(30000,30000,{
              id = sender,
              sendid = myid,
              packet = message.hash,
              type = "confirm"
            })
            local _,_,_,_,ok = os.pullEvent("modem_message")
          until ok == true
          os.queueEvent("tcp_message",sender,message.packet)
        elseif message.type == "confirm" then
          
        end
      end
    end
  end
end

local id = redrun.start(tcpServer,"TCP Server")

if fs.exists("startup.bak") then
  shell.run("startup.bak")
end