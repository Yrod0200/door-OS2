local fs = require("filesystem")
local cp = require("component")
local c = require("computer")
local event = require("event")

local gpu
local x 
local y

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
    gpu.setForeground(0xFFFFFF)
    gpu.set(5 , 2, uptime)
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

function event_touch()
    while true do
        local evname, _, x, y = event.pull(0.1)
        if evname == "touch" then
            local msg = "TOUCHED: " .. tostring(x) .. ", " .. tostring(y)
            set_text(0, 10, msg)
        end
            coroutine.yield()
    end
end

function events()
    e_t_c = coroutine.create(event_touch)
    while true do
        coroutine.resume(e_t_c)
        coroutine.yield()
    end
end

function main()
    local render_t = coroutine.create(render)
    local event_t = coroutine.create(events)
    while true do
        coroutine.resume(render_t)
        coroutine.resume(event_t)
        os.sleep(0.01)
    end
end

main()
