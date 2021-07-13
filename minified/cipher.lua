local e=require("cc.expect").expect local function t(a,o,i)i=i or" "return
a:sub(1,o)..i:rep(o-#a)end local
n={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",}local
s={}for h,r in pairs(n)do s[r]=h end local function
d(l,u)e(1,l,"string")e(2,u,"number")if l==" "then return" "end local
c=s[l]local m=c+u return n[m%26]end local function
f(w,y)e(1,w,"string")e(2,y,"number","nil")y=y or-3 w=w:gsub("%A","")local
p={}for v in w:lower():gmatch(".")do local b=d(v,y)table.insert(p,b)end local
g=table.concat(p)return g end local function
k(q,j)e(1,q,"string")e(2,q,"string")local x if j:len()<q:len()then local
z=math.ceil(q:len()/j:len())x=t(j:rep(z),q:len())elseif j:len()>q:len()then
x=t(j,q:len())else x=j end local E={}local T={}local A={}for O in
q:gmatch(".")do if O==" "then table.insert(E," ")else local
I=s[O]table.insert(E,I)end end for N in x:gmatch(".")do if N==" "then
table.insert(E," ")else local S=s[N]table.insert(T,S)end end for H=1,#E do if
E[H]==" "then table.insert(A," ")else local R=E[H]-1 local D=T[H]-1 local L=R+D
local U=n[L%26+1]table.insert(A,U)end end local C=table.concat(A)return C end
local function M(F,W)e(1,F,"string")e(2,F,"string")local Y if
W:len()<F:len()then local
P=math.ceil(F:len()/W:len())Y=t(W:rep(P),F:len())elseif W:len()>F:len()then
Y=t(W,F:len())else Y=W end local V={}local B={}local G={}for K in
F:gmatch(".")do local Q=s[K]table.insert(V,Q)end for J in Y:gmatch(".")do local
X=s[J]table.insert(B,X)end for Z=1,#V do local et=V[Z]-1 local tt=B[Z]-1 local
at=et-tt if at<0 then at=at+26 end local ot=n[at%26+1]table.insert(G,ot)end
local it=table.concat(G)return it end local function nt(st)return f(st,13)end
return{letterTable=n,numberTable=s,shiftLetter=d,caesar=f,viginere=k,viginereDecode=M,rot13=nt,}