function print_inventory_on_monitor(chest, monitor)
    monitor.clear()
    
    local width, height = monitor.getSize()
    
    local items = chest.list()
    
    local itemCount = 0
    for slot, item in pairs(items) do
        itemCount = itemCount + 1
    end

    local startY = math.floor((height - itemCount) / 2) + 1
    
    local line = startY
    for slot, item in pairs(items) do
        if line > height then
            break
        end
        local displayName = item.name:gsub("minecraft:", "")
        local text = item.count .. "x " .. displayName
        local textLength = #text
        local startX = math.floor((width - textLength) / 2) + 1
        monitor.setCursorPos(startX, line)
        monitor.write(text)
        line = line + 1
    end
end

function setup_peripherals()
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("minecraft:chest")

    if not monitor then
        print("No monitor found. Attaching monitor to the right side of the computer.")
        periphemu.create('right', 'monitor')
        monitor = peripheral.find("monitor")
        if monitor then
            monitor.setTextScale(0.5)
        end
    end

    if not chest then
        print("No chest found. Attaching chest to the left side of the computer.")
        periphemu.create('left', 'minecraft:chest', false)

        chest = peripheral.find("minecraft:chest")
        chest.setItem(1, {name="minecraft:diamond", count=42})
        chest.setItem(2, {name="minecraft:iron_ingot", count=24})
        chest.setItem(3, {name="minecraft:gold_ingot", count=12})
    end

    return monitor, chest
end

local monitor, chest = setup_peripherals()

while true do
    if monitor and chest then
        print_inventory_on_monitor(chest, monitor)
    else
        print("Monitor or chest not found.")
        monitor, chest = setup_peripherals()
    end

    sleep(10)
end