local function e(t)local
a={"^([%a%d]+)$","^https?://pastebin.com/([%a%d]+)$","^pastebin.com/([%a%d]+)$","^https?://pastebin.com/raw/([%a%d]+)$","^pastebin.com/raw/([%a%d]+)$",}for
o=1,#a do local i=t:match(a[o])if i then return i end end return nil end local
function n(s)local h=e(s)if not h then return nil,"invalid"end local
r=("%x"):format(math.random(0,2^30))local
d,l=http.get("https://pastebin.com/raw/"..textutils.urlEncode(h).."?cb="..r)if
d then local u=d.getResponseHeaders()if not u["Content-Type"]or not
u["Content-Type"]:find("^text/plain")then return nil,"captcha"end local
c=d.readAll()d.close()return c else return nil,l end end local function
m(f,w)w=w or"CC:T Paste"local y="0ec2eb25b6166c0c27a394ae118ad829"local
p=http.post("https://pastebin.com/api/api_post.php","api_option=paste&".."api_dev_key="..y.."&".."api_paste_format=lua&".."api_paste_name="..textutils.urlEncode(w).."&".."api_paste_code="..textutils.urlEncode(f))if
p then local v=p.readAll()p.close()local b=string.match(v,"[^/]+$")return b
else return nil end end
return{get=n,put=m,}