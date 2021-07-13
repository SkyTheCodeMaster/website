local e,t=pcall(require,"libraries.crash")if not e then t=function(a,o)return
o,a end end local i=coroutine local n={}local function s(h)if n[h.pid]then
return true end if n[h.parent]then return true end return h.forceActive end
local r={}local d=0 local l=true local
u={["mouse_click"]=true,["mouse_drag"]=true,["mouse_scroll"]=true,["mouse_up"]=true,["paste"]=true,["key"]=true,["key_up"]=true,["char"]=true,}local
function c(m,f,w,y)local p=d+1 d=p
table.insert(r,{coro=i.create(m),filter=nil,name=f
or"coro",pid=p,parent=w,forceActive=y})return p end local function v(b)if
type(b)=="number"then if r[b]then r[b]=nil end elseif type(b)=="string"then for
g=1,#r do if r[g].name==b then r[g]=nil break end end end end local function
k()local q={n=0}while l do for j,x in pairs(r)do if
i.status(x.coro)=="dead"then r[j]=nil else if not x.filter or
x.filter==q[1]then if s(x)or not u[q[1]]then local
e,z=i.resume(x.coro,table.unpack(q))if e then x.filter=z else local
E=debug.traceback(x.coro)t(E,z)if SkyOS then
SkyOS.displayError(x.name..":"..z..":"..E)else error(z)end end end end end end
q=table.pack(i.yield())end l=true end local function T(A,...)if r[A]then local
e,O=i.resume(r[A].coro,...)if e then r[A].filter=O else local
I=debug.traceback(r[A].coro)t(I,O)if SkyOS then
SkyOS.displayError(r[A].name..":"..O..":"..I)else error(O)end end end end local
function N()l=false end
return{coros=r,activeCoros=n,newCoro=c,killCoro=v,runCoros=k,stop=N,resume=T,}