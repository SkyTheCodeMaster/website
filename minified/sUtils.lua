local e=require("cc.expect").expect local t=require("cc.image.nft")local
function a(o,i)e(1,o,"table")e(1,i,"any")for n=1,#o do if o[n]==i then return
true end end return false end local function
s(h,r)e(1,h,"table")e(1,r,"any")for d,l in pairs(h)do if d==r or l==r then
return true end end return false end local function
u(c,m,f)e(1,c,"string")e(1,m,"string")f=f or 0 if f>5 then
error("Failed too many times. Stopping.",2)end local w,y=http.get(m)if w then
local p,v=io.open(c,'w')if p then p:write(w:readAll()):close()w.close()else
w.close()printError("Failed to write file: "..v,2)u(c,m,f+1)end else
printError("Failed to connect: "..y,2)u(c,m,f+1)end end local function
b(g,k)e(1,g,"string")e(1,k,"string","nil")k=k or","local q={}for j in
string.gmatch(g,"([^"..k.."]+)")do table.insert(q,j)end return q end local
function x(z)e(1,z,"string")local E=0 for T in io.lines(z)do E=E+1 end return E
end local function A(O)return O%2==0 end local function
I(N,S)e(1,N,"string")e(2,S,"boolean","nil")local H=0 local R=fs.list(N)for D,L
in pairs(R)do if not S or L~="rom"then if fs.isDir(fs.combine(N,L))then
H=H+I(fs.combine(N,L))else H=H+fs.getSize(fs.combine(N,L))end end end return H
end local function U(C,M,F)F=F or" "return C:sub(1,M)..F:rep(M-#C)end local
function W(Y,P,V,B)local G=Y:len()local K=Y:sub(1,P-1)local Q=Y:sub(P,G)local J
if not B then J=K..V..Q return J else local X=Q:sub(2)J=K..V..X return J end
end local function Z()local
et=math.floor(os.epoch("utc")/1000)+3600*math.random(math.random(math.random(1,234),math.random(1,42345)))local
tt=os.date("!*t",et)return tt.hour*tt.min*tt.sec*(tt.hour+tt.min+tt.sec)end
local function
at(ot,it,nt)e(1,ot,"number")e(1,it,"number")e(1,nt,"number")ot=ot or 100 it=it
or 0 nt=nt or 0 local st=math.random(1,ot)+it if st>=nt then return true,st end
return false,st end local function ht(rt)e(1,rt,"number","nil")rt=rt or 0 local
dt=math.floor(os.epoch("utc")/1000)+3600*rt local lt=os.date("!*t",dt)return lt
end local function ut(ct)e(1,ct,"number","nil")local mt=ht(ct)local
ft={sec=mt.sec,min=mt.min,hour=mt.hour,day=mt.day,month=mt.month,year=mt.year,}for
wt,yt in pairs(ft)do local pt=tostring(yt)if pt:len()==1 then pt="0"..pt end
ft[wt]=pt end return ft end local function vt(bt)e(1,bt,"string")local
gt=fs.open(bt,"r")local kt=gt.readAll()gt.close()return kt end local function
qt(jt,xt)e(1,jt,"string")e(2,xt,"string")local
zt=fs.open(jt,"w")zt.write(xt)zt.close()end local function Et(Tt,At)local
Ot=textutils.serialize(At)qt(Tt,Ot)end local function It(Nt)local
St=vt(Nt)return textutils.unserialize(St)end local function
Ht(Rt)e(1,Rt,"string")local Dt,Lt=http.get(Rt)if not Dt then return nil,Lt end
local Ut=Dt.readAll()Dt.close()return Ut,nil end local function
Ct(Mt)fs.open(Mt,"a").close()end local function Ft(Wt)local Yt,Pt=Ht(Wt)if not
Yt then error("webquire: "..Pt,2)end local
Vt=load(Yt,"=webquire_package","t",_ENV)()return Vt end local function
Bt(Gt)local Kt=b(Gt,"/")local Qt=Kt[#Kt]local Jt if not
fs.exists(fs.combine("savequire",Qt))then local Xt,Zt=Ht(Gt)if not Xt then
error("savequire: "..Zt,2)end
qt(fs.combine("savequire",Qt),Xt.readAll())Jt=require(fs.combine("savequire",Qt))else
Jt=require(fs.combine("savequire",Qt))end return Jt end local
ea={["YES"]=true,["OK"]=true,["Y"]=true,["YEAH"]=true,["YEP"]=true,["TRUE"]=true,["YUP"]=true,["YA"]=true,["OKAY"]=true,["YAH"]=true,["SURE"]=true,["ALRIGHT"]=true,["WHATEVER"]=true,["WHYNOT"]=true,["WHY NOT"]=true,["K"]=true,["YEA"]=true,["YE"]=true,["YEE"]=true,["AFFIRMATIVE"]=true,}local
function ta(aa,oa,ia,na)local sa=read(aa,oa,ia,na)return not not
ea[sa:upper()]end local function ha(...)local ra repeat
ra=tonumber(read(...))until ra return tonumber(ra)end local function
da(la)return"sorry "..la.." eh"end local function ua(ca,ma)ma=ma or 1 if ma==1
then return"I'm walkin here! "..ca.." Forget about it!"elseif ma==2 then
return"Oil? "..ca.." The First Amendment."end end local function fa(wa,ya)local
pa=false for va,ba in pairs(wa)do if ba==ya then pa=true end end if not pa then
table.insert(wa,ya)end return wa end local function ga(ka,qa)for ja,xa in
pairs(ka)do if xa==qa then if type(ja)=="number"then table.remove(ka,ja)else
ka[ja]=nil end end end return ka end local function za(Ea)local Ta={}for Aa,Oa
in Ea do Ta[Aa]=Oa end return Ta end local function Ia(Na)local Sa={}for Ha,Ra
in Na do if type(Ra)=="table"then Sa[Ha]=Ia(Ra)else Sa[Ha]=Ra end end return Sa
end local Da={}local function La(Ua)if Da[Ua]then return Da[Ua]else local
Ca=vt(Ua)Da[Ua]=Ca return Ca end end local function Ma(Fa)local Wa=vt(Fa)local
Ya=Da[Fa]Da[Fa]=Wa return Ya end local function Pa(Va)e(1,Va,"string")if not
fs.exists(Va)then error("file does not exist",2)end local
Ba=fs.getName(Va)local Ga=b(Ba,".")[2]if Ga=="skimg"then local Ka=It(Va)return
Ka end if Ga=="skgrp"then local Qa={}for Ja in io.lines(Va)do
table.insert(Qa,Ja)end return Qa end if Ga=="blit"then local Xa=It(Va)return Xa
end if Ga=="nfp"then local Za=paintutils.loadImage(Va)return Za end if
Ga=="nft"then local eo=t.load(Va)return eo end end local function
to(ao,oo,no)e(1,ao,"string","table")e(2,oo,"table","nil")e(3,no,"table","nil")no=no
or term.current()local so=oo or{}local ho=so["x"]or 1 local ro=so["y"]or 1
local lo,uo,co if not so["format"]then if type(ao)=="table"then if
ao["attributes"]and ao["data"]then if ao["attributes"]["type"]then
uo=ao["attributes"]["type"]lo="skimg"else uo=1 lo="skimg"end if uo==2 then
co=ao["attributes"]["speed"]or 0.05 end else if type(ao[1])=="table"then if
ao[1]["text"]then lo="nft"else lo="blit"end elseif type(ao[1])=="string"then
lo="skgrp"end end elseif type(ao)=="string"then lo="nfp"end end if
lo=="skimg"and uo==1 then if not no.setCursorPos or not no.blit then
error("tOutput is incompatible!",2)end for mo,fo in ipairs(ao.data)do
no.setCursorPos(ho,ro+mo-1)no.blit(fo[1],fo[2],fo[3])end elseif lo=="skimg"and
uo==2 then if not no.setCursorPos or not no.blit then
error("tOutput is incompatible!",2)end local wo=ao.data for yo,po in
ipairs(wo)do local vo=po for bo,go in ipairs(vo)do
no.setCursorPos(ho,ro+bo-1)no.blit(go[1],go[2],go[3])end sleep(co)end elseif
lo=="blit"then if not no.setCursorPos or not no.blit then
error("tOutput is incompatible!",2)end for ko,qo in ipairs(ao)do
no.setCursorPos(ho,ro+ko-1)no.blit(qo[1],qo[2],qo[3])end elseif lo=="nft"then
t.draw(ao,ho,ro,no)elseif lo=="nfp"then paintutils.drawImage(ao,ho,ro)elseif
lo=="skgrp"then for jo=1,#ao do local xo=b(ao[jo],",")local zo=xo[1]if
zo=="P"then paintutils.drawPixel(xo[2],xo[3],tonumber(xo[4]))elseif zo=="B"then
paintutils.drawBox(xo[2],xo[3],xo[4],xo[5],tonumber(xo[6]))elseif zo=="F"then
paintutils.drawFilledBox(xo[2],xo[3],xo[4],xo[5],tonumber(xo[6]))elseif
zo=="L"then paintutils.drawLine(xo[2],xo[3],xo[4],xo[5],tonumber(xo[6]))elseif
zo=="TEXT"then paintutils.drawText(xo[2],xo[3],xo[4],xo[5],xo[6])end end end
end local function Eo(To)e(1,To,"table")for Ao=1,#To do local
Oo=b(To[Ao],",")local Io=Oo[1]if Io=="P"then
paintutils.drawPixel(Oo[2],Oo[3],tonumber(Oo[4]))elseif Io=="B"then
paintutils.drawBox(Oo[2],Oo[3],Oo[4],Oo[5],tonumber(Oo[6]))elseif Io=="F"then
paintutils.drawFilledBox(Oo[2],Oo[3],Oo[4],Oo[5],tonumber(Oo[6]))elseif
Io=="L"then paintutils.drawLine(Oo[2],Oo[3],Oo[4],Oo[5],tonumber(Oo[6]))elseif
Io=="TEXT"then paintutils.drawText(Oo[2],Oo[3],Oo[4],Oo[5],Oo[6])end end end
local function
No(So,Ho,Ro,Do)e(1,So,"table")e(2,Ho,"number","nil")e(3,Ro,"number","nil")e(4,Do,"table","nil")Ho=Ho
or 1 Ro=Ro or 1 Do=Do or term.current()if not So.attributes or not So.data then
error("table is not valid .skimg",2)end if not Do.setCursorPos or not Do.blit
then error("tOutput is incompatible!",2)end for Lo=1,#So.data do local
Uo=So.data[Lo]Do.setCursorPos(Ho,Ro+Lo-1)Do.blit(Uo[1],Uo[2],Uo[3])end end
local function
Co(Mo,Fo,Wo,Yo)e(1,Mo,"table")e(2,Fo,"number","nil")e(3,Wo,"number","nil")e(4,Yo,"table","nil")Fo=Fo
or 1 Wo=Wo or 1 Yo=Yo or term.current()for Po=1,#Mo do local
Vo=Mo[Po]Yo.setCursorPos(Fo,Wo+Po-1)Yo.blit(Vo[1],Vo[2],Vo[3])end end local
function Bo(Go,Ko,Qo,Jo)local Xo="0"local Zo="d"local ei="o"local
ti={ei:rep(Go),Xo:rep(Go),Zo:rep(Go),}local ai={}for oi=1,Ko do local
ii={ti[1],ti[2],ti[3],oi}table.insert(ai,ii)end local
ni={attributes={width=Go,height=Ko,creator=Qo,locked=Jo,},data=ai,}return ni
end local function si(hi)e(1,hi,"string","table")local ri if fs.exists(hi)then
ri=Pa(hi)else ri=hi end if ri.attributes then return ri.attributes else return
nil,"not found"end end
return{asset={load=Pa,draw=to,drawSkgrp=Eo,drawSkimg=No,drawBlit=Co,skimg={getAttributes=si,generateDefaultSkimg=Bo,},},cache={cacheData=Da,cacheLoad=La,reload=Ma,},numericallyContains=a,keyContains=s,getFile=u,isOdd=A,split=b,cut=U,splice=W,countLines=x,getSize=I,generateRandom=Z,diceRoll=at,fread=vt,fwrite=qt,hread=Ht,getTime=ht,getZeroTime=ut,confirm=ta,readNumber=ha,poke=Ct,encfwrite=Et,encfread=It,webquire=Ft,savequire=Bt,canadianify=da,americanify=ua,insert=fa,remove=ga,shallowCopy=za,deepCopy=Ia,}