cp = require("component")
c = require("computer")
shell = require("shell")
::login::
if cp.isAvailable("gpu") then
  print("Starting...")
  
  gpu = cp.gpu
  
  gpu.setViewport(50, 25)

  w, h = gpu.getResolution()
  gpu.setBackground(0x0000FF, false)
  gpu.fill(1, 1, w, h, " ")
  gpu.setForeground(0xFFFFFF, false)  
  ww, hh = gpu.getViewport()
  gpu.set(20, 5, "D-OS/2")
  gpu.set(2, 6, "Ctrl + Alt + C to get into the Terminal.")
  os.sleep(3)  
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
  if chunk == "123" then
    os.sleep(2)
    shell.execute("lua /home/.os.lua")
    os.sleep(3)
  else
    gpu.set(19, 17, "Incorrect!")
    goto login
  end
end