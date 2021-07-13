-- Copyright 2021 SkyTheCodeMaster - All Rights Reserved.

-- TODO: Add async mode.
-- TODO: Replace file print with progress bar.

local expect = require("cc.expect").expect

-- Parse a `requirements.json` local file, or url.
local requirementsFile = ...

local function hread(url)
  local h,err = http.get(url)
  if not h then error("Error downloading " .. url .. ": " .. err) end
  local contents = h.readAll() h.close()
  return contents
end

local function fread(file)
  local f,err = fs.open(file,"r")
  if not f then error("Error opening " .. file .. ": " .. err) end
  local contents = f.readAll() f.close()
  return contents
end

local function fwrite(file,contents)
  local f,err = fs.open(file,"w")
  if not f then error("Error opening " .. file .. ": " .. err) end
  f.write(contents) f.close()
end

-- It's a URL. Let's download it.
local encJSON = requirementsFile:match("https://") and hread(requirementsFile) or fread(requirementsFile)
local requirements = textutils.unserializeJSON(encJSON) -- Decode the requirements and store it in `decRequirements`
if not requirements then
  error("Couldn't unserialize requirements!")
end

--- Split a string by it's separator.
-- @tparam string inputstr String to split.
-- @tparam string sep Separator to split the string by.
-- @treturn table Table containing the split string.
local function split(inputstr, sep)
  expect(1,inputstr,"string")
  expect(1,sep,"string","nil")
  sep = sep or "%s"
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

-- Will get  all files in a directory, with a download link and path.
local function getFiles(recursive,url,filter,path)
  local contents
  if filter then
    local splitURL = split(url,"/")
    local apiURL = ("https://api.github.com/repos/%s/%s/contents/%s?ref=%s"):format(splitURL[3], splitURL[4], table.concat(splitURL, "/", 7), splitURL[6]) -- Thanks, JackMacWindows!
    contents = textutils.unserializeJSON(hread(apiURL))
  else
    contents = textutils.unserializeJSON(hread(url))
  end
  local files = {}
  for _,v in pairs(contents) do
    if v.type == "dir" and recursive then
      local newFiles = getFiles(true,v["_links"].self,false,fs.combine(path,v.name))
      for _,file in pairs(newFiles) do table.insert(files,file) end
    end
    if v.type == "file" then
      local name = fs.getName(v.path)
      local path = fs.combine(path,name)
      table.insert(files,{url=v.download_url,path=path})
    end
  end
  return files
end

-- Download the output of getFiles.
local function downloadFiles(files)
  for _,v in pairs(files) do
    local content = hread(v.url)
    print("Downloading",v.path)
    fwrite(v.path,content)
  end
end

for url,data in pairs(requirements) do
  if not data.folder then
    -- Easy, just download file into specified path.
    print("Collecting",data.path)
    fwrite(data.path,hread(url))
  else
    local folder = getFiles(data.recursive,url,true,data.path)
    downloadFiles(folder)
  end
  print("Collected",data.path)
end