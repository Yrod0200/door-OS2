local fs = require("filesystem")
local cp = require("component")
local c = require("computer")


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
  while true do
    gpu.setForeground(0xFFFFFF)
    gpu.set(25, 5, "HELLO!")
    coroutine.yield()
  end
end

cls_t = coroutine.create(cls)
hello_t = coroutine.create(get_date)

function main()
  while true do
    local success, gpu = have_gpu()
    if success then
      os.sleep(0.01)
      coroutine.resume(cls_t
      os.sleep(0.01)
      coroutine.resume(hello_t)
    else
      c.crash("No GPU available.")
    end
  end
end

main()