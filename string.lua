local pstring = {}

-- from: http://lua-users.org/wiki/SplitJoin
function pstring.split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function pstring.startswith(s,prefix)
    return string.sub(s, 1, string.len(prefix))==prefix
end

function pstring.endswith(s,suffix)
    return suffix=='' or string.sub(s,-string.len(suffix))==suffix
end

return pstring
