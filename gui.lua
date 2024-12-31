-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local username = Instance.new("TextLabel")
local timerunning = Instance.new("TextLabel")
local lootbags = Instance.new("TextLabel")

-- Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, 0, 1, 0)

username.Name = "username"
username.Parent = Frame
username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
username.BackgroundTransparency = 1.000
username.Size = UDim2.new(1, 0, 0.2, 0)
username.Font = Enum.Font.SourceSansBold
username.Text = "User: " .. game.Players.LocalPlayer.Name
username.TextColor3 = Color3.fromRGB(255, 255, 255)
username.TextScaled = true
username.TextWrapped = true

local timerStart = os.time()
timerunning.Name = "timerunning"
timerunning.Parent = Frame
timerunning.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
timerunning.BackgroundTransparency = 1.000
timerunning.Size = UDim2.new(1, 0, 0.2, 0)
timerunning.Position = UDim2.new(0, 0, 0.2, 0)
timerunning.Font = Enum.Font.SourceSansBold
timerunning.Text = "Time: 00:00:00"
timerunning.TextColor3 = Color3.fromRGB(68, 43, 255)
timerunning.TextScaled = true
timerunning.TextWrapped = true

lootbags.Name = "lootbags"
lootbags.Parent = Frame
lootbags.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
lootbags.BackgroundTransparency = 1.000
lootbags.Size = UDim2.new(1, 0, 0.2, 0)
lootbags.Position = UDim2.new(0, 0, 0.4, 0)
lootbags.Font = Enum.Font.SourceSansBold
lootbags.Text = "Lootbags: 0"
lootbags.TextColor3 = Color3.fromRGB(255, 0, 4)
lootbags.TextScaled = true
lootbags.TextWrapped = true

-- Script logic:

local function updateTimer()
    while true do
        local elapsedTime = os.time() - timerStart
        local hours = math.floor(elapsedTime / 3600)
        local minutes = math.floor((elapsedTime % 3600) / 60)
        local seconds = elapsedTime % 60
        timerunning.Text = string.format("Time: %02d:%02d:%02d", hours, minutes, seconds)
        task.wait(1)
    end
end

local function updateLootbags()
    local Save = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Save"))
    local inventory = Save.Get().Inventory

    while true do
        local lootbagCount = 0

        if inventory.Lootbox then
            for uid, item in pairs(inventory.Lootbox) do
                if item.id == "2025 New Years Gift" then
                    lootbagCount = lootbagCount + (item._am or 0)
                end
            end
        end

        lootbags.Text = "Lootbags: " .. lootbagCount
        task.wait(5)
    end
end

-- Start the loops
spawn(updateTimer)
spawn(updateLootbags)
