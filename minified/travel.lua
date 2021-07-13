local e=peripheral.wrap("back")local function t(a,o,i)return
math.deg(math.atan2(-a,i)),math.deg(-math.atan2(o,math.sqrt(a*a+i*i)))end local
function n(s)local h,r=gps.locate()if r and r<=s then e.launch(0,-90,1)end end
local function d(l,u)local c=false local m={x=l-50,w=l+50,y=u-50,h=u+50,}while
not c do local f=vector.new(l,300,u)local w,y,p=gps.locate()local
v=vector.new(w,300,p)local b=f:sub(v)local
g=t(b.x,b.y,b.z)e.launch(g,0,4)print(w,p)print(l,u)print(w>=m.x,w<=m.x+m.w-1)print(p>=m.y,p<=m.y+m.h-1)if
w and p and w>=m.x and w<=m.w and p>=m.y and p<=m.h then c=true end
n(300)sleep()end end return
d