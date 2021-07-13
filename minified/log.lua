local function e()local t=os.date("!*t")local
a="["..tostring(t.hour)..":"..tostring(t.min)..":"..tostring(t.sec).."] "return
a end local o={}local i={["__index"]=o}function o:save()self.fHandle.save()end
function o:close()self.fHandle.close()end function o:info(n)local s=e()local
h=s.."[INFO]"..n self.fHandle.writeLine(h)end function o:warn(r)local
d=e()local l=d.."[INFO]"..r self.fHandle.writeLine(l)end function o:err(u)local
c=e()local m=c.."[INFO]"..u self.fHandle.writeLine(m)end local function
f(w)local y,p=fs.open(w,"w")if not y then return nil,p end local
o={fHandle=y,}return setmetatable(o,i)end
return{create=f,}