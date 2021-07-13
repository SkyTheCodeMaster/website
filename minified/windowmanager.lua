local e=require("cc.expect").expect local t=require("cc.require").make local
a=1 local o=0 local i={}local n=true local s=true local h=window local function
r(d,l)d=d or{}local u={}for c,m in pairs(d)do u[c]=m end u["term"]=l
u["term"]["native"]=function()return _G.term.native()end
u["term"]["current"]=function()return l end
u["SkyOS"]["self"]={win=l}u["SkyOS"]["close"]=function()end
u["SkyOS"]["visible"]=function(f)return f end u["SkyOS"]["back"]=function()end
u["require"],u["package"]=t(u,"/")return u end local function
w(y,p,v,b,...)e(1,y,"function","string")e(2,p,"string","nil")e(3,v,"boolean","nil")e(4,b,"table","nil")b=b
or _ENV p=p or fs.getName(y)if not fs.exists(y)then
error("Program not found",2)end local
g=h.create(term.current(),1,2,26,18,false)local k=r(b,g)local
q=table.pack(...)local j=fs.open(y,"r")local x=j.readAll()j.close()local
z=load(x,p,"t",k)local function E()z(table.unpack(q,1,q.n))end local
T=SkyOS.coro.newCoro(E,p)k["SkyOS"]["self"]["pid"]=T
k["SkyOS"]["self"]["winid"]=a k["SkyOS"]["self"]["path"]=function()return
fs.getDir(y)end local A={win=g,env=k,pid=T,}i[a]=A a=a+1 return a-1 end local
function O(I)e(1,I,"table")if I.env.SkyOS.close then I.env.SkyOS.close()end
SkyOS.coro.killCoro(I.env.SkyOS.self.pid)i[I.env.SkyOS.self.winid]=nil end
local function N(S)local H if type(S)=="table"then local R=false for D,L in
pairs(i)do if not R and L==S then H=D R=true end end if not R then
error("Window not found!",2)end elseif type(S)=="number"and i[S]then H=S else
error("Window not found!",2)end if i[o]then local U=o
SkyOS.coro.activeCoros[i[U].pid]=false
i[U].env.SkyOS.visible(false)i[U].self.env.term.setVisible(false)end o=H
SkyOS.coro.activeCoros[i[H].pid]=true
i[H].env.SkyOS.visible(true)i[H].env.term.setVisible(true)end
return{wins=i,activeWindow=o,bottombarOpen=s,topbarOpen=n,newWindow=w,closeWindow=O,foreground=N,}