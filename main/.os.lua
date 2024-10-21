local fs = require("filesystem")
local cp = require("component")
local c = require("computer")
local e = require("event")
function have_gpu()
  if cp.isAvailable("gpu") then
    return true, cp.gpu
  else 
    return false
  end
end

local success, gpu = have_gpu()

function cls()
  while true do
    local w, h = gpu.getResolution()
    gpu.setBackground(0x0000FF)
    gpu.fill(1, 1, w, h, " ")
    coroutine.yield()
  end
end

function get_date()
    uptime = c.uptime() 
    free_mem = "  FREE RAM: " .. tostring(c.freeMemory()) 
    msg = uptime .. free_mem
    gpu.setForeground(0xFFFFFF)
    gpu.set(w/2 - -#msg, 5, msg)
end
function door_os_name()
      gpu.setForeground(0xFFFFFF)
      gpu.set(w -2 , h - 2, D-OS/2)
end

function render()
while true do
    get_date()
    door_os_name()
    coroutine.yield()
end
end

function get_device_added()
    local _, device, type = event.pull("component_added")
    gpu.setForeground(0xFFFFFF)
    msg = "Device " .. type .. "Connected."
    c.beep(750, 300)
    gpu.set(w/2 -#msg , 2 - 2, msg)
    coroutine.yield()
end

g_d_add = coroutine.create(get_device_added)

function events()
while true do
    os.sleep(0.0001)
    g_d_add.resume()
end
end
cls_t = coroutine.create(cls)
hello_t = coroutine.create(render)
event_t = coroutine.create(events)
function main()
  while true do
    local success, gpu = have_gpu()
    if success then
      os.sleep(0.0001)
      coroutine.resume(event_t)
      os.sleep(0.0001)
      coroutine.resume(cls_t)
      os.sleep(0.0001)
      coroutine.resume(hello_t)
    else
      c.crash("No GPU available.")
    end
  end
end

main()