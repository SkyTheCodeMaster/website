local e=require("cc.expect").expect local function t(a)e(1,a,"string")local o=0
local i=fs.list(a)for n=1,#i do if fs.isDir(fs.combine(a,i[n]))then
o=o+t(fs.combine(a,i[n]))else o=o+fs.getSize(fs.combine(a,i[n]))end end return
o end local function s(h,r)e(1,h,"string")local d if SkyOS and SkyOS.settings
and SkyOS.settings.timezone then d=SkyOS.settings.timezone else d=0 end local
l=math.floor(os.epoch("utc")/1000)+3600*d local u=os.date("!*t",l)local
c={sec=u.sec,min=u.min,hour=u.hour,day=u.day,month=u.month,year=u.year,}for m,f
in pairs(c)do local w=tostring(f)if w:len()==1 then w="0"..w end c[m]=w end
local
y=fs.combine(h,c.hour..c.min..c.sec.."-"..c.day..c.month..c.year.."."..r)return
y end local function p()local v=t(".")local b=fs.getCapacity(".")local
g=os.getComputerLabel()local k=os.getComputerID()local q=os.version()local
j=_VERSION local x=_HOST local z=SkyOS and SkyOS.version or"Unknown"local
E=string.format("DIAGNOSTIC DETAILS:\nDisk used: %d/%d\nLabel: %s\nID: %d\nCC: %s\nLua: %s\nHost: %s\nSkyOS: %s",v,b,g,k,q,j,x,z)return
E end local function T(A,O,I)local N=p()local S=I and
string.format("---MESSAGE---\n%s\n---DIAGNOSTIC INFORMATION---\n%s\n---ERROR---\n%s\n---STACKTRACE---\n%s",I,N,O,A)or
string.format("---DIAGNOSTIC INFORMATION---\n%s\n---ERROR---\n%s\n---STACKTRACE---\n%s",N,O,A)local
H=s("crash-reports","log")local R=fs.open(H,"w")R.write(S)R.close()end return
setmetatable({crashreport=T},{["__call"]=function(D,...)return
T(...)end})