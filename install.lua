response = http.get("https://raw.githubusercontent.com/dillon-bhatha/minecraft_chest_monitor/main/chest_monitor.lua")

if response then
    local content = response.readAll()
    response.close()
    local file = fs.open("chest_monitor.lua", "w")
    file.write(content)
    file.close()

    local startupFile = fs.open("startup.lua", "w")
    startupFile.write("shell.run('chest_monitor.lua')")
    startupFile.close()

    shell.run("reboot")
else
    print("")
end
