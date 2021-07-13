local e=require("cc.expect").expect local function t()local
a,o=term.getCursorPos()local
i={fg=term.getTextColour(),bg=term.getBackgroundColour(),x=a,y=o,}return i end
local function
n(s)term.setCursorPos(s.x,s.y)term.setTextColour(s.fg)term.setBackgroundColour(s.bg)end
local function h(r,d,l,u)local c,m,f,w if l<=r then c=l m=r else c=r m=l end if
u<=d then f=u w=d else f=d w=u end return c,m,f,w end local function
y(p,v,b,g,k,q)local j=t()p,b,v,g=h(p,v,b,g)local x=b-p+1 for z=v,g do
q.setCursorPos(p,z)q.blit((" "):rep(x),("f"):rep(x),colours.toBlit(k):rep(x))end
n(j)end local function E(T,A)e(1,T,"table")e(2,A,"number")if A>100 then A=100
end local
O=math.floor(A/(100/T.w)+0.5)y(T.x,T.y,T.x+T.w-1,T.y+T.h-1,T.bg,T.terminal)if
O~=0 then y(T.x,T.y,T.x+O-1,T.y+T.h-1,T.fg,T.terminal)end return A end local
I={}local N={__index=I,}function
I:update(S)e(1,S,"number")self.fill=E(self,S)end function
I:redraw()E(self,self.fill)end local function
H(R,D,L,U,C,M,F,W)e(1,R,"number")e(2,D,"number")e(3,L,"number")e(4,U,"number")e(5,C,"number")e(6,M,"number")e(7,F,"number","nil")e(8,W,"table","nil")F=F
or 0 W=W or term.current()local
I={x=R,y=D,w=L,h=U,fg=C,bg=M,fill=F,terminal=W,}y(R,D,R+L-1,D+U-1,M,W)if F~=0
then E(I,F)end return setmetatable(I,N)end return
setmetatable({create=H,},{__call=function(Y,...)return
H(...)end})