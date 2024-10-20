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
  shell.execute("rm /tmp/.os.lua")
  shell.execute("rm /tmp/.gautorun.lua")
  shell.execute("rm /tmp/.door.lua")
  
  filesystem.makeDirectory("/usr/dos2")
  filesystem.makeDirectory("/usr/dos2/passwd")
  gpu.fill(1, 1, w, h, " ")
  gpu.setBackground(0x000000)
  set_text(0, 11, "Select an password. (Is not encrypted.)")
  password = io.read()
  passwd = io.open("/usr/dos2/passwd/.default.txt", "w")
  if passwd then
    passwd:write(password)
    passwd:close()
    cls()
    set_text(1, 10, "Your system was installed sucessfully!")
    set_text(1, 11, "You can now reboot to the new OS.")
  end
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
set_text(2, 5, "Welcome to D-OS/2 installer! (V-0.0.1-alpha)")
set_text(1, 7, "Would you like to install D-OS/2?")
set_text(1, 8, "[Y/n]. You need to have OpenOS.")

local read = io.read()
if ( read == "Y" or read == "y" ) then
  cls()
  set_text(0, 5, "Requirements")
  set_text(0, 6, "2x Tier 2 Memory (recomended for better OS.)")
  set_text(0, 7, "Tier 3 Screen (Because of resolution.)")
  set_text(0, 8, "Tier 3 Graphics Card (I Dont tested with Tier 2)")
  set_text(0, 9, "Internet Card (For installing extra.)")
  set_text(0, 10, "Minimum terminal knowledge")
  set_text(0, 12, "Have sure? [Y/n]" )
  local read = io.read()
  if ( read == "Y" or read == "y" ) then
    install()
  end
else
  os.exit(-1) 
end







