-- Mount Cing

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Auto print UserId kamu di console
local localPlayer = game.Players.LocalPlayer
print("✅ UserId kamu adalah:", localPlayer.UserId)

-- Ganti angka ini dengan UserId kamu
local ownerId = 4188850123   -- << isi dengan UserId hasil print di atas

-- =============================
-- 🌄 SCRIPT UTAMA (UI Mount Cing)
-- =============================
function loadMainUI()
    local Window = Rayfield:CreateWindow({
        Name = "Mount Cing (free) || By TestTeam",
        LoadingTitle = "Sabar...",
        LoadingSubtitle = "by TestTeam",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = nil,
            FileName = "TeleportCPReset"
        }
    })

    local TeleportTab = Window:CreateTab("Teleport", 4483362458)
    local ResetTab = Window:CreateTab("Loop", 4483362458)

    -- Variabel Looping dan Delay
    local loopingFull = false
    local delayTime = 2
    local resetDelay = 5

    -- Daftar koordinat
    local checkpoints = {
        Basecamp = Vector3.new(954, 12, 854),
        CP1 = Vector3.new(332, 138, 829),
        CP2 = Vector3.new(138, 78, 356),
        CP3 = Vector3.new(53, 78, 28),
        CP4 = Vector3.new(748, 126, 355),
        CP5 = Vector3.new(677, 130, -765),
        CP6 = Vector3.new(241, 250, -469),
        CP7 = Vector3.new(-504, 438, -399),
        CP8 = Vector3.new(-1337, 422, -444),
        CP9 = Vector3.new(-1837, 494, -112),
        CP10 = Vector3.new(-2197, 782, 985),
        Summit = Vector3.new(-1482, 1293, 1052)
    }

    local order = {"Basecamp","CP1","CP2","CP3","CP4","CP5","CP6","CP7","CP8","CP9","CP10","Summit"}

    -- Tombol Teleport Manual
    for _, name in ipairs(order) do
        TeleportTab:CreateButton({
            Name = "Teleport ke " .. name,
            Callback = function()
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(checkpoints[name])
                end
            end,
        })
    end

    -- Slider Delay
    ResetTab:CreateSlider({
        Name = "Delay antar Teleport (detik)",
        Range = {0.5, 10},
        Increment = 0.5,
        Suffix = "s",
        CurrentValue = delayTime,
        Callback = function(Value) delayTime = Value end
    })

    ResetTab:CreateSlider({
        Name = "Delay setelah Reset (detik)",
        Range = {1, 15},
        Increment = 1,
        Suffix = "s",
        CurrentValue = resetDelay,
        Callback = function(Value) resetDelay = Value end
    })

    -- Toggle Loop Lengkap
    ResetTab:CreateToggle({
        Name = "Loop Lengkap (Basecamp → Summit)",
        CurrentValue = false,
        Callback = function(Value)
            loopingFull = Value
            if Value then
                task.spawn(function()
                    while loopingFull do
                        local player = game.Players.LocalPlayer
                        if player and player.Character then
                            for _, name in ipairs(order) do
                                repeat task.wait(0.1) until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                player.Character.HumanoidRootPart.CFrame = CFrame.new(checkpoints[name])
                                task.wait(delayTime)
                            end
                            player.Character:BreakJoints()
                            repeat task.wait(0.5) until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                            task.wait(resetDelay)
                        end
                    end
                end)
            end
        end,
    })
end

-- =============================
-- 🔑 SISTEM KEY
-- =============================
local validKey = "MountCingKey123"

local function checkKey(inputKey)
    if inputKey == validKey then
        Rayfield:Notify({
            Title = "Key Benar ✅",
            Content = "Selamat datang di Mount Cing!",
            Duration = 5
        })
        task.wait(1)
        loadMainUI()
    else
        Rayfield:Notify({
            Title = "Key Salah ❌",
            Content = "Silakan coba lagi.",
            Duration = 5
        })
    end
end

-- Owner bypass
if localPlayer.UserId == ownerId then
    loadMainUI()
else
    -- Key system untuk user lain
    local KeyWindow = Rayfield:CreateWindow({
        Name = "Mount Cing | Key System",
        LoadingTitle = "Masukkan Key",
        LoadingSubtitle = "by TestTeam",
        ConfigurationSaving = { Enabled = false }
    })

    local KeyTab = KeyWindow:CreateTab("Key", 4483362458)
    KeyTab:CreateInput({
        Name = "Masukkan Key",
        PlaceholderText = "Ketik key di sini...",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text) checkKey(Text) end
    })
end
