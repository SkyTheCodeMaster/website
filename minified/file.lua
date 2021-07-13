local e={}function e.split(t,a)SkyOS.sLog.info("[file] splitting "..t)if a==nil
then a="%s"end local o={}for i in string.gmatch(t,"([^"..a.."]+)")do
table.insert(o,i)end return o end function e.countLines(n)local s=0 for h in
io.lines(n)do s=s+1 end return s end function e.loadGrpLines(r,d)d=d or
term.current()SkyOS.sLog.info("[file] loading image "..r)local
l=fs.open(r,"r")for u=1,e.countLines(r),1 do local c=l.readLine()local
m=e.split(c,",")local f=m[1]if f=="P"then
SkyOS.lib.graphic.drawPixel(m[2],m[3],tonumber(m[4]),d)elseif f=="B"then
SkyOS.lib.graphic.drawBox(m[2],m[3],m[4],m[5],tonumber(m[6]),d)elseif
f=="F"then
SkyOS.lib.graphic.drawFilledBox(m[2],m[3],m[4],m[5],tonumber(m[6]),d)elseif
f=="L"then
SkyOS.lib.graphic.drawLine(m[2],m[3],m[4],m[5],tonumber(m[6]),d)elseif
f=="TEXT"then SkyOS.lib.graphic.drawText(m[2],m[3],m[4],m[5],m[6],d)elseif
f=="PAL"then term.setPaletteColour(tonumber(m[2]),m[3])end end
SkyOS.sLog.info("[file] done loading, closing file.")l.close()end function
e.loadAppGraphics(w,y,p)SkyOS.sLog.info("[file] loading app "..p..", graphic at "..w..", setting "..y)local
v=fs.open(w,"r")local b=fs.open(y,"r")local g,k for q=1,e.countLines(y),1 do
local j=b.readLine()local x=e.split(j,",")local z=x[1]if z==p then
g,k=x[2],x[3]end end
SkyOS.sLog.info("[info] offset "..g.."X, "..k"Y")SkyOS.sLog.info("[info] loading image")for
E=1,e.countLines(w),1 do local T=v.readLine()local A=e.split(T,",")local
O=A[1]local I=tonumber(A[2])+g local N=tonumber(A[3])+k if O=="P"then
SkyOS.lib.graphic.drawPixel(I,N,tonumber(A[4]))elseif O=="B"then local
S=tonumber(A[4])+g local H=tonumber(A[5])+k
SkyOS.lib.graphic.drawBox(I,N,S,H,tonumber(A[6]))elseif O=="F"then local
R=tonumber(A[4])+g local D=tonumber(A[5])+k
SkyOS.lib.graphic.drawFilledBox(I,N,R,D,tonumber(A[6]))elseif O=="L"then local
L=tonumber(A[4])+g local U=tonumber(A[5])+k
SkyOS.lib.graphic.drawLine(I,N,L,U,tonumber(A[6]))elseif O=="TEXT"then
SkyOS.lib.graphic.drawText(I,N,A[4],A[5],A[6])end end b.close()v.close()end
function e.loadApps(C)SkyOS.sLog.info("[info] loading all apps")local
M=fs.open(C,"r")local F=e.countLines(C)for W=1,F,1 do local Y=M.readLine()local
P=e.split(Y,",")local V=P[1]local B=fs.combine("/graphics/app/",V)if
fs.exists(B)then e.loadAppGraphics(B,C,V)end end M.close()end function
e.getSize(G)local K=0 local Q=fs.list(G)for J=1,#Q do if
fs.isDir(fs.combine(G,Q[J]))then K=K+e.getSize(fs.combine(G,Q[J]))else
K=K+fs.getSize(fs.combine(G,Q[J]))end end return K end return
e