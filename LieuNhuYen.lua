-- Blade Ball Script: Auto Parry + Mod Skin + Custom UI (Hide/Show)
-- Made by LieuNhuYenHub ⚔️

-- Load OrionLib UI
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local uiVisible = true

-- Create main window
local Window = OrionLib:MakeWindow({
    Name = "⚔️ LieuNhuYenHub | Auto Parry",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BladeBallAuto"
})

-- UI Background Image (gái xinh)
local bg = Instance.new("ImageLabel")
bg.Name = "Background"
bg.Image = "rbxassetid://18687927545" -- Hình gái xinh
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundTransparency = 1
bg.ImageTransparency = 0.15
bg.ZIndex = -1
bg.Parent = game.CoreGui:FindFirstChild("Orion"):FindFirstChild("Orion"):FindFirstChildOfClass("ScreenGui")

-- Music
local music = Instance.new("Sound")
music.SoundId = "rbxassetid://18467014035"
music.Volume = 1
music.Looped = true
music.Playing = true
music.Parent = game.SoundService

-- Main tab
local mainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998", -- Doro chibi icon
    PremiumOnly = false
})

-- Auto Parry
local autoParry = false
mainTab:AddToggle({
    Name = "Auto Parry",
    Default = false,
    Callback = function(state)
        autoParry = state
        OrionLib:MakeNotification({
            Name = "Auto Parry",
            Content = state and "Đã bật tự động đỡ bóng!" or "Đã tắt auto parry!",
            Time = 3
        })
    end
})

-- Mod Skin
mainTab:AddButton({
    Name = "Mod Skin Kiếm",
    Callback = function()
        local sword = game.Players.LocalPlayer.Character:FindFirstChild("Sword")
        if sword then
            sword.TextureID = "rbxassetid://18687925332" -- Skin kiếm
            OrionLib:MakeNotification({
                Name = "Mod Skin",
                Content = "Đã mod skin kiếm!",
                Time = 3
            })
        end
    end
})

-- Hide/Show UI Toggle
mainTab:AddToggle({
    Name = "Ẩn/Hiện Giao Diện (UI)",
    Default = true,
    Callback = function(value)
        uiVisible = value
        local ui = game.CoreGui:FindFirstChild("Orion")
        if ui then
            ui.Enabled = value
        end
    end
})

-- Auto Parry Logic
game:GetService("RunService").RenderStepped:Connect(function()
    if autoParry then
        for _, ball in pairs(game.Workspace:GetChildren()) do
            if ball.Name == "Ball" and (ball.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 25 then
                game:GetService("ReplicatedStorage").Remotes.Parry:FireServer()
            end
        end
    end
end)

-- Init
OrionLib:Init()
