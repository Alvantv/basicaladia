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
