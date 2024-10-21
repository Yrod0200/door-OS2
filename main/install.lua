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
print("What is the floppy directory 3 starting ID chars? example: /b09/")
dir = io.read()

shell.execute("copy /mnt" .. dir .. ".door.lua /home/.door.lua")
shell.execute("copy /mnt".. dir ..".gautorun.lua /boot/95_door.lua")
shell.execute("copy /mnt".. dir ..".os.lua /home/.os.lua")

print("Installed!")
print("DEFAULT PASSWORD FOR LOGGING IN IS 123.")
print("Reboot now? [Y/n]")
io.read()
shell.execute("reboot")