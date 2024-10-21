cp = require("component")
c = require("computer")
filesystem = require("filesystem")
local gpu

function install()
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


  shell.execute("copy /tmp/.door.lua /home/.door.lua")
  shell.execute("copy /tmp/.gautorun.lua /boot/95_door.lua")
  shell.execute("copy /tmp/.os.lua /home/.os.lua")
  filesystem.makeDirectory("/usr/dos2")
  filesystem.makeDirectory("/usr/dos2/passwd")
  passwd = filesystem.open("/usr/do2/passwd/default.txt", "w")
  passwd.write("123")
  passwd.close()
  print("Installed!")
  shell.execute("reboot")
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
  gpu.setForeground(0xFFFFFF)
  gpu.set(x, y, text)
end

gpu.setViewport(50, 25)

cls()
set_text(2, 5, "Welcome to D-OS/2 installer!")
set_text(2, 7, "Would you like to install D-OS/2 on some OPEN-OS HD? [Y/n]")

local read = io.read()
if ( read == "Y" or read == "y" ) then
  cls()
  set_text(0, 5, "Requirements")
  set_text(0, 6, "2x Tier 2 Memory or more")
  set_text(0, 7, "2x Tier 3 Screen")
  set_text(0, 8 ,"Minimum os knowledge" )
  set_text(0, 9, "Have sure? [Y/n]" )
  local read = io.read()
  if ( read == "Y" or read == "y" ) then
    install()
  end
else
  os.exit(-1) 
end







