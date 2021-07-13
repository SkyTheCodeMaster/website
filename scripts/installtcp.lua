-- Copyright 2021 SkyTheCodeMaster - All Rights Reserved.
term.clear()
term.setBackgroundColour(colours.black)
term.setTextColour(colours.yellow)
term.setCursorPos(1,1)
print("TCP Module installer")
print("Checking for redrun...")
-- Check if redrun is intalled
if not fs.exists("redrun.lua") then
  -- If not, download it!
  print("Redrun is not installed!")
  local rr,err = http.get("https://gist.githubusercontent.com/MCJack123/473475f07b980d57dd2bd818026c97e8/raw/7815f22720a53e9d0ff2296ed0698fcfa02af521/redrun.lua")
  if not rr then error("TCP Installer: Redrun: " .. err) end
  local f = fs.open("redrun.lua","w")
  f.write(rr.readAll())
  rr.close()
  f.close()
  print("Installed redrun!")
end
print("Checking for SHA256...")
if not fs.exists("sha256.lua") then
  print("SHA256 is not installed!")
  local sha,err = http.get("https://pastebin.com/raw/6UV4qfNF")
  if not sha then error("TCP Installer: SHA256 " .. err) end
  local f = fs.open("sha256.lua","w")
  f.write(sha.readAll())
  sha.close()
  f.close()
  print("Installed SHA256!")
end
print("Checking for startup file...")
if fs.exists("startup") then
  print("Startup file is present!")
  print("Startup file will be moved to \"startup.bak\",  ")
  print("It will still be executed, but \"startup\" will ")
  print("contain the tcp server, so edit \"startup.bak\".")
  fs.move("startup","startup.bak")
end
local ns,err = http.get("https://skydocs.madefor.cc/scriptdata/tcpserver.lua")
if not ns then error(err) end
local f = fs.open("startup","w")
f.write(ns.readAll())
ns.close()
f.close()
local tcp,err = http.get("tcp_module") -- Change the URL once the file is on github.

print("Finished installing TCP server & module")
sleep(1)
os.reboot()