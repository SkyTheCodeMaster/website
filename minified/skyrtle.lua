local e=require("cc.expect").expect local t={0,0,0,0,}if
fs.exists(".skyrtle")then local a=fs.open(".skyrtle","r")local
o=a.readAll()a.close()local t=textutils.unserialize(o)else t={0,0,0,0}end local
function i(n,s)local h=fs.open(n,"w")h.write(s)h.close()end local r=true local
d,l,u=gps.locate()if not d then d,l,u=0,0,0 r=false end if r and t[1]~=d or
t[2]~=l or t[3]~=u then else t={d,l,u,0}i(".skyrtle",textutils.serialize(t))end
local
c={[0]="north","east","south","west",north=0,east=1,south=2,west=3,oppo={[0]=2,3,0,1,}}local
function m(d,l,u,f)local w if type(f)=="number"then w=f elseif
type(f)=="string"then w=c[f]end if not w then
error("Direction lookup failed! facing contains an invalid value!")end if w==0
then u=u-1 elseif w==1 then d=d+1 elseif w==2 then u=u+1 elseif w==3 then d=d-1
end return d,l,u end local function y()if not r then return false end local
p={gps.locate()}turtle.foward()local v={gps.locate()}if p[1]+1==v[1]then return
1 elseif p[1]-1==v[1]then return 3 elseif p[3]+1==v[3]then return 2 elseif
p[3]-1==v[3]then return 0 end end local b=turtle local function
g(k)e(1,k,"number","nil")k=k or 1 local q for j=1,k do q=b.forward()if not q
then break end t[1],t[2],t[3]=m(t[1],t[2],t[3],facing)end if not q and r then
local x={gps.locate()}if x[1]==t[1]and x[2]==t[2]and x[3]==t[3]then return true
else return false end else return true end return true end local function
z(E)e(1,E,"number","nil")E=E or 1 local T for A=1,E do T=b.back()if not T then
break end t[1],t[2],t[3]=m(t[1],t[2],t[3],c.oppo[facing])end if not T and r
then local O={gps.locate()}if O[1]==t[1]and O[2]==t[2]and O[3]==t[3]then
i(".skyrtle",textutils.serialize(t))return true else return false end else
return true end return true end local function I(N)e(1,N,"number","nil")N=N or
1 local S for H=1,N do S=b.up()if not S then break end t[2]=t[2]+1 end if not S
and r then local R={gps.locate()}if R[1]==t[1]and R[2]==t[2]and R[3]==t[3]then
i(".skyrtle",textutils.serialize(t))return true else return false end else
return true end return true end local function D(L)e(1,L,"number","nil")L=L or
1 local U for C=1,L do U=b.down()if not U then break end t[2]=t[2]-1 end if not
U and r then local M={gps.locate()}if M[1]==t[1]and M[2]==t[2]and
M[3]==t[3]then i(".skyrtle",textutils.serialize(t))return true else return
false end else return true end return true end local function
F(W)e(1,W,"number","nil")W=W or 1 for Y=1,W do local
P=b.turnLeft()facing=((facing-1)%4)if not P then
i(".skyrtle",textutils.serialize(t))return false end end
i(".skyrtle",textutils.serialize(t))end local function
V(B)e(1,B,"number","nil")B=B or 1 for G=1,B do local
K=b.turnRight()facing=((facing+1)%4)if not K then
i(".skyrtle",textutils.serialize(t))return false end end
i(".skyrtle",textutils.serialize(t))end local function Q()return
facing,c[facing]end local function J()return t[1],t[2],t[3]end local function
X(d,l,u)e(1,d,"number")e(1,l,"number")e(1,u,"number")t={d,l,u,facing}i(".skyrtle",textutils.serialize(t))end
local function Z()turtle.forward=g turtle.back=z turtle.up=I turtle.down=D
turtle.turnLeft=F turtle.turnRight=V return(turtle.forward==g and
turtle.back==z and turtle.up==I and turtle.down==D and turtle.turnLeft==F and
turtle.turnRight==V)end
return{dirLookup=c,forward=g,back=z,up=I,down=D,turnLeft=F,turnRight=V,getFacing=Q,calcFacing=y,getPosition=J,setPosition=X,hijack=Z,}