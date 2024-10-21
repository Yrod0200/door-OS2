local fs = require("filesystem")
local cp = require("component")
local c = require("computer")
local event = require("event")

local gpu

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
    local uptime = c.uptime()
    local free_mem = "  FREE RAM: " .. tostring(c.freeMemory())
    local msg = uptime .. free_mem
    gpu.setForeground(0xFFFFFF)
    gpu.set(w / 2 - #msg / 2, 5, msg)
end

function door_os_name()
    gpu.setForeground(0xFFFFFF)
    gpu.set(w - 7, h - 2, "D-OS/2")
end

function render()
    while true do
        cls()
        get_date()
        door_os_name()
        coroutine.yield()
    end
end

function get_device_added()
    local _, device, type = event.pull("component_added")
    gpu.setForeground(0xFFFFFF)
    local msg = "Device " .. type .. " connected."
    c.beep(750, 300)
    gpu.set(w / 2 - #msg / 2, 2, msg)
    coroutine.yield()
end

function events()
    while true do
        get_device_added()
        coroutine.yield()
    end
end

local render_t = coroutine.create(render)
local event_t = coroutine.create(events)

function main()
    while true do
        coroutine.resume(event_t)
        coroutine.resume(render_t)
        os.sleep(0.01)
    end
end

main()
