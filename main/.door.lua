cp = require("component")
c = require("computer")
shell = require("shell")
fs = require("filesystem")
::login::
if cp.isAvailable("gpu") then
  print("Starting...")
  
  gpu = cp.gpu

  
  gpu.setViewport(75, 25)

  w, h = gpu.getResolution()
  gpu.setBackground(0x0000FF, false)
  gpu.fill(1, 1, w, h, " ")
  gpu.setForeground(0xFFFFFF, false)  
  ww, hh = gpu.getViewport()
  gpu.set(18, 5, "D-OS/2")
  gpu.set(2, 6, "Ctrl + Alt + C to get into the Terminal.")
  gpu.set(19,15, "LOGIN: ")
  
  function read()
    gpu.setForeground(0x0000FF, false) 
      char = io.read()
        gpu.setForeground(0xFFFFFF, false)
         
         lenght = string.len(char)
         pass = ""
          for a =  1, lenght do
           pass = pass .. "*"
          end
           gpu.set(25, 15, pass)
           gpu.set(19, 17, "Logging in...")
        return char
   end
     
  chunk =  read()
  file = io.open("/usr/dos2/passwd/default.txt", "r")
  passwd = file:read()
  file:close()
  if chunk == passwd then
    shell.execute("lua /home/.os.lua")
  else
    gpu.set(19, 17, "Incorrect!")
    goto login
  end
end