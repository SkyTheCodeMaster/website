local e="https://beta.devbin.dev/api/v2/"local function t(a)local
o={"^([%a%d]+)$","^https?://beta,devbin.dev/([%a%d]+)$","^beta.devbin.dev/([%a%d]+)$","^https?://beta.devbin.dev/raw/([%a%d]+)$","^beta.devbin.dev/raw/([%a%d]+)$",}for
i=1,#o do local n=a:match(o[i])if n then return n end end return nil end local
function s(h)local r=t(h)if not r then return nil,"invalid"end local
d=("%x"):format(math.random(0,2^30))local
l,u=http.get(e.."paste/"..textutils.urlEncode(r).."?cb="..d)if l then local
c=l.readAll()l.close()local m=textutils.unserializeJSON(c)return m.contentCache
else return nil,u end end local function f(w,y)y=y or"CC:T Paste"local
p="computercraft"local
v=textutils.serializeJSON({title=y,syntax="lua",exposure="Public",content=w,asGuest=true,})local
b,g=http.post(e.."create?token="..p,v,{["Content-Type"]="application/json",})if
b then local k=textutils.unserializeJSON(b.readAll())b.close()local q=k.id
return q else return nil,g end end
return{get=s,put=f,}