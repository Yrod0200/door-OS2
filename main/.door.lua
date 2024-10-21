cp = require("component")
c = require("computer")
shell = require("shell")
::login::
if cp.isAvailable("gpu") then
  print("Starting...")
  
  gpu = cp.gpu

  c.beep(750, 300)
  
  gpu.setViewport(50, 25)

  w, h = gpu.getResolution()
  gpu.setBackground(0x0000FF, false)
  gpu.fill(1, 1, w, h, " ")
  gpu.setForeground(0xFFFFFF, false)  
  ww, hh = gpu.getViewport()
  gpu.set(20, 5, "D-OS/2")
  gpu.set(2, 6, "Ctrl + Alt + C to get into the Terminal.")
  c.beep(750, 3000) 
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
    c.beep(750, 2000)
    shell.execute("lua /home/.os.lua")
  else
    gpu.set(19, 17, "Incorrect!")
    c.beep(300, 2000)
    goto login
  end
end