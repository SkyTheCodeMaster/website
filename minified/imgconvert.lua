local function e(t)local a=#t[1][1]local o=#t
return{x=a,y=o,creator="skimgConvert",locked=false,type=1}end local function
i(n)for s=1,#n do n[s][4]=s end return n end local function h(r)if not r or not
r.data then error("Input table is not a skimg!")end return r.data end local
function d(l)if not l or not l.data then
error("Input table is not a skimg!")end return{l.data}end local function
u(c)return{attributes=e(c),data=i(c)}end local function m(f)return{f}end local
function w(y)local p=y[1]return{attributes=e(p),data=i(p)}end local function
v(b)return b[1]end
return{skimg={blit=h,limg=d,},blit={skimg=u,limg=m,},limg={skimg=w,blit=v,},}