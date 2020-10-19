--MagDoor Reader Script by TardotZ
--V1.0.1
local component = require("component")
local event = require("event")
filesystem = require("filesystem")
door = component.os_door
door.close()
if filesystem.exists("/etc/door.conf") == false then
local conf = io.open("/etc/door.conf", "w")
conf:write("Door Conf File", "\n")
conf:write("0", "\n")
conf:close()
print("Config File was Corrupt or Missing")
print("Please Restart the Program")
else
local conf = io.open("/etc/door.conf", "r")
conf:read("*l")
local setup = conf:read("*l")
if setup == "0" then
conf:close()
print("Program not setup yet!")
print("Generating Config...")
local conf = io.open("/etc/door.conf", "w")
conf:write("Door Conf File", "\n")
conf:write("1", "\n")
print("Please Swipe the ID you want to use now")
local sEName, Suuid, Sname, Sdata = event.pull(100, "magData")
print("Setting Values:")
print(Sname)
print(Sdata)
print(Suuid)
print(sEName)
print("--------------------------")
conf:write(sEName .. "\n" .. Suuid .. "\n" .. Sname .. "\n" .. Sdata .. "\n")
conf:close()
print("Config Saved")
print("Please Restart the Program")
else
print("Loading Config...")
local conf = io.open("/etc/door.conf", "r")
conf:read("*l")
conf:read("*l")
local sEName = conf:read("*l")
local Suuid = conf:read("*l")
local Sname = conf:read("*l")
local Sdata = conf:read("*l")
print("Loaded!")
print("Set Event Name: " .. sEName)
print("Set UUIFD: " .. Suuid)
print("Set Player Name: " .. Sname)
local nSData = tonumber(Sdata)
print("Access Level: " .. nSData)
while true do
local eName, uuid, name, data = event.pull("magData")
local ndata = tonumber(data)
if ndata == 88 then
door.toggle()
break
elseif ndata == 99 then 
door.toggle()
os.sleep(3)
door.toggle()
elseif ndata >= nSData then
print("Door Opened")
print(eName)
print(uuid)
print(name)
print(data)
print("---------------------------")
door.toggle()
os.sleep(3)
door.toggle()
else
print("Incorrect Login")
print(eName)
print(uuid)
print(name)
print(data)
print("--------------------------")
end
end
end
end