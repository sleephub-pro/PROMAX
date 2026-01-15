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














-- จัดเตรียมข้อมูลแยกหมวดหมู่
local itemRarity = {
    ["Common"] = {"Tic Tac Sahur", "Capuchino Assasino"},
    ["Uncommon"] = {"Pipi Potato", "Capuchina Ballerina"},
    ["Rare"] = {"Salamino Penguino", "Fluriflura", "Tim Cheese"},
    ["Epic"] = {"Orangutini Ananasini", "Brr Brr Patapim", "Udin Din Din Din Dun", "Pipi Kiwi"},
    ["Legendary"] = {"Chef Crabracadabra", "Boneca Ambalabu", "Cacto Hipopotamo", "Sigma Boy"},
    ["XMAS 25"] = {"Ginger Sekolah", "67", "Elf Elf Sahur", "Santa Hotspot"},
    ["Mythic"] = {"Gorillo Watermelondrillo", "Tric Trac Barabum", "Avocadini Guffo", "Quivioli Ameleonni", "Friggo Camelo", "Pakrahmatmamat"},
    ["Secret"] = {"La Vacca Saturnita", "Tic Tac Sahur", "Pot Hotspot", "Job Job Sahur", "La Grande Combination"},
    ["Exotic"] = {"67", "Esok Sekolah", "Girafa Celestre", "Chillin Chilli", "Swag Soda", "Matteo", "Strawberelli Flamingelli", "Ketupat Kepat"},
    ["Event"] = {"Taco Block", "Tralalelodon", "Orcadon", "Blingo Tentacolo", "Eviledon"},
    ["OG"] = {"Ganganzelli Trulala", "Strawberry Elephant", "Crystalini Ananassini", "Meowl", "Spiuniru Golubiru"},
    ["Divine"] = {"Dragon Cannelloni", "Chicleteira Bicicleteira", "Crabbo Limonetta"},
    ["Admin"] = {"Admin Egg"}
}

-- ตัวแปรสถานะ
local selectedItems = {} -- เก็บค่าเป็น Table สำหรับ Multi-select
local selectedBuff = "Normal"
local autoSpawn = false

-- ตัวแปรอ้างอิง Dropdown ไข่ (เพื่อใช้สั่ง Refresh)
local EggDropdown

--- [ 1. Dropdown เลือกระดับ ] ---
OverviewSection2:Dropdown({
    Title = "เลือกระดับ (Rarity)",
    Values = {"Common","Uncommon","Rare","Epic","Legendary","XMAS 25","Mythic","Secret","Exotic","Event","OG","Divine","Admin"},
    Value = 1,
    Callback = function(v)
        -- ดึงรายชื่อตามระดับที่เลือก
        local newItems = itemRarity[v] or {}
        -- อัปเดต Dropdown อันที่สอง (Refresh)
        if EggDropdown then
            EggDropdown:Refresh(newItems, true)
            selectedItems = {} -- ล้างค่าที่เคยเลือกไว้เมื่อเปลี่ยนระดับ
        end
        print("Switched to rarity: " .. v)
    end
})

--- [ 2. Dropdown เลือกบัพ ] ---
OverviewSection2:Dropdown({
    Title = "เลือกบัพ",
    Values = {"Normal", "Gold", "Diamond"},
    Value = "Normal",
    Callback = function(v)
        selectedBuff = v
    end
})

--- [ 3. Dropdown รายชื่อไข่ (ตัวรับข้อมูลจาก Rarity) ] ---
EggDropdown = OverviewSection2:Dropdown({
    Title = "เลือกไข่ (เลือกได้หลายอย่าง)",
    Values = itemRarity["Common"], -- ค่าเริ่มต้น (Common)
    Value = nil,
    Multi = true, -- สำคัญ: ทำให้เลือกได้หลายชื่อ
    Callback = function(v)
        selectedItems = v -- v จะเป็น Table เช่น {"67", "Matteo"}
    end
})

--- [ 4. ระบบ Auto Spawn & Buy ] ---
OverviewSection2:Toggle({ 
    Title = "ออโต้สเปา/ออโต้ซื้อตามที่เลือก",  
    Callback = function(v) 
        autoSpawn = v
        if autoSpawn then
            task.spawn(function()
                local RS = game:GetService("ReplicatedStorage")
                local remoteSpawn = RS.Shared.Packages.Networker["RF/RequestEggSpawn"]
                local remoteBuy = RS:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Networker"):WaitForChild("RF/BuyEgg")
                
                while autoSpawn do
                    -- ตรวจสอบว่ามีการเลือกไข่ไว้อย่างน้อย 1 อย่างไหม
                    if #selectedItems > 0 then
                        for _, baseName in pairs(selectedItems) do
                            if not autoSpawn then break end
                            
                            -- รวมชื่อบัพกับชื่อไข่
                            local fullName = (selectedBuff == "Normal") and baseName or (selectedBuff .. " " .. baseName)
                            
                            -- สั่ง Spawn และ ซื้อ
                            pcall(function()
                                remoteSpawn:InvokeServer()
                                remoteBuy:InvokeServer(fullName, 1)
                            end)
                            
                            task.wait(0.05) -- ความเร็วในการซื้อแต่ละชนิด
                        end
                    else
                        -- ถ้าไม่ได้เลือกไข่เลย ให้รอ
                        task.wait(0.01)
                    end
                    task.wait(0.1)
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








OverviewSection1:Toggle({
    Title = "ออโต้วางไข่",
    Callback = function(Value)
        getgenv().AutoEgg = Value
        
        if Value then
            task.spawn(function()
                local remote = game:GetService("ReplicatedStorage").Shared.Packages.Networker["RF/PlaceEgg"]
                local player = game:GetService("Players").LocalPlayer
                
                -- ลูป 1 ถึง 50
                for i = 1, 50 do
                    if not getgenv().AutoEgg then break end
                    
                    local standName = "Stand" .. i
                    local gearNames = {} -- เก็บชื่อของที่จะส่งไป Remote
                    
                    -- ตรวจสอบของใน StarterGear และสั่งให้ถือ
                    if player:FindFirstChild("StarterGear") then
                        local backpack = player:FindFirstChild("Backpack")
                        local character = player.Character
                        local humanoid = character and character:FindFirstChild("Humanoid")

                        for _, tool in pairs(player.StarterGear:GetChildren()) do
                            -- 1. เก็บชื่อเพื่อส่ง Remote
                            table.insert(gearNames, tool.Name)
                            
                            -- 2. สั่งให้ถือของ (ต้องหาจาก Backpack เพราะ StarterGear ถือไม่ได้)
                            if backpack and humanoid then
                                local toolToEquip = backpack:FindFirstChild(tool.Name)
                                if toolToEquip then
                                    humanoid:EquipTool(toolToEquip) -- สั่งให้ถือทันที
                                end
                            end
                        end
                    end
                    
                    -- เตรียม Arguments
                    local arguments = {
                        [1] = standName,
                        [2] = gearNames -- ส่งชื่อไฟล์ที่เจอ
                    }

                    -- ยิง Remote
                    pcall(function()
                        remote:InvokeServer(unpack(arguments))
                    end)
                    
                    task.wait(1) 
                end
            end)
        else
            getgenv().AutoEgg = false
            -- ถ้าอยากให้เลิกถือของเมื่อปิด Toggle ให้เพิ่มโค้ด UnequipTools ตรงนี้ได้
             if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                 game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
             end
        end
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
