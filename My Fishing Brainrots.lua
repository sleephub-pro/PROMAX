--[[

    WindUI Example (wip)
    
]]


local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end
end

--[[

WindUI.Creator.AddIcons("solar", {
    ["CheckSquareBold"] = "rbxassetid://132438947521974",
    ["CursorSquareBold"] = "rbxassetid://120306472146156",
    ["FileTextBold"] = "rbxassetid://89294979831077",
    ["FolderWithFilesBold"] = "rbxassetid://74631950400584",
    ["HamburgerMenuBold"] = "rbxassetid://134384554225463",
    ["Home2Bold"] = "rbxassetid://92190299966310",
    ["InfoSquareBold"] = "rbxassetid://119096461016615",
    ["PasswordMinimalisticInputBold"] = "rbxassetid://109919668957167",
    ["SolarSquareTransferHorizontalBold"] = "rbxassetid://125444491429160",
})--]]


function createPopup()
    return WindUI:Popup({
        Title = "Welcome to the WindUI!",
        Icon = "bird",
        Content = "Hello!",
        Buttons = {
            {
                Title = "Hahaha",
                Icon = "bird",
                Variant = "Tertiary"
            },
            {
                Title = "Hahaha",
                Icon = "bird",
                Variant = "Tertiary"
            },
            {
                Title = "Hahaha",
                Icon = "bird",
                Variant = "Tertiary"
            }
        }
    })
end



-- */  Window  /* --
local Window = WindUI:CreateWindow({
    Title = "SLEEP HUB PRO MAX",
    --Author = "by .ftgs • Footagesus",
    Folder = "ftgshub",
    Icon = "rbxassetid://121030902371363",
    --IconSize = 22*2,
    NewElements = true,
    --Size = UDim2.fromOffset(700,700),
    
    HideSearchBar = false,
    
    OpenButton = {
        Title = "Open  UI", -- can be changed
        CornerRadius = UDim.new(1,0), -- fully rounded
        StrokeThickness = 3, -- removing outline
        Enabled = true, -- enable or disable openbutton
        Draggable = true,
        OnlyMobile = false,
        
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("#30FF6A"), 
            Color3.fromHex("#e7ff2f")
        )
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac", -- Default or Mac
    },

    --[[
    KeySystem = {
        Title = "Key System Example  |  WindUI Example",
        Note = "Key System. Key: 1234",
        KeyValidator = function(EnteredKey)
            if EnteredKey == "1234" then
                createPopup()
                return true
            end
            return false
            -- return EnteredKey == "1234" -- if key == "1234" then return true else return false end
        end
    }
    ]]
})

--createPopup()

--Window:SetUIScale(.8)

-- */  Tags  /* --
do
    Window:Tag({
        Title = "v" .. WindUI.Version,
        Icon = "github",
        Color = Color3.fromHex("#1c1c1c"),
        Border = true,
    })
end

-- */  Theme (soon)  /* --
do
    --[[WindUI:AddTheme({
        Name = "Stylish",
        
        Accent = Color3.fromHex("#3b82f6"), 
        Dialog = Color3.fromHex("#1a1a1a"), 
        Outline = Color3.fromHex("#3b82f6"),
        Text = Color3.fromHex("#f8fafc"),  
        Placeholder = Color3.fromHex("#94a3b8"),
        Button = Color3.fromHex("#334155"), 
        Icon = Color3.fromHex("#60a5fa"), 
        
        WindowBackground = Color3.fromHex("#0f172a"),
        
        TopbarButtonIcon = Color3.fromHex("#60a5fa"),
        TopbarTitle = Color3.fromHex("#f8fafc"),
        TopbarAuthor = Color3.fromHex("#94a3b8"),
        TopbarIcon = Color3.fromHex("#3b82f6"),
        
        TabBackground = Color3.fromHex("#1e293b"),    
        TabTitle = Color3.fromHex("#f8fafc"),
        TabIcon = Color3.fromHex("#60a5fa"),
        
        ElementBackground = Color3.fromHex("#1e293b"),
        ElementTitle = Color3.fromHex("#f8fafc"),
        ElementDesc = Color3.fromHex("#cbd5e1"),
        ElementIcon = Color3.fromHex("#60a5fa"),
    })--]]
    
    -- WindUI:SetTheme("Stylish")
end


-- */  Colors  /* --
local Purple = Color3.fromHex("#7775F2")
local Yellow = Color3.fromHex("#ECA201")
local Green = Color3.fromHex("#10C550")
local Grey = Color3.fromHex("#83889E")
local Blue = Color3.fromHex("#257AF7")
local Red = Color3.fromHex("#EF4F1D")


-- */ Other Functions /* --
local function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
    
    local currentIndent = string.rep(" ", level * indent)
    local nextIndent = string.rep(" ", (level + 1) * indent)
    
    if luau_table == nil then
        return "null"
    end
    
    local dataType = type(luau_table)
    
    if dataType == "table" then
        if visited[luau_table] then
            return "\"[Circular Reference]\""
        end
        
        visited[luau_table] = true
        
        local isArray = true
        local maxIndex = 0
        
        for k, _ in pairs(luau_table) do
            if type(k) == "number" and k > maxIndex then
                maxIndex = k
            end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        
        local count = 0
        for _ in pairs(luau_table) do
            count = count + 1
        end
        if count ~= maxIndex and isArray then
            isArray = false
        end
        
        if count == 0 then
            return "{}"
        end
        
        if isArray then
            if count == 0 then
                return "[]"
            end
            
            local result = "[\n"
            
            for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
                if i < maxIndex then
                    result = result .. ","
                end
                result = result .. "\n"
            end
            
            result = result .. currentIndent .. "]"
            return result
        else
            local result = "{\n"
            local first = true
            
            local keys = {}
            for k in pairs(luau_table) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then
                    return tostring(a) < tostring(b)
                else
                    return type(a) < type(b)
                end
            end)
            
            for _, k in ipairs(keys) do
                local v = luau_table[k]
                if not first then
                    result = result .. ",\n"
                else
                    first = false
                end
                
                if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
                else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
                end
                
                result = result .. parseJSON(v, indent, level + 1, visited)
            end
            
            result = result .. "\n" .. currentIndent .. "}"
            return result
        end
    elseif dataType == "string" then
        local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
        
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(luau_table)
    elseif dataType == "boolean" then
        return luau_table and "true" or "false"
    elseif dataType == "function" then
        return "\"function\""
    else
        return "\"" .. dataType .. "\""
    end
end

local function tableToClipboard(luau_table, indent)
    indent = indent or 4
    local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
    return jsonString
end


-- */  About Tab  /* --
do
    local AboutTab = Window:Tab({
        Title = "About WindUI",
        Desc = "Description Example", 
        Icon = "solar:info-square-bold",
        IconColor = Grey,
        IconShape = "Square",
    })
    
    local AboutSection = AboutTab:Section({
        Title = "About WindUI",
    })
    
    AboutSection:Image({
        Image = "https://repository-images.githubusercontent.com/880118829/22c020eb-d1b1-4b34-ac4d-e33fd88db38d",
        AspectRatio = "16:9",
        Radius = 9,
    })
    
    AboutSection:Space({ Columns = 3 })
    
    AboutSection:Section({
        Title = "What is WindUI?",
        TextSize = 24,
        FontWeight = Enum.FontWeight.SemiBold,
    })

    AboutSection:Space()
    
    AboutSection:Section({
        Title = [[WindUI is a stylish, open-source UI (User Interface) library specifically designed for Roblox Script Hubs.
Developed by Footagesus (.ftgs, Footages).
It aims to provide developers with a modern, customizable, and easy-to-use toolkit for creating visually appealing interfaces within Roblox.
The project is primarily written in Lua (Luau), the scripting language used in Roblox.]],
        TextSize = 18,
        TextTransparency = .35,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutTab:Space({ Columns = 4 }) 
    
    
    -- Default buttons
    
    AboutTab:Button({
        Title = "Export WindUI JSON (copy)",
        Color = Color3.fromHex("#a2ff30"),
        Justify = "Center",
        IconAlign = "Left",
        Icon = "", -- removing icon
        Callback = function()
            tableToClipboard(WindUI)
            WindUI:Notify({
                Title = "WindUI JSON",
                Content = "Copied to Clipboard!"
            })
        end
    })
    AboutTab:Space({ Columns = 1 }) 
    
    
    AboutTab:Button({
        Title = "Destroy Window",
        Color = Color3.fromHex("#ff4830"),
        Justify = "Center",
        Icon = "shredder",
        IconAlign = "Left",
        Callback = function()
            Window:Destroy()
        end
    })
end



-- */  Elements Section  /* --
local ElementsSection = Window:Section({
    Title = "Elements",
})
local OtherSection = Window:Section({
    Title = "Other",
})





-- */  Overview Tab  /* --
do
    local OverviewTab = ElementsSection:Tab({
        Title = "ออโต้ฟาร็ม",
        Icon = "solar:home-2-bold",
        IconColor = Blue,
        IconShape = "Square",
    })
    
    local OverviewSection1 = OverviewTab:Section({
        Title = "ออโต้ฟาร์ม"
    })
    
    local OverviewGroup3 = OverviewTab:Group({})
    
    local OverviewSection2 = OverviewTab:Section({
        Title = "ออโต้ซื้อไข่"
    })

    local OverviewSection3 = OverviewTab:Section({
        Title = "ออโต้เก็บสัตว์"
    })
    local OverviewSection4 = OverviewTab:Section({
        Title = "ร้านค้าอาหาร"
    })
    local OverviewSection5 = OverviewTab:Section({
        Title = "อีเวนต์เครื่องบิน"
    })












local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = workspace
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ===================== DATA =====================
local itemRarity = {
    ["Common"] = {"Tic Tac Sahur", "Capuchino Assasino"},
    ["Uncommon"] = {"Pipi Potato", "Capuchina Ballerina"},
    ["Rare"] = {"Salamino Penguino", "Fluriflura", "Tim Cheese"},
    ["Epic"] = {"Orangutini Ananasini", "Brr Brr Patapim", "Udin Din Din Din Dun", "Pipi Kiwi"},
    ["Legendary"] = {"Chef Crabracadabra", "Boneca Ambalabu", "Cacto Hipopotamo", "Sigma Boy"},
    ["XMAS 25"] = {"Ginger Sekolah", "Ginger 67", "Elf Elf Sahur", "Santa Hotspot"},
    ["Mythic"] = {"Gorillo Watermelondrillo", "Tric Trac Barabum", "Avocadini Guffo", "Quivioli Ameleonni", "Friggo Camelo", "Pakrahmatmamat"},
    ["Secret"] = {"La Vacca Saturnita", "Tic Tac Sahur", "Pot Hotspot", "Job Job Sahur", "La Grande Combination"},
    ["Exotic"] = {"67", "Esok Sekolah", "Girafa Celestre", "Chillin Chilli", "Swag Soda", "Matteo", "Strawberelli Flamingelli", "Ketupat Kepat"},
    ["Event"] = {"Tralalelodon", "Orcadon", "Orcadon", "Blingo Tentacolo", "Eviledon", "Moby bobby"},
    ["OG"] = {"Ganganzelli Trulala", "Strawberry Elephant", "Crystalini Ananassini", "Meowl", "Spiuniru Golubiru"},
    ["Divine"] = {"Dragon Cannelloni", "Chicleteira Bicicleteira", "Crabbo Limonetta", "Alessio", "Mariachi Skeletoni", "Piccione Maccina"},
    ["GOD"] = {"Money Money Man", "Karloo","Pirutitoita Bicicletei","Signore","Carapace"},
    ["Admin"] = {"Admin Egg", "Taco Block"}
}

-- ===================== BUFF LIST =====================
-- Normal + ดึงชื่อบัฟจาก ReplicatedStorage.Assets.WeatherEventAssets
local allBuffs = {"Normal"}

do
    local assets = ReplicatedStorage:WaitForChild("Assets", true)
    if assets then
        local weatherFolder = assets:WaitForChild("WeatherEventAssets", true)
        if weatherFolder then
            for _, obj in ipairs(weatherFolder:GetChildren()) do
                table.insert(allBuffs, obj.Name)
            end
        end
    end
end

-- ===================== FILTER CONFIG =====================
local FILTERED_NAMES = {"Gold", "Diamond"}

local function isFilteredName(name)
    if not name then return false end
    local lowerName = string.lower(name)
    for _, filter in ipairs(FILTERED_NAMES) do
        if string.find(lowerName, string.lower(filter), 1, true) then
            return true
        end
    end
    return false
end

-- ===================== STATE =====================
local selectedRarity = {}
local selectedBuffs = {}
local selectedItems = {}
local running = false
local EggDropdown = nil
local childAddedConn = nil
local eggsFolder = Workspace:WaitForChild("CoreObjects"):WaitForChild("Eggs")
local buyDebounce = {}
local guiConns = {}

local function findRarityKeyByName(name)
    if not name then return nil end
    local lower = string.lower(name):gsub("^%s*(.-)%s*$", "%1")
    for k, _ in pairs(itemRarity) do
        if string.lower(k) == lower then
            return k
        end
    end
    return nil
end

local function contains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then return true end
    end
    return false
end

local function addFrameNameToRarity(frameName, rarityName)
    if not frameName or not rarityName then return end
    if isFilteredName(frameName) then return end
    local key = findRarityKeyByName(rarityName)
    if not key then return end
    if not contains(itemRarity[key], frameName) then
        table.insert(itemRarity[key], frameName)
    end
end

local function removeFrameNameFromAllRarities(frameName)
    for _, t in pairs(itemRarity) do
        for i = #t, 1, -1 do
            if t[i] == frameName then
                table.remove(t, i)
            end
        end
    end
end

local function buildEggListFromRarity()
    local list = {}
    for _, rarity in ipairs(selectedRarity) do
        for _, name in ipairs(itemRarity[rarity] or {}) do
            if not isFilteredName(name) and not contains(list, name) then
                table.insert(list, name)
            end
        end
    end
    return list
end

local function getTrackedItems()
    if #selectedItems > 0 then
        return selectedItems
    end
    return buildEggListFromRarity()
end

-- ===================== MATCH LOGIC =====================
local function eggMatches(eggName)
    if not eggName or eggName == "" then return false end
    local lowerEgg = string.lower(eggName)

    local baseMatch = false
    for _, t in ipairs(getTrackedItems()) do
        if string.find(lowerEgg, string.lower(t), 1, true) then
            baseMatch = true
            break
        end
    end
    if not baseMatch then return false end

    if #selectedBuffs == 0 then
        return true
    end

    local wantNormal = contains(selectedBuffs, "Normal")
    local hasAnyBuff = false

    for _, b in ipairs(allBuffs) do
        if b ~= "Normal" and string.find(lowerEgg, string.lower(b), 1, true) then
            hasAnyBuff = true
            if contains(selectedBuffs, b) then
                return true
            end
        end
    end

    if wantNormal and not hasAnyBuff then
        return true
    end

    return false
end

-- ===================== BUY LOGIC =====================
local function buyEggByName(name)
    local now = tick()
    if buyDebounce[name] and now - buyDebounce[name] < 0.8 then return end
    buyDebounce[name] = now

    task.spawn(function()
        ReplicatedStorage.Shared.Packages.Networker["RF/BuyEgg"]:InvokeServer(name)
    end)
end

local function handleEggInstance(inst)
    if inst and eggMatches(inst.Name) then
        buyEggByName(inst.Name)
    end
end

local function startWatcher()
    if running then return end
    running = true

    for _, egg in ipairs(eggsFolder:GetChildren()) do
        handleEggInstance(egg)
    end

    childAddedConn = eggsFolder.ChildAdded:Connect(function(child)
        task.wait(0.05)
        handleEggInstance(child)
    end)
end

local function stopWatcher()
    running = false
    if childAddedConn then
        childAddedConn:Disconnect()
        childAddedConn = nil
    end
end

-- ===================== UI =====================
OverviewSection2:Dropdown({
    Title = "เลือกระดับไข่",
    Values = {"Common","Uncommon","Rare","Epic","Legendary","XMAS 25","Mythic","Secret","Exotic","Event","OG","Divine","GOD","Admin"},
    Multi = true,
    Callback = function(v)
        selectedRarity = v or {}
        selectedItems = {}
        if EggDropdown then
            EggDropdown:Refresh(buildEggListFromRarity(), true)
        end
    end
})

EggDropdown = OverviewSection2:Dropdown({
    Title = "เลือกไข่",
    Values = {},
    Multi = true,
    AllowNone = true,
    Callback = function(v)
        selectedItems = v or {}
    end
})

OverviewSection2:Dropdown({
    Title = "เลือกบัฟ (Normal = ไข่ปกติ)",
    Values = allBuffs,
    Multi = true,
    Callback = function(v)
        selectedBuffs = v or {}
    end
})

OverviewSection2:Toggle({
    Title = "ออโต้ซื้อไข่",
    Callback = function(v)
        if v then
            startWatcher()
        else
            stopWatcher()
        end
    end
})
















local running = false
local RF = game:GetService("ReplicatedStorage")
    :WaitForChild("Shared")
    :WaitForChild("Packages")
    :WaitForChild("Networker")
    :WaitForChild("RF/RequestEggSpawn")

OverviewSection2:Toggle({
    Title = "ออโต้เลื่อนไข่",
    Callback = function(v)
        running = v
        if v then
            task.spawn(function()
                while running do
                    pcall(function()
                        RF:InvokeServer()
                    end)
                    task.wait(0)
                end
            end)
        end
    end
})















-- เก็บ Stand ที่เลือก (หลายค่า)
local SelectedStands = {}
local Running = false
local UpgradeThread = nil

-- Remote
local remote = game:GetService("ReplicatedStorage")
    .Shared
    .Packages
    .Networker["RF/UpgradeBrainrot"]

-- Dropdown เลือกหลาย Stand
OverviewSection1:Dropdown({
    Title = "เลือกช่องที่จะอัพเกรด",
    Values = (function()
        local t = {}
        for i = 1, 50 do
            table.insert(t, "Stand" .. i)
        end
        return t
    end)(),
    Value = { "Stand1" },
    Multi = true,
    AllowNone = false,
    Callback = function(values)
        SelectedStands = values
        print("Selected Stands:", table.concat(SelectedStands, ", "))
    end
})

-- Toggle เปิด/ปิดออโต้
OverviewSection1:Toggle({
    Title = "ออโต้อัพเกรด",
    Value = false,
    Callback = function(v)
        Running = v

        if v and not UpgradeThread then
            UpgradeThread = task.spawn(function()
                while Running do
                    for _, standName in ipairs(SelectedStands) do
                        pcall(function()
                            remote:InvokeServer(standName)
                        end)
                    end
                    task.wait(0.1) -- ปรับความเร็วได้
                end
                UpgradeThread = nil
            end)
        end
    end
})












local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local running = false

-- ===================== ITEM LIST =====================
local itemList = {
    "Template",
    "Buff Tung Tung Sahur",
    "Cavallo Virtuoso",
    "Moby Bobby",
    "67",
    "Mariachi Skeletoni",
    "Quivioli Ameleonni",
    "Santteo",
    "Karkerkar Kurkur",
    "Jolly Sahur",
    "La Rainbow",
    "Blingo Tentacolo",
    "Nooo My Hotspot",
    "Meowl",
    "Candy Caney",
    "Santa Hotspot",
    "Fluriflura",
    "Brr Brr Patapim",
    "Festive 67",
    "Girafa Celestre",
    "Pot Hotspot",
    "Money Money Man",
    "Tric Trac Barabum",
    "Orcadon",
    "Gorillo Watermelondrillo",
    "Esok Sekolah",
    "Cocofanto Elefanto",
    "Tukanno Bananno",
    "Karloo",
    "Spiuniru Golubiru",
    "Mastodontico Telepiedone",
    "Swag Soda",
    "Boneca Ambalabu",
    "Crystalini Ananassini",
    "Ginger Sekolah",
    "Chillin Chilli",
    "Presento Camelo",
    "Buff Tim Cheese",
    "La Cucaracha",
    "Rainbow Santteo",
    "Salamino Penguino",
    "Cooki",
    "Eviledon",
    "Capi Taco",
    "Cacto Hipopotamo",
    "Capuchina Ballerina",
    "Friggo Camelo",
    "Bunito Bunito Spinito",
    "Green Mean Sahur",
    "La Christmas Combination",
    "Tuesday Hand",
    "Buff Gorillo Watermelondrillo",
    "Chicleteira Bicicleteira",
    "RAAAAAH",
    "Capuchino Assasino",
    "Ogre Ogerini",
    "Skibo Boi",
    "Ganganzelli Trulala",
    "Smurf Cat",
    "Tacorita Tacorito",
    "Joe Pork",
    "Udin Din Din Din Dun",
    "El Pepe",
    "25",
    "Tim Cheese",
    "Buff Orangutini Ananasini",
    "Ketupat Kepat",
    "Buff Fluriflura",
    "2026",
    "Elf Elf Sahur",
    "Dragon Cannelloni",
    "Ginger 67",
    "Bandito Axolito",
    "Rainbow Cannelloni",
    "Pipi Kiwi",
    "Orangutini Ananasini",
    "Tralalelodon",
    "Noobi Pizzarini",
    "Chef Crabracadabra",
    "Tung Tung Sahur",
    "Torrtuginni Dragonfrutini",
    "Crabbo Limonetta",
    "Piccione Maccina",
    "Alessio",
    "Pakrahmatmamat",
    "La Vacca Presento",
    "Dul Dul Dul",
    "Strawberry Elephant",
    "Cuadramat & Pak",
    "Rainbow Chillin",
    "Job Job Sahur",
    "Cocosini Mama",
    "Sigma Boy",
    "Avocadini Guffo",
    "Matteo",
    "Tic Tac Sahur",
    "Glorbo Fruttodrillo",
    "La Grande Combination",
    "La Vacca Saturnita",
    "Strawberelli Flamingelli",
    "Pipi Potato"
}

-- ===================== CHECK NAME (IGNORE PREFIX) =====================
local function isItemAllowed(toolName)
    toolName = toolName:lower()
    for _, name in ipairs(itemList) do
        if string.find(toolName, name:lower(), 1, true) then
            return true
        end
    end
    return false
end

-- ===================== PLOT =====================
local function getMyPlot()
    for _, plot in ipairs(workspace.CoreObjects.Plots:GetChildren()) do
        if plot:GetAttribute("Owner") == LocalPlayer.Name then
            return plot
        end
    end
end

local function getNumberFromStand(name)
    return tonumber(name:match("%d+"))
end

local function getValidStand(plot)
    local standsFolder = plot:FindFirstChild("Stands")
    if not standsFolder then return nil end

    local stands = {}
    for _, stand in ipairs(standsFolder:GetChildren()) do
        if stand.Name:match("^Stand%d+$") then
            table.insert(stands, stand)
        end
    end

    table.sort(stands, function(a, b)
        return getNumberFromStand(a.Name) < getNumberFromStand(b.Name)
    end)

    for _, stand in ipairs(stands) do
        if stand:FindFirstChildWhichIsA("Model") then
            continue
        end

        local dock = stand:FindFirstChild("Models") and stand.Models:FindFirstChild("Dock")
        if dock and dock:FindFirstChild("StandHighlight") then
            continue
        end

        return stand
    end
end

-- ===================== GET TOOL =====================
local function getToolWithItem()
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
            if isItemAllowed(tool.Name) then
                return tool
            end
        end
    end
end

-- ===================== TOGGLE =====================
OverviewSection1:Toggle({
    Title = "ออโต้วางไข่",
    Callback = function(v)
        running = v

        task.spawn(function()
            while running do
                local plot = getMyPlot()
                if plot then
                    local stand = getValidStand(plot)
                    local tool = getToolWithItem()

                    if stand and tool then
                        tool.Parent = LocalPlayer.Character

                        ReplicatedStorage
                            :WaitForChild("Shared")
                            :WaitForChild("Packages")
                            :WaitForChild("Networker")
                            :WaitForChild("RF/PlaceEgg")
                            :InvokeServer(stand.Name, tool.Name)
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})



















local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local running = false

OverviewSection1:Toggle({
    Title = "ออโต้เปิดไข่",
    Callback = function(v)
        running = v

        task.spawn(function()
            while running do
                local plotsFolder = workspace:WaitForChild("CoreObjects"):WaitForChild("Plots")

                for _, plot in ipairs(plotsFolder:GetChildren()) do
                    if not running then break end

                    local owner = plot:GetAttribute("Owner")
                    if owner == player.Name then
                        local standsFolder = plot:FindFirstChild("Stands")
                        if standsFolder then
                            for _, stand in ipairs(standsFolder:GetChildren()) do
                                if not running then break end

                                -- ตรวจว่าเป็น Stand1 - Stand50
                                if stand:IsA("Model") then
                                    for _, obj in ipairs(stand:GetChildren()) do
                                        if obj:IsA("Model") then
                                            local args = {
                                                stand.Name, -- ชื่อ Stand ที่เจอ Model
                                                obj.Name    -- ชื่อ Model ที่อยู่ข้างใน
                                            }

                                            ReplicatedStorage
                                                :WaitForChild("Shared")
                                                :WaitForChild("Packages")
                                                :WaitForChild("Networker")
                                                :WaitForChild("RE/HatchEgg")
                                                :FireServer(unpack(args))
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                task.wait(0.5) -- ปรับความเร็วได้
            end
        end)
    end
})














local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlotsFolder = Workspace:WaitForChild("CoreObjects"):WaitForChild("Plots")

-- ตัวแปรสำหรับควบคุมลูป
local isAutoSelling = false

-- ฟังก์ชันค้นหา Plot ของเรา
local function getMyPlot()
    for _, plot in ipairs(PlotsFolder:GetChildren()) do
        -- ตรวจสอบ Attribute "Owner" ว่าตรงกับชื่อ หรือ UserId ของเราไหม
        local owner = plot:GetAttribute("Owner")
        
        -- ตรวจสอบทั้ง Username และ UserId เพื่อความชัวร์
        if owner == LocalPlayer.Name or owner == LocalPlayer.UserId or owner == tostring(LocalPlayer.UserId) then
            return plot
        end
    end
    return nil
end

OverviewSection1:Toggle({
    Title = "ออโต้ขาย",
    Callback = function(v)
        isAutoSelling = v
        
        if v then
            -- เริ่มการทำงาน Loop แบบแยก Thread (task.spawn)
            task.spawn(function()
                while isAutoSelling do
                    local myPlot = getMyPlot()

                    if myPlot then
                        -- 1. ยิง Remote PickupBoxes
                        local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Networker"):WaitForChild("RE/PickupBoxes")
                        if remote then
                            remote:FireServer()
                        end

                        -- หาตำแหน่ง SellPrompt ใน Plot ของเรา
                        local sellPromptPart = myPlot:FindFirstChild("SellPrompt")
                        
                        if sellPromptPart then
                            -- 2. วาป (Teleport) ไปที่ SellPrompt
                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = sellPromptPart.CFrame * CFrame.new(0, 3, 0) -- ลอยเหนือจุดนิดหน่อยกันบัค
                            end

                            -- 3. กด ProximityPrompt (ต้องใช้ Executor ที่รองรับ fireproximityprompt)
                            local prompt = sellPromptPart:FindFirstChild("ProximityPrompt")
                            if prompt then
                                fireproximityprompt(prompt)
                            end
                        else
                            warn("หา SellPrompt ใน Plot ไม่เจอ")
                        end
                    else
                        warn("หา Plot ของคุณไม่เจอ! กรุณา Claim Plot ก่อน")
                    end

                    -- รอ 0.01 วินาทีตามที่ขอ
                    task.wait(0.01)
                end
            end)
        end
    end
})











local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- ตัวแปรตั้งค่า
local thresholdValue = 0
local isRunning = false

-- ฟังก์ชันสำหรับแปลงข้อความ เช่น "$500 / Fish" หรือ "1.2K" ให้เป็นตัวเลข
local function parseMultiplier(text)
    -- ดึงตัวเลขที่อยู่หลัง $ และก่อน /
    local cleaned = text:match("%$(%d+%.?%d*[KMB]?)") or text:match("(%d+%.?%d*[KMB]?)")
    if not cleaned then return 0 end
    
    cleaned = cleaned:upper()
    local num = tonumber(cleaned:match("[%d%.]+")) or 0
    
    if cleaned:find("K") then num = num * 1000
    elseif cleaned:find("M") then num = num * 1000000
    elseif cleaned:find("B") then num = num * 1000000000 end
    
    return num
end

-- ฟังก์ชันหา Plot ของเรา
local function getMyPlot()
    for _, plot in ipairs(workspace.CoreObjects.Plots:GetChildren()) do
        -- ตรวจสอบ Owner ใน Attributes
        if plot:GetAttribute("Owner") == LocalPlayer.Name then
            return plot
        end
    end
    return nil
end

-- ฟังก์ชันหลักในการตรวจสอบและรัน Remote
local function checkStands()
    local myPlot = getMyPlot()
    if not myPlot or not myPlot:FindFirstChild("Stands") then return end

    for _, standFolder in ipairs(myPlot.Stands:GetChildren()) do
        -- หา Model ภายใน Stand Folder
        for _, model in ipairs(standFolder:GetChildren()) do
            if model:IsA("Model") then
                local multiplierPath = model:FindFirstChild("HumanoidRootPart") 
                    and model.HumanoidRootPart:FindFirstChild("BrainrotBillboard")
                    and model.HumanoidRootPart.BrainrotBillboard:FindFirstChild("Multiplier")

                if multiplierPath and multiplierPath:IsA("TextLabel") then
                    local currentVal = parseMultiplier(multiplierPath.Text)
                    
                    -- เงื่อนไข: ถ้าค่าน้อยกว่าที่กำหนด
                    if currentVal < thresholdValue then
                        -- เตรียมข้อมูลส่งเข้า Remote (ตามตัวอย่างที่คุณให้มา)
                        local remote = ReplicatedStorage:WaitForChild("Shared")
                                        :WaitForChild("Packages")
                                        :WaitForChild("Networker")
                                        :WaitForChild("RE/PickupBrainrot")
                        
                        local args = { standFolder.Name } -- เช่น "Stand4"
                        remote:FireServer(unpack(args))
                        
                        print("🔥 Pickup: " .. standFolder.Name .. " | Value: " .. currentVal)
                    end
                end
            end
        end
    end
end

--- ส่วนการเชื่อมต่อกับ UI ของคุณ ---

OverviewSection3:Input({
    Title = "ใส่ตัวเลขที่ต้องการเอาออก (เช่น 500 หรือ 1K)",
    Icon = "mouse",
    Callback = function(v)
        thresholdValue = parseMultiplier(v)
        print("✅ ตั้งค่าขีดจำกัดไว้ที่: " .. thresholdValue)
    end
})

OverviewSection3:Toggle({ 
    Title = "เอาออกออโต้", 
    Callback = function(v) 
        isRunning = v
        if isRunning then
            print("🚀 เริ่มระบบตรวจสอบ...")
            task.spawn(function()
                while isRunning do
                    checkStands()
                    task.wait(1) -- ตรวจสอบทุก 1 วินาที (ปรับเปลี่ยนได้)
                end
            end)
        else
            print("🛑 หยุดระบบตรวจสอบ")
        end
    end 
})













OverviewSection4:Toggle({
  Title = "ออโต้ซื้ออาหารทั้งหมด",
  Callback = function(v)
    if not v then
      print("Toggle ปิดแล้ว")
      return
    end

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = Players.LocalPlayer

    -- หา GUI ร้านอาหาร
    local success, guiFolder = pcall(function()
      return player:WaitForChild("PlayerGui")
        :WaitForChild("Main")
        :WaitForChild("Frames")
        :WaitForChild("FoodMerchant")
        :WaitForChild("ScrollingFrame")
        :WaitForChild("ScrollingFrame")
    end)

    if not success or not guiFolder then
      warn("หา FoodMerchant ScrollingFrame ไม่เจอ")
      return
    end

    -- Remote ซื้ออาหาร
    local remote = ReplicatedStorage
      :WaitForChild("Shared")
      :WaitForChild("Packages")
      :WaitForChild("Networker")
      :WaitForChild("RF/BuyFood")

    -- ชื่อที่ไม่ต้องสนใจ
    local excludedNames = {
      Template = true,
      Bottom = true,
      Top = true,
      Filler = true,
    }

    -- ดึงจำนวน stock จาก text เช่น x1, x12
    local function getStockCount(frame)
      for _, obj in ipairs(frame:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
          local txt = tostring(obj.Text or "")
          local num = string.match(txt, "x(%d+)")
          if num then
            return tonumber(num)
          end
        end
      end
      return nil
    end

    -- กัน spam
    local lastPurchase = {}
    local MIN_INTERVAL = 0.2 -- หน่วงต่อไอเท็ม (ปรับได้)

    task.spawn(function()
      while v do
        for _, itemFrame in ipairs(guiFolder:GetChildren()) do
          if itemFrame:IsA("Frame") and not excludedNames[itemFrame.Name] then
            local count = getStockCount(itemFrame)

            if count and count > 0 then
              local now = tick()
              if not lastPurchase[itemFrame.Name]
                or (now - lastPurchase[itemFrame.Name]) >= MIN_INTERVAL then

                local ok, err = pcall(function()
                  remote:InvokeServer(itemFrame.Name)
                end)

                if not ok then
                  warn("ซื้อไม่สำเร็จ:", itemFrame.Name, err)
                else
                  lastPurchase[itemFrame.Name] = now
                end

                task.wait(0.05)
              end
            end
          end
        end

        -- 🔁 รีตลอด ถึงของหมดก็ไม่หยุด
        task.wait(0.5) -- หน่วงรอบใหญ่ ป้องกันลูปหนักเกิน
      end

      print("ออโต้ซื้ออาหาร: หยุดแล้ว")
    end)
  end
})














local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Networker = ReplicatedStorage
	:WaitForChild("Shared")
	:WaitForChild("Packages")
	:WaitForChild("Networker")

local RF_Feed = Networker:WaitForChild("RF/Feed")
local RF_BuyFood = Networker:WaitForChild("RF/BuyFood")

local foodList = {
	Burger = true,
	Fries = true,
	Ham = true,
	Hotdog = true,
	Pizza = true
}

local running = false
local connection

local args = {} -- ใส่ args เพิ่มได้ถ้าจำเป็น

local function equipTool(tool)
	if tool and tool.Parent == Backpack then
		tool.Parent = Character
	end
end

OverviewSection4:Toggle({
	Title = "ให้อาหารทั้งหมด",
	Callback = function(v)
		running = v

		if running then
			connection = RunService.Heartbeat:Connect(function(dt)
				task.wait(0.01)

				for _, tool in ipairs(Backpack:GetChildren()) do
					if tool:IsA("Tool") and foodList[tool.Name] then
						equipTool(tool)

						pcall(function()
							RF_Feed:InvokeServer()
						end)

						pcall(function()
							RF_BuyFood:InvokeServer(unpack(args))
						end)
					end
				end
			end)
		else
			if connection then
				connection:Disconnect()
				connection = nil
			end
		end
	end
})













OverviewSection1:Toggle({
    Title = "สุ่มบัฟทุกตัว",
    Callback = function(v)
        if not v then
            _G.Toggle2Running = false
            return
        end

        _G.Toggle2Running = true

        task.spawn(function()
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local player = Players.LocalPlayer

            while _G.Toggle2Running do
                local backpack = player:FindFirstChild("Backpack")
                if backpack then
                    for _, tool in pairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") then
                            -- เช็คว่าไม่มีไฟล์ด้านใน
                            if #tool:GetChildren() == 0 then
                                local id = tool:GetAttribute("ID")
                                if id then
                                    local args = {
                                        id
                                    }

                                    ReplicatedStorage
                                        :WaitForChild("Shared")
                                        :WaitForChild("Packages")
                                        :WaitForChild("Networker")
                                        :WaitForChild("RF/MutateBrainrot")
                                        :InvokeServer(unpack(args))
                                end
                            end
                        end
                    end
                end

                task.wait(0.01)
            end
        end)
    end
})









local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

local ToggleState = false
local UsedPrompt = false

OverviewSection5:Toggle({
    Title = "ออโค้เก็บของ",
    Callback = function(v)
        ToggleState = v
        UsedPrompt = false
    end
})

task.spawn(function()
    while true do
        task.wait(0.01)

        if ToggleState and not UsedPrompt then
            local core = workspace:FindFirstChild("CoreObjects")
            if core then
                local planeCrash = core:FindFirstChild("Plane Crash")
                if planeCrash and planeCrash:IsA("Model") then

                    -- หา PrimaryPart ถ้ายังไม่มี
                    if not planeCrash.PrimaryPart then
                        planeCrash.PrimaryPart = planeCrash:FindFirstChildWhichIsA("BasePart")
                    end

                    if planeCrash.PrimaryPart and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                        -- วาป
                        LP.Character.HumanoidRootPart.CFrame =
                            planeCrash.PrimaryPart.CFrame * CFrame.new(0, 0, -3)

                        -- หา ProximityPrompt
                        local prompt = planeCrash:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt then
                            fireproximityprompt(prompt)
                            UsedPrompt = true -- กดครั้งเดียว
                        end
                    end
                end
            end
        end
    end
end)











   
end










-- */  Other  /* --
do
    local InviteCode = "dUnSsjeUDF"
    local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"

    local Response = WindUI.cloneref(game:GetService("HttpService")):JSONDecode(WindUI.Creator.Request({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "WindUI/Example",
            ["Accept"] = "application/json"
        }
    }).Body)
    
    local DiscordTab = OtherSection:Tab({
        Title = "Discord",
        Icon = "rbxassetid://121030902371363",
    })
    
    if Response and Response.guild then
        DiscordTab:Section({
            Title = "Join our Discord server!",
            TextSize = 20,
        })
        local DiscordServerParagraph = DiscordTab:Paragraph({
            Title = tostring(Response.guild.name),
            Desc = tostring(Response.guild.description),
            Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
            Thumbnail = "https://cdn.discordapp.com/banners/1300692552005189632/35981388401406a4b7dffd6f447a64c4.png?size=512",
            ImageSize = 48,
            Buttons = {
                {
                    Title = "Copy link",
                    Icon = "link",
                    Callback = function()
                        setclipboard("https://discord.gg/" .. InviteCode)
                    end
                }
            }
        })
        
    end
end




