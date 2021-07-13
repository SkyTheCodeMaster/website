local function e(t)local
a=t:gsub("|","&#124;"):gsub(",","&#44"):gsub("}","&#125;")return a end local
function o(i,n)local s="?{"..i for h,r in pairs(n)do
s=s.."|"..tostring(h)..","..tostring(r)end s=s.."}"return s end local function
d(l,u,c,m)local f=""if m then f=f.."[["end f=f..l.."D"..u.."+"..c if m then
f=f.."]]"end return f end
return{conditionCharacters=e,makePrompt=o,makeDiceRoll=d,}