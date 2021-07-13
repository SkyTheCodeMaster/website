local e=require("cc.expect").expect local t=require("libraries.sUtils")local
a={github={user="SkyTheCodeMaster",repo="SkyOS",branch="master",path="",},}local
function o(i)e(1,i,"string")local n=fs.open(i,"r")local
s=n.readAll()n.close()return s end local function
h(r,d)e(1,r,"string")e(2,d,"string")local
l=fs.open(r,"w")l.write(d)l.close()end local function u(c,m)local
f=textutils.serialize(m)h(c,f)end local function w(y)local p=o(y)return
textutils.unserialize(p)end local function v(b)e(1,b,"string")local
g,k=http.get(b)if not g then return nil,k end local
q=g.readAll()g.close()return q,nil end local function
j()return{{{{},{},{},{},},{{},{},{},{},},{{},{},{},{},},{{},{},{},{},},},}end
local function x(z)for E,T in ipairs(z)do for A,O in ipairs(T)do for I,N in
ipairs(O)do if not N.name then return E,A,I end end end end return#z+1,1,1 end
local function S(H,...)local R={...}local D if type(R[1])=="table"then
D=R[1]e(2,D["name"],"string")e(3,D["image"],"string")e(4,D["program"],"string")elseif
type(R[1])=="string"then
e(2,R[2],"string")e(3,R[3],"string")e(4,R[4],"string")D={name=R[1],image=R[2],program=R[3]}end
local L,U,C=x()if H[L]then H[L][U][C]=D else H[L]={y={}}H[L][U][C]=D end end
local function M()local F if SkyOS and SkyOS.settings and
SkyOS.settings.timezone then F=SkyOS.settings.timezone else F=0 end local
W=math.floor(os.epoch("utc")/1000)+3600*F local Y=os.date("!*t",W)local
P={sec=Y.sec,min=Y.min,hour=Y.hour,day=Y.day,month=Y.month,year=Y.year,}for V,B
in pairs(P)do local G=tostring(B)if G:len()==1 then G="0"..G end P[V]=G end
local
K="screenshots/"..P.hour..P.min..P.sec.."-"..P.day..P.month..P.year..".skimg"return
K end local function Q()if not term.current().getLine then return end local
J,X=term.getSize()local Z={}for et=1,X do local
tt,at,ot=term.current().getLine(et)Z[et]={tt,at,ot,et}end local
it=os.getComputerLabel()or"SkyOS"local
nt={x=J,y=X,creator=it,locked=false,type=1,}local
st={attributes=nt,data=Z}local ht=M()u(ht,st)end
return{screenshot=Q,desktop={nextAvailable=x,insertApp=S,},}