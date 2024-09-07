local aimbotEnabled = false  -- Variável para controlar o estado do aimbot

-- Função para criar a interface
local function createInterface()
    local ScreenGui = Instance.new("ScreenGui")
    local ToggleButton = Instance.new("TextButton")
    
    -- Configurando o ScreenGui
    ScreenGui.Parent = game.CoreGui

    -- Configurando o ToggleButton
    ToggleButton.Size = UDim2.new(0, 100, 0, 50)
    ToggleButton.Position = UDim2.new(0, 100, 0, 100)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ToggleButton.Text = "Ligar Aimbot"
    ToggleButton.Parent = ScreenGui
    
    -- Evento de clique no botão
    ToggleButton.MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            ToggleButton.Text = "Desligar Aimbot"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            ToggleButton.Text = "Ligar Aimbot"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
end

-- Função do aimbot
local function aimbot()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local mouse = localPlayer:GetMouse()

    while true do
        wait(0.1)  -- Espera para não sobrecarregar

        if aimbotEnabled then
            local closestPlayer
            local shortestDistance = math.huge

            for _, player in pairs(players:GetPlayers()) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local distance = (player.Character.Head.Position - localPlayer.Character.Head.Position).magnitude
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end

            if closestPlayer then
                mouse.TargetFilter = closestPlayer.Character
                mouse.Hit = CFrame.new(closestPlayer.Character.Head.Position)
            end
        end
    end
end

-- Criar a interface e iniciar o aimbot
createInterface()
aimbot()
