cp = require("component")
c = require("computer")
local gpu

function install(dir)
  shell = require("shell")
  f = require("filesystem")
    if f.exists("/home/.door.lua") == true then
      shell.execute("rm /home/.door.lua")
    end
    if f.exists("/boot/95_door.lua") == true then
      shell.execute("rm /boot/95_door.lua")
    end
    if f.exists("/home/.os.lua") == true then
      shell.execute("rm /home/.os.lua")
    end


  shell.execute("copy /mnt" .. dir .. ".door.lua /home/.door.lua")
  shell.execute("copy /mnt".. dir ..".gautorun.lua /boot/95_door.lua")
  shell.execute("copy /mnt".. dir ..".os.lua /home/.os.lua")
end


if cp.isAvailable("gpu") then
gpu = cp.gpu
else 
  c.crash("No GPU Available.")
end

function cls()
  gpu.setBackground(0x0000FF)
  w, h = gpu.getResolution()
  gpu.fill(1, 1, w, h, " ")
end
function set_text(x, y, text)
  local w, _ = gpu.getResolution()
  local x = math.floor((w - #text) / 2)
  gpu.setForeground(0xFFFFFF)
  gpu.set(x , y, text)
end

gpu.setViewport(50, 25)

cls()
set_text(10, 5, "Welcome to D-OS/2 installer!")
set_text(2, 7, "Would you like to install D-OS/2 on some OPEN-OS HD? [Y/n]")

read = io.read()
if ( read == "Y" or read == "y" ) then
  cls()
  set_text(10, 5, "Select Disk then type the first three leters.")
    i = 8
  for addr in cp.list("filesys") do
    set_text(12, i, addr)
    i = i + 3
  end
  set_text(12, 23, "Select the filesystem to install. example:b09")
  local dir = io.read()
  dir = "/" .. dir .. "/"
  install(dir)
else
  os.exit(-1) 
end







