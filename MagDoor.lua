--MagDoor Reader Script by TardotZ
--V1.0.3
--Setup Program
local component = require("component")
local event = require("event")
filesystem = require("filesystem")
door = component.os_door
door.close()
--See if Config File exists, if not then create it and set the setup value to 0
	if filesystem.exists("/etc/door.conf") == false then
local conf = io.open("/etc/door.conf", "w")
		conf:write("Door Conf File", "n")
		conf:write("0", "n")
		conf:close()
		print("Config File was Corrupt or Missing")
		print("Please Restart the Program")
	else
--	Otherwise if the Config File DOES exsist then see if the setup value is 0 or 1. If 0 then setup the program, Otherwise continue
local conf = io.open("/etc/door.conf", "r")
		conf:read("*l")
local setup = conf:read("*l")
	if setup == "0" then
--	Setup Config file with Access requirements
		conf:close()
		print("Program not setup yet!")
		print("Generating Config...")
local conf = io.open("/etc/door.conf", "w")
		conf:write("Door Conf File", "n")
		conf:write("1", "n")
		print("Please Swipe the ID you want to use now")
local sEName, Suuid, Sname, Sdata = event.pull(100, "magData")
		print("Setting Values:")
		print(Sname)
		print(Sdata)
		print(Suuid)
		print(sEName)
		print("--------------------------")
		conf:write(sEName .. "n" .. Suuid .. "n" .. Sname .. "n" .. Sdata .. "n")
		conf:close()
		print("Config Saved")
		print("Please Restart the Program")
	else
		print("Loading Config...")
--	Read The Config
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
--	Wait for Card Swipe
local eName, uuid, name, data = event.pull("magData")
local ndata = tonumber(data)
--		Check if Card has special codes such as, Master and Exit codes.
		if ndata == 88 then
			door.toggle()
			break
		elseif ndata == 99 then 
			door.toggle()
			os.sleep(3)
			door.toggle()
--		Else Check if card has access to the room
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
--		Else print to the screen incorrect card info
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