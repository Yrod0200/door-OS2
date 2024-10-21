local fs = require("filesystem")
local cp = require("component")
local c = require("computer")
local event = require("event")

local gpu

function set_text(x, y, text)
    gpu.setForeground(0xFFFFFF)
    gpu.set(x, y, text)
  end

function have_gpu()
    if cp.isAvailable("gpu") then
        gpu = cp.gpu
        return true
    else 
        return false
    end
end

if not have_gpu() then
    c.crash("No GPU available.")
end

local w, h = gpu.getResolution()

function cls()
    gpu.setBackground(0x0000FF)
    gpu.fill(1, 1, w, h, " ")
end

function get_date()
    local uptime = math.floor(c.uptime())
    local msg = tostring(uptime)
    gpu.setForeground(0xFFFFFF)
    gpu.set(15 , 3, msg)
end

function door_os_name()
    gpu.setForeground(0xFFFFFF)
    gpu.set(2 , 2, "(D-OS/2 v1.0-alpha)")
end

function render()
    while true do
        cls()
        get_date()
        door_os_name()
        coroutine.yield()
    end
end
--fuck yall github workers

function touch_ev()
    local evname, _, xx, yy = event.pull(0.5)
    if xx and yy then
        local msg = "TOUCHED: " .. tostring(xx) .. ", " .. tostring(yy)
        set_text(10, 10, msg)
        os.sleep(1)
    end
end
function events()
    while true do
        touch_ev()
        coroutine.yield()
    end
end

function main()
    local event_t = coroutine.create(events)
    local render_t = coroutine.create(render)
    while true do
        coroutine.resume(event_t)
        coroutine.resume(render_t)
        os.sleep(0.01)
    end
end

main()
