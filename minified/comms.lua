if not fs.exists("/libraries/ecc.lua")then
error("Please place ECC library @ /libraries/ecc.lua.\npastebin get ZGJGBJdg /libraries/ecc.lua")end
local e=require("libraries.ecc")local t=peripheral.find("modem")local a={}local
function o(i,n)local
s,h=e.keypair()end