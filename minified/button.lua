local e=require("cc.expect").expect local t=6 local a=true local o={}local
function i(n)local s=""for h=1,n do local r=math.random(48,109)if r>=58 then
r=r+7 end if r>=91 then r=r+6 end s=s..string.char(r)end return s end local
function
d(l,u,c,m,f,w,y)e(1,l,"number")e(1,u,"number")e(1,c,"number")e(1,m,"number")e(1,f,"function")e(1,w,"table","nil")e(1,y,"boolean","nil")y=y
or true local p,v=term.getCursorPos()if w then if a then if#w~=m then
error("Image must be same height as button",2)end end for b=1,#w do
if#w[b][1]~=#w[b][2]or#w[b][1]~=#w[b][3]then
error("tDraw line"..tostring(b).."is not equal to other lines",2)end if a then
if#w[b][1]~=c then error("Image must be same width as button",2)end end end end
local g=i(t)o[g]={x=l,y=u,w=c,h=m,fFunc=f,tDraw=w,enabled=y,}if w then for
k=1,#w do local q=w[k]term.blit(q[1],q[2],q[3])end term.setCursorPos(p,v)end
return g end local function j(x)e(1,x,"string","nil")if o[x]then o[x]=nil end
end local function z(E,T)e(1,E,"string")e(2,T,"boolean")if not o[E]then
error("Button "..E.." does not exist.",2)end o[E].enabled=T end local function
A(O,I,N)e(1,O,"table")e(2,I,"boolean","nil")e(3,N,"boolean","nil")I=I or false
N=N or false if O[1]=="mouse_click"or I and O[1]=="mouse_drag"or N and
O[2]=="monitor_touch"then local S,H=O[3],O[4]for R,D in pairs(o)do if D.enabled
and S>=D.x and S<=D.x+D.w-1 and H>=D.y and H<=D.y+D.h-1 then
pcall(D.fFunc,S-D.x+1,H-D.y+1)end end end end local function
L(U)e(1,U,"string")if o[U]and o[U].tDraw then local C=o[U].tDraw local
M,F,W,Y=o[U].x,o[U].y,o[U].w,o[U].h if a then if#C~=Y then
error("image must be same height as button",2)end end for P=1,#C do
if#C[P][1]~=#C[P][2]or#C[P][1]~=#C[P][3]then
error("image line"..tostring(P).."is not equal to other lines",2)end if a then
if#C[P][1]~=W then error("Image must be same width as button",2)end end end
local V,B=term.getCursorPos()if C then for G=1,C do local
K=C[G]term.setCursorPos(M,F+G-1)term.blit(K[1],K[2],K[3])end
term.setCursorPos(V,B)end end end local function Q()for J in pairs(o)do L(J)end
end local function
X(Z,et,tt,at,ot,it,nt)e(1,Z,"string")e(2,et,"number","nil")e(3,tt,"number","nil")e(4,at,"number","nil")e(5,ot,"number","nil")e(6,it"function","nil")e(7,nt,"table","nil")if
not o[Z]then error("Button "..Z.." does not exist.",2)end et=et or o[Z].x tt=tt
or o[Z].y at=at or o[Z].w ot=ot or o[Z].h local st=it or o[Z].fFunc local ht=nt
or o[Z].tDraw local rt=o[Z].enabled
o[Z]={x=et,y=tt,w=at,h=ot,fFunc=st,tDraw=ht,enabled=rt,}end
return{newButton=d,deleteButton=j,enableButton=z,edit=X,executeButtons=A,drawButton=L,drawButtons=Q,}