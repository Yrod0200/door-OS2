shell = require("shell")
c = require("component")

full_dir = "/tmp/"

login_dir = full_dir .. ".door.lua"
os_dir = full_dir .. ".os.lua"
autorun_dir = full_dir .. ".gautorun.lua"
install_dir = full_dir .. "install.lua"

if c.isAvailable("internet") then 
    local result

    -- Baixar o sistema de login
    result, err = pcall(shell.execute, "wget https://raw.githubusercontent.com/Yrod0200/door-OS2/refs/heads/main/main/.door.lua " .. login_dir)
    if result then
        print("Downloaded login system...")
    else
        print("Failed to download login system: " .. err)
    end

    -- Baixar o OS
    result, err = pcall(shell.execute, "wget https://raw.githubusercontent.com/Yrod0200/door-OS2/refs/heads/main/main/.os.lua " .. os_dir)
    if result then
        print("Downloaded OS...")
    else
        print("Failed to download OS: " .. err)
    end

    -- Baixar .gautorun.lua
    result, err = pcall(shell.execute, "wget https://raw.githubusercontent.com/Yrod0200/door-OS2/refs/heads/main/main/.gautorun.lua " .. autorun_dir)
    if result then
        print("Downloaded .gautorun.lua...")
    else
        print("Failed to download .gautorun.lua: " .. err)
    end

    -- Baixar o instalador
    result, err = pcall(shell.execute, "wget https://raw.githubusercontent.com/Yrod0200/door-OS2/refs/heads/main/main/install.lua " .. install_dir)
    if result then
        print("Downloaded installer...")
        
        -- Executar o instalador
        shell.execute(install_dir)
    else
        print("Failed to download installer: " .. err)
    end
else
    print("This program needs an internet card to run.")
end
