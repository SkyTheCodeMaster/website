local e=30000 local t=os.getComputerID()local a=peripheral.find("modem")local
o=require("sha256")local function i(n)local s=o.digest(n)return s:toHex()end
local function h(r,d)local
l={id=r,sendid=t,packet=d,hash=i(d),type="data"}os.queueEvent("tcp_send",l)end
local function u()local c,m,f=os.pullEvent("tcp_message")return m,f end local
function
w(y)end