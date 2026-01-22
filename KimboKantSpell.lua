--[[
    Kimbo Kant Spell - Professional Auto Speller
    Made by: I Went Kimbo
    Version: 1.0 Beta
    
    Premium auto-spelling solution for Roblox Spelling Bee
    Optimized for mobile & landscape orientation
    
    Instructions:
    1. Execute this script in your Roblox executor
    2. Wait for the animated intro to complete
    3. Toggle on/off using the power button or keybind (F)
]]

local KimboKantSpell = {}
KimboKantSpell.__index = KimboKantSpell

-- Configuration
local Config = {
    enabled = false,
    typingSpeed = 0.05,
    autoSubmit = true,
    keybind = Enum.KeyCode.F,
    debugMode = true
}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Utility: Create Tween
local function tween(obj, info, props)
    return TweenService:Create(obj, info, props)
end

-- Create Professional Mobile-Friendly GUI
local function createGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KimboKantSpellGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    
    -- Main Container (Landscape optimized)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 420, 0, 140)
    MainFrame.Position = UDim2.new(0.5, -210, 0.08, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Parent = MainFrame
    
    -- Gradient Overlay
    local GradientFrame = Instance.new("Frame")
    GradientFrame.Size = UDim2.new(1, 0, 1, 0)
    GradientFrame.BackgroundTransparency = 0.3
    GradientFrame.BorderSizePixel = 0
    GradientFrame.ZIndex = 0
    GradientFrame.Parent = MainFrame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 130, 246))
    }
    Gradient.Rotation = 45
    Gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.9),
        NumberSequenceKeypoint.new(1, 0.95)
    }
    Gradient.Parent = GradientFrame
    
    local GradientCorner = Instance.new("UICorner")
    GradientCorner.CornerRadius = UDim.new(0, 16)
    GradientCorner.Parent = GradientFrame
    
    -- Border Glow Effect
    local BorderGlow = Instance.new("UIStroke")
    BorderGlow.Color = Color3.fromRGB(139, 92, 246)
    BorderGlow.Thickness = 2
    BorderGlow.Transparency = 0.5
    BorderGlow.Parent = MainFrame
    
    -- Header Section
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 16)
    HeaderCorner.Parent = Header
    
    -- Logo/Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 250, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "KIMBO KANT SPELL"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(167, 139, 250)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(96, 165, 250))
    }
    TitleGradient.Parent = Title
    
    -- Version Badge
    local VersionBadge = Instance.new("TextLabel")
    VersionBadge.Size = UDim2.new(0, 70, 0, 20)
    VersionBadge.Position = UDim2.new(0, 15, 0, 28)
    VersionBadge.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    VersionBadge.BorderSizePixel = 0
    VersionBadge.Text = "v1.0 BETA"
    VersionBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
    VersionBadge.Font = Enum.Font.GothamBold
    VersionBadge.TextSize = 9
    VersionBadge.Parent = Header
    
    local BadgeCorner = Instance.new("UICorner")
    BadgeCorner.CornerRadius = UDim.new(0, 6)
    BadgeCorner.Parent = VersionBadge
    
    -- Creator Credit
    local Creator = Instance.new("TextLabel")
    Creator.Size = UDim2.new(0, 150, 0, 20)
    Creator.Position = UDim2.new(1, -165, 0, 15)
    Creator.BackgroundTransparency = 1
    Creator.Text = "by I Went Kimbo"
    Creator.TextColor3 = Color3.fromRGB(156, 163, 175)
    Creator.Font = Enum.Font.GothamMedium
    Creator.TextSize = 11
    Creator.TextXAlignment = Enum.TextXAlignment.Right
    Creator.Parent = Header
    
    -- Content Container
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -30, 0, 75)
    Content.Position = UDim2.new(0, 15, 0, 55)
    Content.BackgroundTransparency = 1
    Content.Parent = MainFrame
    
    -- Status Section
    local StatusContainer = Instance.new("Frame")
    StatusContainer.Size = UDim2.new(0.55, 0, 1, 0)
    StatusContainer.BackgroundTransparency = 1
    StatusContainer.Parent = Content
    
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Size = UDim2.new(1, 0, 0, 18)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "STATUS"
    StatusLabel.TextColor3 = Color3.fromRGB(107, 114, 128)
    StatusLabel.Font = Enum.Font.GothamBold
    StatusLabel.TextSize = 10
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.Parent = StatusContainer
    
    local StatusValue = Instance.new("TextLabel")
    StatusValue.Name = "StatusValue"
    StatusValue.Size = UDim2.new(1, 0, 0, 24)
    StatusValue.Position = UDim2.new(0, 0, 0, 20)
    StatusValue.BackgroundTransparency = 1
    StatusValue.Text = "● Standby"
    StatusValue.TextColor3 = Color3.fromRGB(239, 68, 68)
    StatusValue.Font = Enum.Font.GothamBold
    StatusValue.TextSize = 16
    StatusValue.TextXAlignment = Enum.TextXAlignment.Left
    StatusValue.Parent = StatusContainer
    
    local WordLabel = Instance.new("TextLabel")
    WordLabel.Name = "WordLabel"
    WordLabel.Size = UDim2.new(1, 0, 0, 16)
    WordLabel.Position = UDim2.new(0, 0, 0, 48)
    WordLabel.BackgroundTransparency = 1
    WordLabel.Text = "Waiting for word..."
    WordLabel.TextColor3 = Color3.fromRGB(156, 163, 175)
    WordLabel.Font = Enum.Font.GothamMedium
    WordLabel.TextSize = 11
    WordLabel.TextXAlignment = Enum.TextXAlignment.Left
    WordLabel.Parent = StatusContainer
    
    -- Stats Counter
    local StatsLabel = Instance.new("TextLabel")
    StatsLabel.Name = "StatsLabel"
    StatsLabel.Size = UDim2.new(1, 0, 0, 16)
    StatsLabel.Position = UDim2.new(0, 0, 1, -16)
    StatsLabel.BackgroundTransparency = 1
    StatsLabel.Text = "Words typed: 0"
    StatsLabel.TextColor3 = Color3.fromRGB(107, 114, 128)
    StatsLabel.Font = Enum.Font.Gotham
    StatsLabel.TextSize = 10
    StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatsLabel.Parent = StatusContainer
    
    -- Control Panel
    local ControlPanel = Instance.new("Frame")
    ControlPanel.Size = UDim2.new(0.4, 0, 1, 0)
    ControlPanel.Position = UDim2.new(0.6, 0, 0, 0)
    ControlPanel.BackgroundTransparency = 1
    ControlPanel.Parent = Content
    
    -- Power Button
    local PowerButton = Instance.new("TextButton")
    PowerButton.Name = "PowerButton"
    PowerButton.Size = UDim2.new(0, 70, 0, 70)
    PowerButton.Position = UDim2.new(0.5, -35, 0, 0)
    PowerButton.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
    PowerButton.BorderSizePixel = 0
    PowerButton.Text = ""
    PowerButton.AutoButtonColor = false
    PowerButton.Parent = ControlPanel
    
    local PowerCorner = Instance.new("UICorner")
    PowerCorner.CornerRadius = UDim.new(1, 0)
    PowerCorner.Parent = PowerButton
    
    local PowerStroke = Instance.new("UIStroke")
    PowerStroke.Color = Color3.fromRGB(255, 255, 255)
    PowerStroke.Thickness = 2
    PowerStroke.Transparency = 0.8
    PowerStroke.Parent = PowerButton
    
    -- Power Icon
    local PowerIcon = Instance.new("ImageLabel")
    PowerIcon.Size = UDim2.new(0, 32, 0, 32)
    PowerIcon.Position = UDim2.new(0.5, -16, 0.5, -16)
    PowerIcon.BackgroundTransparency = 1
    PowerIcon.Image = "rbxassetid://7733992901"
    PowerIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    PowerIcon.Parent = PowerButton
    
    -- Intro Animation Frame
    local IntroFrame = Instance.new("Frame")
    IntroFrame.Name = "IntroFrame"
    IntroFrame.Size = UDim2.new(1, 0, 1, 0)
    IntroFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
    IntroFrame.BorderSizePixel = 0
    IntroFrame.ZIndex = 100
    IntroFrame.Parent = MainFrame
    
    local IntroCorner = Instance.new("UICorner")
    IntroCorner.CornerRadius = UDim.new(0, 16)
    IntroCorner.Parent = IntroFrame
    
    local IntroGradient = Instance.new("UIGradient")
    IntroGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 130, 246))
    }
    IntroGradient.Rotation = 45
    IntroGradient.Transparency = NumberSequence.new(0.7)
    IntroGradient.Parent = IntroFrame
    
    local IntroTitle = Instance.new("TextLabel")
    IntroTitle.Size = UDim2.new(1, 0, 0, 40)
    IntroTitle.Position = UDim2.new(0.5, 0, 0.35, 0)
    IntroTitle.AnchorPoint = Vector2.new(0.5, 0.5)
    IntroTitle.BackgroundTransparency = 1
    IntroTitle.Text = "KIMBO KANT SPELL"
    IntroTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    IntroTitle.Font = Enum.Font.GothamBold
    IntroTitle.TextSize = 24
    IntroTitle.TextTransparency = 1
    IntroTitle.Parent = IntroFrame
    
    local IntroSubtitle = Instance.new("TextLabel")
    IntroSubtitle.Size = UDim2.new(1, 0, 0, 20)
    IntroSubtitle.Position = UDim2.new(0.5, 0, 0.55, 0)
    IntroSubtitle.AnchorPoint = Vector2.new(0.5, 0.5)
    IntroSubtitle.BackgroundTransparency = 1
    IntroSubtitle.Text = "Made by I Went Kimbo • v1.0 Beta"
    IntroSubtitle.TextColor3 = Color3.fromRGB(156, 163, 175)
    IntroSubtitle.Font = Enum.Font.GothamMedium
    IntroSubtitle.TextSize = 12
    IntroSubtitle.TextTransparency = 1
    IntroSubtitle.Parent = IntroFrame
    
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Name = "LoadingBar"
    LoadingBar.Size = UDim2.new(0, 0, 0, 3)
    LoadingBar.Position = UDim2.new(0.5, -100, 0.7, 0)
    LoadingBar.AnchorPoint = Vector2.new(0, 0.5)
    LoadingBar.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Parent = IntroFrame
    
    local LoadingCorner = Instance.new("UICorner")
    LoadingCorner.CornerRadius = UDim.new(1, 0)
    LoadingCorner.Parent = LoadingBar
    
    if LocalPlayer.PlayerGui:FindFirstChild("KimboKantSpellGUI") then
        LocalPlayer.PlayerGui.KimboKantSpellGUI:Destroy()
    end
    
    ScreenGui.Parent = LocalPlayer.PlayerGui
    
    return ScreenGui
end

-- Play Intro Animation
local function playIntro(gui)
    local introFrame = gui.MainFrame.IntroFrame
    local title = introFrame:FindFirstChild("TextLabel")
    local subtitle = introFrame:FindFirstChildOfClass("TextLabel", true)
    local loadingBar = introFrame.LoadingBar
    
    -- Fade in title
    tween(title, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    task.wait(0.3)
    
    -- Fade in subtitle
    tween(subtitle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    task.wait(0.5)
    
    -- Loading bar animation
    tween(loadingBar, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0, 200, 0, 3)
    }):Play()
    
    task.wait(1.8)
    
    -- Fade out intro
    local fadeOut = tween(introFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    fadeOut:Play()
    
    tween(title, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    tween(subtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    fadeOut.Completed:Wait()
    introFrame:Destroy()
end

-- Initialize
function KimboKantSpell.new()
    local self = setmetatable({}, KimboKantSpell)
    self.currentWord = nil
    self.wordsTyped = 0
    self.gui = createGUI()
    
    -- Play intro animation
    task.spawn(function()
        playIntro(self.gui)
    end)
    
    return self
end

-- Find the word to spell
function KimboKantSpell:findWord()
    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if gui:IsA("TextLabel") or gui:IsA("TextBox") then
            local text = gui.Text
            if text and #text > 2 and #text < 20 and not text:find("%d") and not text:find("Score") and not text:find("Time") and not text:find("STATUS") and not text:find("KIMBO") then
                if text ~= self.currentWord and text:match("^%a+$") then
                    return text
                end
            end
        end
    end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
            local textLabel = obj:FindFirstChildOfClass("TextLabel")
            if textLabel then
                local text = textLabel.Text
                if text and #text > 2 and #text < 20 and text:match("^%a+$") then
                    return text
                end
            end
        end
    end
    
    return nil
end

-- Type the word
function KimboKantSpell:typeWord(word)
    if not word then return end
    
    self.currentWord = word
    self:updateGUI("Typing", word)
    
    task.wait(0.2)
    
    for i = 1, #word do
        local char = word:sub(i, i)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[char:upper()], false, game)
        task.wait(0.02)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[char:upper()], false, game)
        task.wait(Config.typingSpeed)
    end
    
    if Config.autoSubmit then
        task.wait(0.1)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        task.wait(0.02)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
    end
    
    self.wordsTyped = self.wordsTyped + 1
    self:updateStats()
    
    if Config.debugMode then
        print(string.format("[Kimbo Kant Spell] Typed: %s (Total: %d)", word, self.wordsTyped))
    end
end

-- Update GUI Status
function KimboKantSpell:updateGUI(status, word)
    local statusValue = self.gui.MainFrame.MainFrame.Content:FindFirstChild("Frame").StatusValue
    local wordLabel = self.gui.MainFrame.MainFrame.Content:FindFirstChild("Frame").WordLabel
    
    if status == "Active" then
        statusValue.Text = "● Active"
        statusValue.TextColor3 = Color3.fromRGB(34, 197, 94)
    elseif status == "Standby" then
        statusValue.Text = "● Standby"
        statusValue.TextColor3 = Color3.fromRGB(239, 68, 68)
    elseif status == "Typing" then
        statusValue.Text = "● Typing"
        statusValue.TextColor3 = Color3.fromRGB(59, 130, 246)
    end
    
    if word then
        wordLabel.Text = "Spelling: " .. word
    else
        wordLabel.Text = "Waiting for word..."
    end
end

-- Update Stats
function KimboKantSpell:updateStats()
    local statsLabel = self.gui.MainFrame.MainFrame.Content:FindFirstChild("Frame").StatsLabel
    statsLabel.Text = string.format("Words typed: %d", self.wordsTyped)
end

-- Main loop
function KimboKantSpell:start()
    Config.enabled = true
    self:updateGUI("Active", nil)
    
    local powerButton = self.gui.MainFrame.MainFrame.Content:FindFirstChild("Frame", true).Parent.PowerButton
    tween(powerButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(34, 197, 94)}):Play()
    
    task.spawn(function()
        while Config.enabled do
            local word = self:findWord()
            if word and word ~= self.currentWord then
                self:typeWord(word)
                task.wait(1)
            end
            task.wait(0.5)
        end
    end)
end

-- Stop
function KimboKantSpell:stop()
    Config.enabled = false
    self:updateGUI("Standby", nil)
    
    local powerButton = self.gui.MainFrame.MainFrame.Content:FindFirstChild("Frame", true).Parent.PowerButton
    tween(powerButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(220, 38, 38)}):Play()
    
    print(string.format("[Kimbo Kant Spell] Stopped. Total words typed: %d", self.wordsTyped))
end

-- Toggle
function KimboKantSpell:toggle()
    if Config.enabled then
        self:stop()
    else
        self:start()
    end
end

-- Initialize instance
local kimbo = KimboKantSpell.new()

-- Power Button Click
task.wait(2.5)
local powerBtn = kimbo.gui.MainFrame:WaitForChild("MainFrame"):WaitForChild("Content"):GetChildren()[2]:WaitForChild("PowerButton")

powerBtn.MouseButton1Click:Connect(function()
    -- Button press animation
    tween(powerBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 65, 0, 65)}):Play()
    task.wait(0.1)
    tween(powerBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 70, 0, 70)}):Play()
    
    kimbo:toggle()
end)

-- Keybind
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Config.keybind then
        kimbo:toggle()
    end
end)

print("╔═══════════════════════════════════╗")
print("║   KIMBO KANT SPELL v1.0 BETA     ║")
print("║   Made by: I Went Kimbo          ║")
print("║   Press F or Power Button        ║")
print("╚═══════════════════════════════════╝")

return kimbo
