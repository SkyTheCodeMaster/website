-- Copyright 2021 SkyTheCodeMaster - All Rights Reserved.
-- This script will convert skimg files to other files using the `skimgconvert` api.
-- Collect a version of sUtils with file read/write functions, and webquire..
local h,err = http.get("https://raw.githubusercontent.com/SkyTheCodeMaster/SkyDocs/fdf3d62fcbdaa39a957f7a074ebef95bff4a79a1/src/main/misc/sUtils.lua")
if err then error("Something went wrong whilst downloading sUtils!") end
local content = h.readAll() h.close()
local sUtils = load(content,"=prewebquire-package","t",_ENV)()

-- Collect `imgconvert` api.
local imgconvert = sUtils.webquire("https://raw.githubusercontent.com/SkyTheCodeMaster/SkyDocs/main/src/main/misc/imgconvert.lua")

local tArgs = {...}
local flags = {
  skimg = true,
  limg = true,
  blit = true,
}

local dir = fs.getDir(shell.getRunningProgram())
local pName = fs.getName(shell.getRunningProgram())

if not flags[tArgs[1]] or fs.exists(fs.combine(dir,tArgs[2])) then
  print("Usage:")
  print(pName,"<skimg/limg/blit> <file>")
  print("This converts an image (based on it's file ending)")
  print("To one of the chosen, saving in the same dir.")
  error()
end

local tFilename = sUtils.split(tArgs[2],".")
local fileName = tFilename[1]
local fileType = tFilename[2]

if not flags[fileType] then
  error("File must be a skimg, limg, or blit!")
end

local target = tArgs[1] -- Ascertain the target filetype
local newFile = fileName .. "." .. target -- New file to save to.
local img = sUtils.asset.load(fs.combine(dir,tArgs[2])) -- Load the image file
local converted = imgconvert[fileType][target](img) -- Convert it to the new filetype
local serializedImg = textutils.serialize(converted) -- Serialize it.
sUtils.fwrite(fs.combine(dir,newFile),serializedImg)
print("File saved as:",newFile)