local e=require("cc.expect").expect local function
t(a,o,i,n)e(1,a,"table")e(2,o,"number","nil")e(3,i,"number","nil")e(4,n,"table","nil")o=o
or 1 i=i or 1 n=n or term.current()if not a.attributes or not a.data then
error("table is not valid .skimg")end if not n.setCursorPos or not n.blit then
error("tOutput is incompatible!")end for s=1,#a.data do local
h=a.data[s]n.setCursorPos(o,i+s-1)n.blit(h[1],h[2],h[3])end end local function
r(d)e(1,d,"string")local l=fs.open(d,"r")local
u=textutils.unserialize(l.readAll())l.close()return
setmetatable(u,{__call=function(c,...)return t(u,...)end,})end return
setmetatable({load=r,draw=t,},{__call=function(m,...)return
r(...)end,})