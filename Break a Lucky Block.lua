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












local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer

-- Toggle state
local runningBrainrot = false
local runningLucky = false

-- Priority state
local brainrotBusy = false
local luckyWasRunning = false

-- Config
local cashLimit = 0
local FLOAT_SPEED = 33
local DROP_DISTANCE = 50
local LINE_FORWARD_OFFSET = 8

--------------------------------------------------
-- Utils
--------------------------------------------------
local function getHRP()
	return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function extractNumber(text)
	if not text then return nil end
	text = text:gsub("%$", ""):gsub("/s", ""):gsub("%s", "")

	if text:lower():find("k") then
		local n = tonumber(text:lower():gsub("k", ""))
		return n and n * 1000
	end
	if text:lower():find("m") then
		local n = tonumber(text:lower():gsub("m", ""))
		return n and n * 1000000
	end

	text = text:gsub(",", "")
	return tonumber(text)
end

local function teleportTo(pos)
	local hrp = getHRP()
	if hrp and pos then
		hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
	end
end

local function floatToCFrame(cf)
	local hrp = getHRP()
	if not hrp or not cf then return end

	local dist = (hrp.Position - cf.Position).Magnitude
	local time = dist / FLOAT_SPEED

	local tween = TweenService:Create(
		hrp,
		TweenInfo.new(time, Enum.EasingStyle.Linear),
		{CFrame = cf}
	)
	tween:Play()
	tween.Completed:Wait()
end

local function dropDown()
	local hrp = getHRP()
	if hrp then
		hrp.CFrame = hrp.CFrame - Vector3.new(0, DROP_DISTANCE, 0)
	end
end

local function pressKey1()
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
	task.wait(0.05)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)
end

--------------------------------------------------
-- Line position
--------------------------------------------------
local function getLineCFrame()
	local line = workspace:FindFirstChild("Line")
	if not line then return nil end

	local part =
		line:IsA("BasePart") and line
		or line.PrimaryPart
		or line:FindFirstChildWhichIsA("BasePart")

	if not part then return nil end

	local front = part.Position + (part.CFrame.LookVector * LINE_FORWARD_OFFSET)
	return CFrame.new(front + Vector3.new(0,3,0), front + part.CFrame.LookVector)
end

--------------------------------------------------
-- Brainrot LOOP (หลัก)
--------------------------------------------------
task.spawn(function()
	while task.wait(0.2) do
		if not runningBrainrot then continue end
		if not workspace:FindFirstChild("Brainrots") then continue end

		for _, m in ipairs(workspace.Brainrots:GetChildren()) do
			if not runningBrainrot then break end

			local label = m:FindFirstChild("CharCash", true)
			if label and label:IsA("TextLabel") then
				local cash = extractNumber(label.Text)
				if cash and cash > cashLimit then

					-- หยุด LuckyBlocks
					brainrotBusy = true
					luckyWasRunning = runningLucky
					runningLucky = false

					local part = m:FindFirstChildWhichIsA("BasePart", true)
					if part then
						teleportTo(part.Position)
						task.wait(0.1)

						-- กด Prompt
						local prompt = m:FindFirstChildWhichIsA("ProximityPrompt", true)
						while prompt and prompt.Parent and runningBrainrot do
							fireproximityprompt(prompt)
							task.wait(0.2)
						end

						-- ลงล่าง
						dropDown()
						task.wait(0.05)

						-- ไป Line
						local lineCF = getLineCFrame()
						if lineCF then
							floatToCFrame(lineCF)

							-- ⭐ เพิ่มตามที่ขอ
							task.wait(1)
							pressKey1()
						end
					end

					-- Brainrot จบ → LuckyBlocks กลับมา
					brainrotBusy = false
					if luckyWasRunning then
						runningLucky = true
						luckyWasRunning = false
					end
				end
			end
		end
	end
end)

--------------------------------------------------
-- LuckyBlocks LOOP (รอง)
--------------------------------------------------
task.spawn(function()
	while task.wait(0.3) do
		if not runningLucky then continue end
		if brainrotBusy then continue end
		if not workspace:FindFirstChild("LuckyBlocks") then continue end

		for _, block in ipairs(workspace.LuckyBlocks:GetChildren()) do
			if not runningLucky or brainrotBusy then break end

			if block.Name ~= "Basic Block" then
				local part = block:IsA("BasePart")
					and block
					or block:FindFirstChildWhichIsA("BasePart")

				if part then
					teleportTo(part.Position)
					task.wait(0.3)
				end
			end
		end
	end
end)



 OverviewSection1:Input({
 	Title = "Brainrot $/s",
 	Callback = function(v)
 		cashLimit = tonumber(v) or 0
 	end
 })

 OverviewSection1:Toggle({
 	Title = "Brainrot",
 	Callback = function(v)
 		runningBrainrot = v
 	end
 })

 OverviewSection1:Toggle({
 	Title = "LuckyBlocks",
 	Callback = function(v)
 		runningLucky = v
 	end
 })










local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local remote = ReplicatedStorage
    :WaitForChild("Remotes")
    :WaitForChild("DamageBlockEvent")

local MAX_BLOCKS = 5
local running = false -- ตัวคุม Toggle

OverviewSection1:Toggle({
    Title = "ออโต้ตีกล่อง",
    Callback = function(state)
        running = state
        if not state then return end

        task.spawn(function()
            while running do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local luckyFolder = workspace:FindFirstChild("LuckyBlocks")

                if hrp and luckyFolder then
                    local blocks = {}

                    for _, block in ipairs(luckyFolder:GetChildren()) do
                        local part =
                            block:IsA("Model") and block.PrimaryPart
                            or block:IsA("BasePart") and block

                        if part then
                            table.insert(blocks, {
                                instance = block,
                                dist = (part.Position - hrp.Position).Magnitude
                            })
                        end
                    end

                    table.sort(blocks, function(a, b)
                        return a.dist < b.dist
                    end)

                    for i = 1, math.min(MAX_BLOCKS, #blocks) do
                        remote:FireServer(blocks[i].instance)
                    end
                end

                task.wait(0)
            end
        end)
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
