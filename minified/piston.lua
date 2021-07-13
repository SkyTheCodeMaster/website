local e=require("cc.expect").expect local t="left"local a="right"local o=0.1
local i={}local n={["__index"]=i}function i:raise(s)e(1,s,"number","nil")s=s or
1 local h=math.abs(s)+self.curHeight if h>i.maxHeight then h=i.maxHeight end
local r=h-i.curHeight for d=1,r do
redstone.setOutput(t,true)sleep(o/2)redstone.setOutput(t,false)sleep(o/2)end
i.curHeight=h end function i:lower(l)e(1,l,"number","nil")l=l or 1 local
u=self.curHeight-math.abs(l)if u<0 then u=0 end for c=i.curHeight,u,-1 do
redstone.setOutput(a,true)sleep(o/2)redstone.setOutput(a,false)sleep(o/2)end
i.curHeight=u end function i:ground()for m=i.curHeight,0,-1 do
redstone.setOutput(a,true)sleep(o/2)redstone.setOutput(a,false)sleep(o/2)end
i.curHeight=0 end function i:max()for f=i.curHeight,i.maxHeight do
redstone.setOutput(t,true)sleep(o/2)redstone.setOutput(t,false)sleep(o/2)end
end local function w(y,p)e(1,y,"number","nil")e(2,p,"number")if not y then for
v=1,50 do
redstone.setOutput(a,true)sleep(o/2)redstone.setOutput(a,false)sleep(o/2)end
y=1 end local b={curHeight=y,maxHeight=p,}return setmetatable(b,n)end
return{create=w}