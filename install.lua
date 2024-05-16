local githubUsername = "dillon-bhatha"
local repositoryName = "minecraft_chest_monitor"
local chestMonitorScriptUrl = "https://raw.githubusercontent.com/" .. githubUsername .. "/" .. repositoryName .. "/main/chest_monitor.lua"


local response = http.get(chestMonitorScriptUrl)
if response then
    local scriptContent = response.readAll()
    response.close()
    

    local file = fs.open("chest_monitor.lua", "w")
    file.write(scriptContent)
    file.close()
    

    file = fs.open("startup.lua", "w")
    file.write("shell.run(\"chest_monitor.lua\")")
    file.close()
    
    print("Chest monitor is geïnstalleerd!")
else
    print("Kon het chest monitor script niet downloaden.")
end
