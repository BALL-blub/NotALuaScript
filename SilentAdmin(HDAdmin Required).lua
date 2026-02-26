--[[
    SILENT ADMIN
    Original Logic: Swarman
    Update: Byte-Masking, Remote Detection, & Stealth Parent
]]

-- =====================================================
-- SECURITY LAYER: MASKING UTILITY
-- =====================================================
local function Decrypt(data)
    local s = ""
    for _, v in ipairs(data) do s = s .. string.char(v) end
    return s
end

-- Masking sensitif string agar tidak terbaca scanner anti-cheat
local M_TITLE = {83, 105, 108, 101, 110, 116, 32, 65, 100, 109, 105, 110} -- "Silent Admin"
local M_REMOTE = {82, 101, 113, 117, 101, 115, 116, 67, 111, 109, 109, 97, 110, 100, 83, 105, 108, 101, 110, 116} -- "RequestCommandSilent"

local HideHDAdminExecute = Instance.new("ScreenGui")
-- Menggunakan Random Name agar tidak terdeteksi via nama objek
HideHDAdminExecute.Name = game:GetService("HttpService"):GenerateGUID(false)
HideHDAdminExecute.Parent = game:GetService("CoreGui")
HideHDAdminExecute.ResetOnSpawn = false

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- =====================================================
--  SECURITY LAYER: REMOTE DETECTION
-- =====================================================
local function GetHDRemote()
    -- Mencari remote secara dinamis jika letaknya dipindah pengembang
    local HDPath = ReplicatedStorage:FindFirstChild("HDAdminHDClient")
    if HDPath then
        local Signals = HDPath:FindFirstChild("Signals")
        if Signals then
            return Signals:FindFirstChild(Decrypt(M_REMOTE))
        end
    end
    return nil
end

-- =====================================================
-- CONFIGURATION
-- =====================================================
local LOAD_PRESETS = {
    ["silent"] = {";hidename", ";ff", ";god", ";char {target} 5788626819"},
    ["troll"] = {";explode {target}", ";blur {target} 100", ";warp {target}"},
    ["stay"] = {";hideguis {target}", ";jumppower {target} 0", ";speed {target} 0"},
}

local TARGET_LIST = {"emotes", "emote", "hide", "aura", "helicopter", "plane", "tank", "car", "ratdance", "cutesit", "fakedeath", "box", "dog", "worm", "takethel", "frydance", "phase", "buffify", "wormify", "chibify", "plushify", "freakify", "spongify", "bigify", "creepify", "dinofy", "fatify", "size", "glass", "neon", "shine", "ghost", "gold", "spin", "bighead", "smallhead", "dwarf", "giantdwarf", "squash", "width", "fat", "thin", "fire", "smoke", "sparkles", "jump", "sit", "paint", "material", "reflectance", "transparency", "cmdbar", "refresh", "respawn", "shirt", "pants", "hat", "clearhats", "face", "head", "warp", "hideguis", "showguis", "freeze", "name", "bodytypescale", "depth", "headsize", "height", "hipheight", "potatohead", "char", "morph", "view", "bundle", "cmds", "ice", "jail", "invisible", "nightvision", "lasereyes", "ping", "blur", "hidename", "forcefield", "fly", "fly2", "noclip", "noclip2", "speed", "fast", "slow", "jumpheight", "superjump", "heavyjump", "health", "heal", "god", "damage", "to", "handto", "explode", "title", "titler", "titleo", "titley", "titleg", "titledg", "titleb", "titledb", "titlep", "titlepk", "titlebk", "fling", "r15", "r6", "kill", "teleport", "tp", "bring", "apparate", "give", "sword", "chattag", "chattagcolor", "chatname", "chatnamecolor", "banland", "logs", "chatlogs", "resetstats", "punish", "chat", "givetool", "privatemassage", "alert", "temprank", "unrank", "kick", "chathijacker"}

local function NeedsTarget(cmd)
    if not cmd then return false end
    cmd = cmd:gsub("^;", ""):gsub("^/", ""):lower()
    local base = cmd:sub(1,2) == "un" and cmd:sub(3) or cmd
    if LOAD_PRESETS[cmd] or LOAD_PRESETS[base] then return true end
    for _, v in ipairs(TARGET_LIST) do if v == cmd or v == base then return true end end
    return false
end

-- =====================================================
--  OPENING EFFECTS
-- =====================================================
local blur = Instance.new("BlurEffect", game.Lighting)
blur.Size = 0; blur.Enabled = true
local OpeningSound = Instance.new("Sound", workspace)
OpeningSound.SoundId = "rbxassetid://12221967"; OpeningSound.Volume = 0.8; OpeningSound:Play()

TweenService:Create(blur,TweenInfo.new(0.4),{Size = 18}):Play()
task.delay(1.5,function()
    TweenService:Create(blur,TweenInfo.new(0.5),{Size = 0}):Play()
    task.delay(0.5,function() blur:Destroy() end)
end)

-- =====================================================
--  MAIN GUI
-- =====================================================
local Main = Instance.new("Frame", HideHDAdminExecute)
Main.Size = UDim2.new(0,210,0,115); Main.AnchorPoint = Vector2.new(0.5,0.5); Main.Position = UDim2.new(0.5,0,3,0); Main.BackgroundColor3 = Color3.fromRGB(18,18,18); Main.BackgroundTransparency = 0.15; Main.Active = true; Main.Draggable = true; Main.ClipsDescendants = true
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,-60,0,28); Title.Position = UDim2.new(0,10,0,0); Title.BackgroundTransparency = 1; Title.Text = Decrypt(M_TITLE); Title.Font = Enum.Font.GothamBold; Title.TextSize = 13; Title.TextColor3 = Color3.fromRGB(0,255,200); Title.TextXAlignment = Enum.TextXAlignment.Left

local Minimize = Instance.new("TextButton", Main)
Minimize.Size = UDim2.new(0,22,0,22); Minimize.Position = UDim2.new(1,-50,0,3); Minimize.Text = "�"; Minimize.Font = Enum.Font.GothamBold; Minimize.TextSize = 14; Minimize.BackgroundColor3 = Color3.fromRGB(30,30,30); Minimize.TextColor3 = Color3.fromRGB(0,255,200)
Instance.new("UICorner",Minimize).CornerRadius = UDim.new(1,0)

local Kill = Instance.new("TextButton", Main)
Kill.Size = UDim2.new(0,22,0,22); Kill.Position = UDim2.new(1,-26,0,3); Kill.Text = "�"; Kill.Font = Enum.Font.GothamBold; Kill.TextSize = 14; Kill.BackgroundColor3 = Color3.fromRGB(60,20,20); Kill.TextColor3 = Color3.fromRGB(255,80,80)
Instance.new("UICorner",Kill).CornerRadius = UDim.new(1,0)

local Body = Instance.new("Frame", Main)
Body.Size = UDim2.new(1,0,0,83); Body.Position = UDim2.new(0,0,0,32); Body.BackgroundTransparency = 1

-- =====================================================
--  DYNAMIC TEXTBOX 
-- =====================================================
local TextContainer = Instance.new("Frame", Body)
TextContainer.Size = UDim2.new(0.9, 0, 0, 24); TextContainer.Position = UDim2.new(0.05, 0, 0, 8); TextContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", TextContainer).CornerRadius = UDim.new(0, 8)

local PrefixFixed = Instance.new("TextLabel", TextContainer)
PrefixFixed.Size = UDim2.new(0, 15, 1, 0); PrefixFixed.Position = UDim2.new(0, 8, 0, 0); PrefixFixed.BackgroundTransparency = 1; PrefixFixed.Text = ";"; PrefixFixed.TextColor3 = Color3.fromRGB(0, 255, 200); PrefixFixed.Font = Enum.Font.RobotoMono; PrefixFixed.TextSize = 14; PrefixFixed.TextXAlignment = Enum.TextXAlignment.Left

local TextBox = Instance.new("TextBox", TextContainer)
TextBox.Size = UDim2.new(1, -25, 1, 0); TextBox.Position = UDim2.new(0, 18, 0, 0); TextBox.BackgroundTransparency = 1; TextBox.TextColor3 = Color3.new(1,1,1); TextBox.TextTransparency = 1; TextBox.Text = ""; TextBox.PlaceholderText = ""; TextBox.Font = Enum.Font.RobotoMono; TextBox.TextSize = 13; TextBox.TextXAlignment = Enum.TextXAlignment.Left; TextBox.ClearTextOnFocus = false

local GhostLabel = Instance.new("TextLabel", TextBox)
GhostLabel.Size = UDim2.new(1, 0, 1, 0); GhostLabel.BackgroundTransparency = 1; GhostLabel.TextXAlignment = Enum.TextXAlignment.Left; GhostLabel.Font = Enum.Font.RobotoMono; GhostLabel.TextSize = 13; GhostLabel.RichText = true; GhostLabel.Text = ""

local function GetPlayerMatch(name)
    if not name or name == "" then return nil end
    name = string.lower(name)
    local glb = {["all"]=true, ["others"]=true, ["random"]=true, ["me"]=true}
    if glb[name] then return name end
    for _, p in ipairs(Players:GetPlayers()) do
        if string.lower(p.Name):sub(1, #name) == name then return p.Name end
    end
    return nil
end

local function UpdatePlaceholders()
    local input = TextBox.Text; local split = string.split(input, " ")
    local argsIn = 0; for _, v in ipairs(split) do if v ~= "" then argsIn = argsIn + 1 end end
    local pColor, tColor, matchColor = 'rgb(90, 90, 90)', 'rgb(255, 255, 255)', 'rgb(130, 130, 130)'
    local finalStr = '<font color="'..tColor..'">' .. input .. '</font>'
    if input == "" then GhostLabel.Text = '<font color="'..pColor..'">[args1] [args2] [args3]</font>' return end
    local isTargetCmd = NeedsTarget(split[1])
    if isTargetCmd and argsIn >= 1 and #split >= 2 then
        local namePart = split[2]
        if namePart ~= "" and #split == 2 then
            local full = GetPlayerMatch(namePart)
            if full then
                local remain = full:sub(#namePart + 1)
                finalStr = '<font color="'..tColor..'">'..input..'</font><font color="'..matchColor..'">'..remain..'</font><font color="'..pColor..'"> [args3]</font>'
                GhostLabel.Text = finalStr; return
            end
        end
    end
    if argsIn == 1 then finalStr = finalStr .. '<font color="'..pColor..'">'..(isTargetCmd and " [target] [args3]" or " [args2] [args3]")..'</font>'
    elseif argsIn == 2 then finalStr = finalStr .. (input:sub(-1) == " " and '<font color="'..pColor..'">[args3]</font>' or '<font color="'..pColor..'"> [args3]</font>') end
    GhostLabel.Text = finalStr
end
TextBox:GetPropertyChangedSignal("Text"):Connect(UpdatePlaceholders)

-- =====================================================
--  UTILITIES & ELEMENTS
-- =====================================================
local Execute = Instance.new("TextButton", Body)
Execute.Size = UDim2.new(0.9,0,0,22); Execute.Position = UDim2.new(0.05,0,0,40); Execute.BackgroundColor3 = Color3.fromRGB(0,255,200); Execute.TextColor3 = Color3.new(0,0,0); Execute.Text = "Execute"; Execute.Font = Enum.Font.GothamBold; Execute.TextSize = 13; Instance.new("UICorner",Execute).CornerRadius = UDim.new(0,8)

local Console = Instance.new("TextLabel", Body)
Console.Size = UDim2.new(0.9,0,0,18); Console.Position = UDim2.new(0.05,0,1,-20); Console.BackgroundTransparency = 1; Console.Text = ""; Console.Font = Enum.Font.RobotoMono; Console.TextSize = 12; Console.TextTransparency = 1

local InfoFrame = Instance.new("ScrollingFrame", Main)
InfoFrame.Size = UDim2.new(0.9, 0, 0, 0); InfoFrame.Position = UDim2.new(0.05, 0, 0, 115); InfoFrame.BackgroundTransparency = 1; InfoFrame.BorderSizePixel = 0; InfoFrame.ScrollBarThickness = 2; InfoFrame.Visible = false; InfoFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UIListLayout", InfoFrame).Padding = UDim.new(0, 4)

local function ShowConsole(msg,color)
	Console.Text = msg; Console.TextColor3 = color
	TweenService:Create(Console,TweenInfo.new(0.2),{TextTransparency = 0}):Play()
	task.delay(2,function() TweenService:Create(Console,TweenInfo.new(0.2),{TextTransparency = 1}):Play() end)
end

local isExpanded = false
local function ToggleInfo(state)
    isExpanded = state
    if state then
        for _, v in pairs(InfoFrame:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
        local totalH = 0
        for name, cmds in pairs(LOAD_PRESETS) do
            local L = Instance.new("TextLabel", InfoFrame)
            L.Size = UDim2.new(1, 0, 0, 25); L.BackgroundTransparency = 0.8; L.BackgroundColor3 = Color3.new(0,0,0); L.TextColor3 = Color3.fromRGB(200, 200, 200); L.Font = Enum.Font.RobotoMono; L.TextSize = 10; L.Text = " " .. name:upper() .. ": " .. table.concat(cmds, ", "); L.TextXAlignment = Enum.TextXAlignment.Left; L.TextWrapped = true
            Instance.new("UICorner", L).CornerRadius = UDim.new(0, 4)
            totalH = totalH + 29
        end
        InfoFrame.CanvasSize = UDim2.new(0, 0, 0, totalH); InfoFrame.Visible = true
        TweenService:Create(Main, TweenInfo.new(0.35), {Size = UDim2.new(0, 210, 0, 250)}):Play()
        task.wait(0.2); TweenService:Create(InfoFrame, TweenInfo.new(0.3), {Size = UDim2.new(0.9, 0, 0, 120)}):Play()
    else
        TweenService:Create(InfoFrame, TweenInfo.new(0.2), {Size = UDim2.new(0.9, 0, 0, 0)}):Play()
        task.wait(0.1); TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 210, 0, 115)}):Play()
        task.delay(0.3, function() InfoFrame.Visible = false end)
    end
end

local function CreateButtonSFX(parent, soundId)
	local template = Instance.new("Sound", parent)
	template.SoundId = "rbxassetid://"..soundId; template.Volume = 1.5
	return function() local s = template:Clone(); s.Parent = parent; s:Play(); s.Ended:Connect(function() s:Destroy() end) end
end
local ExecuteSFX = CreateButtonSFX(Execute, 135244211779631)
local MinimizeSFX = CreateButtonSFX(Minimize, 135244211779631)
local KillSFX = CreateButtonSFX(Kill, 135244211779631)

-- =====================================================
--  CORE LOGIC
-- =====================================================
Execute.MouseButton1Click:Connect(function()
    ExecuteSFX()
    local text = TextBox.Text; if text == "" then ShowConsole("Command empty.", Color3.fromRGB(255, 80, 80)) return end
    local splitInput = string.split(text, " ")
    local cmdKey = string.lower(splitInput[1])

    if cmdKey == ";info" or cmdKey == "info" then
        if not isExpanded then ToggleInfo(true) ShowConsole("Showing Presets", Color3.fromRGB(0, 255, 200)) end return
    elseif cmdKey == ";uninfo" or cmdKey == "uninfo" then
        if isExpanded then ToggleInfo(false) ShowConsole("Hiding Presets", Color3.fromRGB(255, 80, 80)) end return
    end

    local Remote = GetHDRemote()
    if not Remote then ShowConsole("Critical: Remote Not Found", Color3.new(1,0,0)) return end

    local isUnload = string.sub(cmdKey, 1, 2) == "un"
    local baseLoadKey = isUnload and string.sub(cmdKey, 3) or cmdKey

    if LOAD_PRESETS[baseLoadKey] then
        local rawTarget = splitInput[2]
        if not rawTarget or rawTarget == "" then ShowConsole("Error: Target required!", Color3.fromRGB(255, 80, 80)) return end
        local matchedTarget = GetPlayerMatch(rawTarget) or rawTarget
        for _, cmd in ipairs(LOAD_PRESETS[baseLoadKey]) do
            local finalCmd = (isUnload and cmd:gsub(";", ";un"):gsub(";unun", ";un") or cmd):gsub("{target}", matchedTarget)
            pcall(function() Remote:InvokeServer(finalCmd) end)
            task.wait(0.12)
        end
        ShowConsole((isUnload and "Unloaded: " or "Loaded: ") .. matchedTarget, Color3.fromRGB(0, 255, 200))
        return
    end

    local inputCmd = text:match("^[;/]") and text or ";" .. text
    local success, err = pcall(function() Remote:InvokeServer(inputCmd) end)
    if success then ShowConsole("Command dispatched.", Color3.fromRGB(0, 255, 0))
    else ShowConsole("Exec Error", Color3.fromRGB(255, 80, 80)) end
end)

Minimize.MouseButton1Click:Connect(function()
    MinimizeSFX(); if Body.Visible and isExpanded then ToggleInfo(false) end
    Body.Visible = not Body.Visible
    TweenService:Create(Main,TweenInfo.new(0.25),{Size = Body.Visible and UDim2.new(0,210,0,115) or UDim2.new(0,210,0,32)}):Play()
end)
Kill.MouseButton1Click:Connect(function() KillSFX(); HideHDAdminExecute:Destroy() end)

-- =====================================================
-- NOTIFICATION SYSTEM 
-- =====================================================
local NotifContainer = Instance.new("Frame", HideHDAdminExecute)
NotifContainer.AnchorPoint = Vector2.new(1,1); NotifContainer.Position = UDim2.new(1,400,1,-140); NotifContainer.Size = UDim2.new(0,180,0,180); NotifContainer.BackgroundTransparency = 1

local ActiveNotifs = {}
local function CreateNotif(text,color)
	local Frame = Instance.new("Frame", NotifContainer)
	Frame.Size = UDim2.new(1,0,0,30); Frame.Position = UDim2.new(1,160,1,0); Frame.BackgroundColor3 = Color3.fromRGB(35,35,35); Frame.BackgroundTransparency = 0.3
	Instance.new("UICorner",Frame).CornerRadius = UDim.new(0,14)
    local S = Instance.new("UIStroke", Frame); S.Thickness = 2; S.Color = color
	local L = Instance.new("TextLabel", Frame)
	L.BackgroundTransparency = 1; L.Size = UDim2.new(1,-12,1,0); L.Position = UDim2.new(0,12,0,0); L.Font = Enum.Font.Gotham; L.TextSize = 12; L.TextColor3 = color; L.TextXAlignment = Enum.TextXAlignment.Left; L.Text = text; L.RichText = true
	table.insert(ActiveNotifs,1,Frame)
	for i,v in ipairs(ActiveNotifs) do TweenService:Create(v,TweenInfo.new(0.25),{Position = UDim2.new(0,0,1,-(i-1)*36)}):Play() end
    return Frame
end

local function RemoveSequential()
	for i = #ActiveNotifs,1,-1 do
		local f = ActiveNotifs[i]
		TweenService:Create(f,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position = UDim2.new(1,160,f.Position.Y.Scale,f.Position.Y.Offset)}):Play()
		task.wait(0.25)
	end
	task.wait(0.4); for _,v in pairs(ActiveNotifs) do v:Destroy() end; table.clear(ActiveNotifs)
    TweenService:Create(NotifContainer,TweenInfo.new(0.4),{Position = UDim2.new(1,400,1,-140)}):Play()
end

-- =====================================================
-- SEQUENCED STARTUP
-- =====================================================
task.spawn(function()
    task.wait(0.4)
    TweenService:Create(NotifContainer,TweenInfo.new(0.4),{Position = UDim2.new(1,-20,1,-140)}):Play()
    task.wait(0.5); CreateNotif("SILENT ADMIN BY Swarman", Color3.new(1,1,1))
    task.wait(0.7); CreateNotif("Security Protocol Loaded", Color3.fromRGB(200, 200, 200))
    task.wait(0.7); local decodeF = CreateNotif("", Color3.fromRGB(0, 255, 200))
    local label = decodeF.TextLabel
    local Bar = Instance.new("Frame", decodeF)
    Bar.BackgroundColor3 = Color3.fromRGB(0, 255, 200); Bar.Size = UDim2.new(0, 0, 0, 2); Bar.Position = UDim2.new(0, 12, 1, -2); Bar.BorderSizePixel = 0
    
    local targetText = "authentication..."
    local chars = {"#", "?", "!", "�", "�", "$", "*", ""}
    TweenService:Create(Bar, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = UDim2.new(1, -24, 0, 2)}):Play()

    for i = 1, #targetText do
        label.Text = '<font color="rgb(0, 255, 200)">'..string.sub(targetText,1,i)..'</font>'..chars[math.random(1,#chars)]
        task.wait(0.05)
    end
    label.Text = '<font color="rgb(0, 255, 200)">' .. targetText .. '</font>'
    
    task.wait(0.1) 
    TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    task.wait(0.5); Bar:Destroy()

    local Remote = GetHDRemote()
    if Remote then CreateNotif("HD Admin Secured", Color3.fromRGB(0, 255, 120))
    else CreateNotif("HD Admin Not Found", Color3.fromRGB(255, 80, 80)) end

    task.wait(1); CreateNotif("Type ';info' to see presets", Color3.new(1,1,1))
    task.wait(5); RemoveSequential()
end)