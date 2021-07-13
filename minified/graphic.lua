local e={}local t,a={},{}for o=1,16 do
a[2^(o-1)]=("0123456789abcdef"):sub(o,o)t[("0123456789abcdef"):sub(o,o)]=2^(o-1)end
function e.drawFilledBox(i,n,s,h,r,d)d=d or term.current()local
l,u=d.getCursorPos()local c=a[r]local m=tonumber(s)-tonumber(i)+1 for
f=tonumber(n),tonumber(h)do
d.setCursorPos(tonumber(i),f)d.blit(string.rep(" ",m),string.rep(c,m),string.rep(c,m))end
d.setCursorPos(l,u)end function e.drawBox(w,y,p,v,b,g)g=g or
term.current()local k=g.getTextColour()local q=g.getBackgroundColour()local
j,x=g.getCursorPos()paintutils.drawBox(tonumber(w),tonumber(y),tonumber(p),tonumber(v),tonumber(b),g)g.setCursorPos(j,x)g.setTextColour(k)g.setBackgroundColour(q)end
function e.drawPixel(z,E,T,A)A=A or term.current()local
O=A.getTextColour()local I=A.getBackgroundColour()local
N,S=A.getCursorPos()paintutils.drawPixel(tonumber(z),tonumber(E),tonumber(T),A)A.setCursorPos(N,S)A.setTextColour(O)A.setBackgroundColour(I)end
function e.drawText(H,R,D,L,U,C)C=C or term.current()local
M=C.getTextColour()local F=C.getBackgroundColour()local
W,Y=C.getCursorPos()C.setCursorPos(tonumber(H),tonumber(R))C.setTextColour(tonumber(D))C.setBackgroundColour(tonumber(L))C.write(U)C.setCursorPos(W,Y)C.setTextColour(M)C.setBackgroundColour(F)end
function e.drawLine(P,V,B,G,K,Q)Q=Q or term.current()local
J=Q.getTextColour()local X=Q.getBackgroundColour()local
Z,et=Q.getCursorPos()paintutils.drawLine(tonumber(P),tonumber(V),tonumber(B),tonumber(G),tonumber(K))Q.setCursorPos(Z,et)Q.setTextColour(J)Q.setBackgroundColour(X)end
return
e