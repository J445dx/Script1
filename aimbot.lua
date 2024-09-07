-- Criando a Interface
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

ToggleButton.Parent = ScreenGui
ToggleButton.Text = "Ligar Aimbot"
ToggleButton.Size = UDim2.new(0, 200, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -100, 0, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ToggleButton.TextScaled = true

local aimbotActive = false

-- Função que ativa e desativa o Aimbot
ToggleButton.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        ToggleButton.Text = "Desligar Aimbot"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    else
        ToggleButton.Text = "Ligar Aimbot"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

-- Função para encontrar o jogador mais próximo
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local localPosition = localCharacter.HumanoidRootPart.Position

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = player.Character.HumanoidRootPart.Position
            local distance = (localPosition - targetPosition).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

-- Aimbot loop
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotActive then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = closestPlayer.Character.HumanoidRootPart.Position
            local localPlayer = game.Players.LocalPlayer
            local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()

            -- Fazendo a câmera seguir o jogador mais próximo
            game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, targetPosition)

            -- Se você tiver uma função para atirar, pode colocá-la aqui para garantir que o tiro seja disparado automaticamente
        end
    end
end)
