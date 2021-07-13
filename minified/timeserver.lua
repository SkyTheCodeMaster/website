local e=peripheral.find("modem")local t=27793 local
a=math.random(30000,40000)if e then e.open(a)end local o={}function o.get(i)if
not SkyOS.settings.timeServerEnabled or not e then local
n=math.floor(os.epoch("utc")/1000)+3600*SkyOS.settings.timezone local
s=os.date("!*t",n)return{s,tostring(s.hour)..":"..tostring(s.min)..":"..tostring(s.sec),tostring(s.hour)..":"..tostring(s.min)}end
e.transmit(t,a,i)local h,h,h,h,r=os.pullEvent("modem_message")return r end
return
o