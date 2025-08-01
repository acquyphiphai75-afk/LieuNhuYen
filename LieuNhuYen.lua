-- Blade Ball Auto Parry + Mod Skin + UI Menu with Background & Music
-- Made by LieuNhuYenHub ⚔️

-- Load OrionLib for UI
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Window setup
local Window = OrionLib:MakeWindow({
    Name = "⚔️ LieuNhuYenHub | Auto Parry",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BladeBallAuto"
})

-- UI Background setup
local success, gui = pcall(function()
    return game.CoreGui:FindFirstChild("Orion"):FindFirstChild("Orion"):FindFirstChildOfClass("ScreenGui")
end)
if success and gui then
    local background = Instance.new("ImageLabel")
    background.Name = "Background"
    background.Image = "rbxassetid://18687927545" -- ảnh nền kiếm khách
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundTransparency = 1
    background.ImageTransparency = 0.1
    background.ZIndex = -1
    background.Parent = gui
end

-- Music setup
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://18467014035" -- nhạc nền (đã convert từ YouTube)
Sound.Volume = 1
Sound.Looped = true
Sound.Playing = true
Sound.Parent = game:GetService("SoundService")

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Auto Parry Toggle
local autoParry = false
MainTab:AddToggle({
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

-- Mod Skin Button
MainTab:AddButton({
    Name = "Mod Skin Kiếm",
    Callback = function()
        local sword = game.Players.LocalPlayer.Character:FindFirstChild("Sword")
        if sword then
            sword.TextureID = "rbxassetid://18687925332" -- skin kiếm custom
            OrionLib:MakeNotification({
                Name = "Mod Skin",
                Content = "Đã mod skin kiếm!",
                Time = 3
            })
        end
    end
})

-- Auto Parry Logic
game:GetService("RunService").RenderStepped:Connect(function()
    if autoParry then
        for _, ball in pairs(game.Workspace:GetChildren()) do
            if ball.Name == "Ball" and ball:IsA("BasePart") then
                local distance = (ball.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < 25 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Parry"):FireServer()
                end
            end
        end
    end
end)

-- Load UI
OrionLib:Init()
