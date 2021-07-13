local e=dofile("libraries/coro.lua")local t=SkyOS.settings.longPressDelay or
1000 local
a=setmetatable({[-1]={[0]="left"},[1]={[0]="right"},[0]={[-1]="up",[1]="down"},},{__index=function()return"unknown"end})local
function o(i)i=i or false while true do local n={os.pullEvent()}if
n[1]=="mouse_click"then local s=os.pullEvent()if s=="mouse_drag"then local
h={os.pullEvent()}if n[1]=="mouse_click"and h[1]=="mouse_drag"and
n[2]==h[2]then local r=vector.new(n[3],n[4])local d=vector.new(h[3],h[4])local
l=(d-r):normalize()if i then
print("click",n[3],n[4])print("drag",h[3],h[4])print("normal",l.x,l.y)end local
u=a[l.x][l.y]if i then print("swipe",u)end if u and u~="unknown"then
os.queueEvent("swipe",u)end end end end end end local function c(m)m=m or false
while true do local f,w,y,p=os.pullEvent("mouse_click")local
v=os.epoch("utc")if m then print("click",w,y,p,v)end local
f,b,g,k=os.pullEvent("mouse_up")local q=os.epoch("utc")if m then
print("up",b,g,k,q,q-v)end if q-v>=t and w==b and y==g and p==k then
os.queueEvent("long_press",b,g,k)end end end local function j(x)x=x or false
while true do local z,E,T,A=os.pullEvent("mouse_drag")local
z,O,I,N=os.pullEvent("mouse_drag")if E==O then local S=vector.new(T,A)local
H=vector.new(I,N)local R=(H-S):normalize()if x then
print("drag1",T,A)print("drag2",I,N)print("normal",R.x,R.y)end local
D=a[R.x][R.y]if x then print("swipe",D)end if D and D~="unknown"then
os.queueEvent("pan",D)end end end end local function L(U)U=U or false while
true do local C,M,F,W=os.pullEvent("mouse_click")if U then
print("click",M,F,W)end local C,Y,P,V=os.pullEvent("mouse_up")if U then
print("up",Y,P,V)end if M==Y and F~=P and W~=V then local B,G=P-F,V-W if U then
print("pan",Y,B,G)end os.queueEvent("pan_up",Y,B,G)end end end local function
K()e.newCoro(o,"Swipe Manager",nil,nil,true)e.newCoro(c,"Long Press",nil,nil,true)e.newCoro(j,"Pan Manager",nil,nil,true)e.newCoro(L,"Pan Up Manager",nil,nil,true)e.runCoros()end
local function Q()e.stop()e.coros={}end
return{swipeDirections=a,run=K,stop=Q,swipe=o,longPress=c,pan=j,pan_up=L,}