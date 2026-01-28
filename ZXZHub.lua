local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local function DetectPlatform()
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        return "Mobile"
    else
        return "PC"
    end
end

local Platform = DetectPlatform()
local FPSCounter = 0
local LastFrameTime = tick()
local ESPEnabled = false
local ESPColor = Color3.fromRGB(255, 255, 255)
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "ESPFolder"
local TracersEnabled = false
local TracersFolder = Instance.new("Folder", game.CoreGui)
TracersFolder.Name = "TracersFolder"
local NametagsEnabled = false
local NametagsFolder = Instance.new("Folder", game.CoreGui)
NametagsFolder.Name = "NametagsFolder"

local function GetFPS()
    local currentTime = tick()
    local deltaTime = currentTime - LastFrameTime
    LastFrameTime = currentTime
    if deltaTime > 0 then
        FPSCounter = math.floor(1 / deltaTime)
    end
    return FPSCounter
end

local function GetPing()
    local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    return math.floor(ping)
end

local function GetRegion()
    local ping = GetPing()
    if ping < 50 then
        return "América del Sur"
    elseif ping < 100 then
        return "América del Norte"
    elseif ping < 150 then
        return "Europa"
    else
        return "Asia/Oceanía"
    end
end

local function GetPlayerDistance(player)
    if LocalPlayer.Character and player.Character then
        local rootPart1 = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local rootPart2 = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart1 and rootPart2 then
            return math.floor((rootPart1.Position - rootPart2.Position).Magnitude)
        end
    end
    return 0
end

local Window = WindUI:CreateWindow({
    Title = "ZXZ Community Hub",
    Icon = "rbxassetid://10723415903",
    Author = "by insert & ZXZ Team",
    Folder = "ZXZHub",
    KeySystem = false,
    Transparent = true,
    Theme = "Dark",
})

if Platform == "PC" then
    Window:SetToggleKey(Enum.KeyCode.R)
end

Window:Tag({
    Title = "v2.0.0",
    Icon = "tag",
    Color = Color3.fromHex("#30ff6a"),
    Border = true,
})

Window:Tag({
    Title = "PREMIUM",
    Icon = "star",
    Color = Color3.fromHex("#FFD700"),
    Border = true,
})

Window:Tag({
    Title = "by insert",
    Icon = "user",
    Color = Color3.fromHex("#7775F2"),
    Border = true,
})

local HomeTab = Window:Tab({
    Title = "Inicio",
    Icon = "home",
    IconColor = Color3.fromHex("#30ff6a"),
})

HomeTab:Section({
    Title = "¡Bienvenido a ZXZ Hub!",
    TextSize = 22,
    FontWeight = Enum.FontWeight.Bold,
})

HomeTab:Space()

HomeTab:Section({
    Title = "El hub más completo y profesional de Roblox",
    TextSize = 14,
    TextTransparency = 0.5,
})

HomeTab:Space({ Columns = 2 })

local UserGroup = HomeTab:Group({})

UserGroup:Section({
    Title = "👤 Tu Perfil",
    TextSize = 16,
    FontWeight = Enum.FontWeight.SemiBold,
})

UserGroup:Section({
    Title = LocalPlayer.DisplayName,
    TextSize = 18,
    TextTransparency = 0.2,
})

UserGroup:Section({
    Title = "@" .. LocalPlayer.Name,
    TextSize = 13,
    TextTransparency = 0.6,
})

UserGroup:Section({
    Title = "User ID: " .. LocalPlayer.UserId,
    TextSize = 12,
    TextTransparency = 0.7,
})

UserGroup:Space()

UserGroup:Section({
    Title = "Account Age: " .. LocalPlayer.AccountAge .. " días",
    TextSize = 12,
    TextTransparency = 0.6,
})

HomeTab:Space({ Columns = 2 })

local ServerStatsSection = HomeTab:Section({
    Title = "📊 Servidor en Tiempo Real"
})

local StatsText = HomeTab:Section({
    Title = "Cargando estadísticas...",
    TextSize = 13,
    TextTransparency = 0.4,
})

task.spawn(function()
    while task.wait(1) do
        local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        local serverID = game.JobId ~= "" and game.JobId:sub(1, 20) .. "..." or "Servidor Privado"
        
        local infoText = string.format(
            "🎮 Juego: %s\n🌐 Server ID: %s\n👥 Jugadores: %d/%d\n📍 Región: %s\n📡 Ping: %d ms\n⚡ FPS: %d\n💾 Memoria: %.1f MB\n⏰ Tiempo: %s",
            gameName,
            serverID,
            #Players:GetPlayers(),
            Players.MaxPlayers,
            GetRegion(),
            GetPing(),
            GetFPS(),
            Stats:GetTotalMemoryUsageMb(),
            os.date("%H:%M:%S")
        )
        
        StatsText:Set({
            Title = infoText
        })
    end
end)

HomeTab:Space({ Columns = 3 })

HomeTab:Section({
    Title = "🌟 Características Premium",
    TextSize = 16,
    FontWeight = Enum.FontWeight.SemiBold,
})

HomeTab:Space()

local FeaturesGroup = HomeTab:Group({})

FeaturesGroup:Section({
    Title = "✅ ESP Avanzado con Distancias\n✅ Tracers y Name Tags\n✅ Fly & NoClip\n✅ Speed & Jump Boost\n✅ Optimización Extrema\n✅ Anti-AFK Sistema\n✅ Auto-Farm Compatible\n✅ Espectador Avanzado",
    TextSize = 13,
    TextTransparency = 0.4,
})

HomeTab:Space({ Columns = 2 })

HomeTab:Button({
    Title = "💬 Discord ZXZ",
    Desc = "Únete a nuestra comunidad",
    Icon = "message-circle",
    Color = Color3.fromHex("#5865F2"),
    Callback = function()
        setclipboard("https://discord.gg/D6Zq8Uc6nV")
        WindUI:Notify({
            Title = "Discord Copiado",
            Content = "Link copiado: discord.gg/D6Zq8Uc6nV"
        })
    end
})

HomeTab:Space()

HomeTab:Button({
    Title = "📋 Copiar Server ID",
    Desc = "Comparte este servidor",
    Icon = "copy",
    Callback = function()
        setclipboard(game.JobId)
        WindUI:Notify({
            Title = "Server ID Copiado",
            Content = "ID del servidor copiado"
        })
    end
})

local PlayerTab = Window:Tab({
    Title = "Jugador",
    Icon = "user",
    IconColor = Color3.fromHex("#7775F2"),
})

local MovementSection = PlayerTab:Section({
    Title = "⚡ Movimiento"
})

local WalkSpeedValue = 16
PlayerTab:Slider({
    Title = "🏃 Velocidad de Caminar",
    Desc = "Ajusta tu velocidad (Default: 16)",
    Step = 1,
    Value = {
        Min = 16,
        Max = 200,
        Default = 16,
    },
    Callback = function(v)
        WalkSpeedValue = v
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait()
    if char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = WalkSpeedValue
        char.Humanoid.JumpPower = JumpPowerValue
    end
end)

PlayerTab:Space()

local JumpPowerValue = 50
PlayerTab:Slider({
    Title = "🦘 Poder de Salto",
    Desc = "Ajusta tu altura de salto (Default: 50)",
    Step = 1,
    Value = {
        Min = 50,
        Max = 300,
        Default = 50,
    },
    Callback = function(v)
        JumpPowerValue = v
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = v
        end
    end
})

PlayerTab:Space()

local FlyEnabled = false
local FlySpeed = 50
PlayerTab:Toggle({
    Title = "✈️ Fly Mode",
    Desc = "Vuela libremente por el mapa",
    Value = false,
    Callback = function(v)
        FlyEnabled = v
        
        if v then
            local char = LocalPlayer.Character
            local humanoid = char and char:FindFirstChild("Humanoid")
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            
            if rootPart then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Name = "FlyVelocity"
                bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = rootPart
                
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.Name = "FlyGyro"
                bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bodyGyro.P = 9e4
                bodyGyro.Parent = rootPart
                
                local camera = workspace.CurrentCamera
                
                RunService.RenderStepped:Connect(function()
                    if not FlyEnabled then
                        if rootPart:FindFirstChild("FlyVelocity") then
                            rootPart.FlyVelocity:Destroy()
                        end
                        if rootPart:FindFirstChild("FlyGyro") then
                            rootPart.FlyGyro:Destroy()
                        end
                        return
                    end
                    
                    local velocity = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        velocity = velocity + (camera.CFrame.LookVector * FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        velocity = velocity - (camera.CFrame.LookVector * FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        velocity = velocity - (camera.CFrame.RightVector * FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        velocity = velocity + (camera.CFrame.RightVector * FlySpeed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        velocity = velocity + Vector3.new(0, FlySpeed, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        velocity = velocity - Vector3.new(0, FlySpeed, 0)
                    end
                    
                    if rootPart:FindFirstChild("FlyVelocity") then
                        rootPart.FlyVelocity.Velocity = velocity
                    end
                    if rootPart:FindFirstChild("FlyGyro") then
                        rootPart.FlyGyro.CFrame = camera.CFrame
                    end
                end)
                
                WindUI:Notify({
                    Title = "Fly Activado",
                    Content = "Usa WASD + Space/Shift para volar"
                })
            end
        else
            local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                if rootPart:FindFirstChild("FlyVelocity") then
                    rootPart.FlyVelocity:Destroy()
                end
                if rootPart:FindFirstChild("FlyGyro") then
                    rootPart.FlyGyro:Destroy()
                end
            end
        end
    end
})

PlayerTab:Space()

PlayerTab:Slider({
    Title = "✈️ Velocidad de Vuelo",
    Desc = "Ajusta qué tan rápido vuelas",
    Step = 5,
    Value = {
        Min = 10,
        Max = 200,
        Default = 50,
    },
    Callback = function(v)
        FlySpeed = v
    end
})

PlayerTab:Space()

PlayerTab:Toggle({
    Title = "👻 NoClip",
    Desc = "Atraviesa paredes",
    Value = false,
    Callback = function(v)
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not v
                end
            end
            
            if v then
                char.DescendantAdded:Connect(function(part)
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end)
            end
        end
    end
})

PlayerTab:Space({ Columns = 2 })

local UtilitySection = PlayerTab:Section({
    Title = "🛠️ Utilidades"
})

PlayerTab:Toggle({
    Title = "🔄 Regeneración Infinita",
    Desc = "Tu vida se regenera constantemente",
    Value = false,
    Callback = function(v)
        if v then
            task.spawn(function()
                while v do
                    task.wait(0.1)
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
                    end
                end
            end)
        end
    end
})

PlayerTab:Space()

PlayerTab:Toggle({
    Title = "⚡ Anti-AFK",
    Desc = "Nunca serás kickeado por inactividad",
    Value = false,
    Callback = function(v)
        if v then
            local VirtualUser = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            WindUI:Notify({
                Title = "Anti-AFK Activado",
                Content = "No serás kickeado por inactividad"
            })
        end
    end
})

PlayerTab:Space()

PlayerTab:Button({
    Title = "🔄 Reiniciar Personaje",
    Desc = "Respawn instantáneo",
    Icon = "refresh-cw",
    Callback = function()
        LocalPlayer.Character:BreakJoints()
    end
})

PlayerTab:Space()

PlayerTab:Button({
    Title = "💺 Sentarse",
    Desc = "Siéntate donde estás",
    Icon = "user",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Sit = true
        end
    end
})

local VisualsTab = Window:Tab({
    Title = "Visuales",
    Icon = "eye",
    IconColor = Color3.fromHex("#257AF7"),
})

local ESPSection = VisualsTab:Section({
    Title = "👁️ ESP & Wallhack"
})

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name
    highlight.FillColor = ESPColor
    highlight.OutlineColor = ESPColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = ESPFolder
    
    local function UpdateESP()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            highlight.Adornee = player.Character
        end
    end
    
    player.CharacterAdded:Connect(UpdateESP)
    UpdateESP()
    
    return highlight
end

local function ClearESP()
    for _, esp in pairs(ESPFolder:GetChildren()) do
        esp:Destroy()
    end
end

VisualsTab:Toggle({
    Title = "👁️ ESP Activado",
    Desc = "Ver jugadores a través de paredes",
    Value = false,
    Callback = function(v)
        ESPEnabled = v
        if v then
            for _, player in pairs(Players:GetPlayers()) do
                CreateESP(player)
            end
            
            Players.PlayerAdded:Connect(function(player)
                if ESPEnabled then
                    task.wait(1)
                    CreateESP(player)
                end
            end)
            
            Players.PlayerRemoving:Connect(function(player)
                local esp = ESPFolder:FindFirstChild(player.Name)
                if esp then
                    esp:Destroy()
                end
            end)
        else
            ClearESP()
        end
    end
})

VisualsTab:Space()

VisualsTab:Colorpicker({
    Title = "🎨 Color del ESP",
    Desc = "Personaliza el color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        ESPColor = color
        for _, esp in pairs(ESPFolder:GetChildren()) do
            if esp:IsA("Highlight") then
                esp.FillColor = color
                esp.OutlineColor = color
            end
        end
    end
})

VisualsTab:Space()

VisualsTab:Slider({
    Title = "Transparencia ESP",
    Desc = "Ajusta la transparencia del relleno",
    Step = 0.1,
    Value = {
        Min = 0,
        Max = 1,
        Default = 0.5,
    },
    Callback = function(v)
        for _, esp in pairs(ESPFolder:GetChildren()) do
            if esp:IsA("Highlight") then
                esp.FillTransparency = v
            end
        end
    end
})

VisualsTab:Space({ Columns = 2 })

local function CreateTracer(player)
    if player == LocalPlayer then return end
    
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.new(1, 1, 1)
    line.Thickness = 2
    line.Transparency = 1
    
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not TracersEnabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            line.Visible = false
            return
        end
        
        local camera = workspace.CurrentCamera
        local rootPart = player.Character.HumanoidRootPart
        local vector, onScreen = camera:WorldToViewportPoint(rootPart.Position)
        
        if onScreen then
            line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
            line.To = Vector2.new(vector.X, vector.Y)
            line.Visible = true
        else
            line.Visible = false
        end
    end)
    
    TracersFolder[player.Name] = {line = line, connection = connection}
end

local function ClearTracers()
    for _, data in pairs(TracersFolder:GetChildren()) do
        if data.line then
            data.line:Remove()
        end
        if data.connection then
            data.connection:Disconnect()
        end
    end
end

VisualsTab:Toggle({
    Title = "📍 Tracers",
    Desc = "Líneas hacia los jugadores",
    Value = false,
    Callback = function(v)
        TracersEnabled = v
        if v then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    pcall(function()
                        CreateTracer(player)
                    end)
                end
            end
        else
            ClearTracers()
        end
    end
})

VisualsTab:Space()

local function CreateNametag(player)
    if player == LocalPlayer then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = player.Name .. "_Nametag"
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 0.5
    textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 14
    textLabel.Parent = billboardGui
    
    local function UpdateNametag()
        if player.Character and player.Character:FindFirstChild("Head") then
            billboardGui.Adornee = player.Character.Head
            billboardGui.Parent = NametagsFolder
            
            local distance = GetPlayerDistance(player)
            local health = player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or 0
            local maxHealth = player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or 100
            
            textLabel.Text = string.format("%s\n%d HP | %d studs", player.Name, math.floor(health), distance)
        end
    end
    
    player.CharacterAdded:Connect(UpdateNametag)
    UpdateNametag()
    
    task.spawn(function()
        while NametagsEnabled and player.Parent do
            UpdateNametag()
            task.wait(0.1)
        end
    end)
end

local function ClearNametags()
    for _, tag in pairs(NametagsFolder:GetChildren()) do
        tag:Destroy()
    end
end

VisualsTab:Toggle({
    Title = "📛 Name Tags",
    Desc = "Muestra nombres y distancias",
    Value = false,
    Callback = function(v)
        NametagsEnabled = v
        if v then
            for _, player in pairs(Players:GetPlayers()) do
                CreateNametag(player)
            end
            
            Players.PlayerAdded:Connect(function(player)
                if NametagsEnabled then
                    task.wait(1)
                    CreateNametag(player)
                end
            end)
        else
            ClearNametags()
        end
    end
})

VisualsTab:Space({ Columns = 2 })

local AmbientSection = VisualsTab:Section({
    Title = "🌈 Ambiente Visual"
})

VisualsTab:Toggle({
    Title = "🌟 Full Bright",
    Desc = "Iluminación completa",
    Value = false,
    Callback = function(v)
        if v then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
        end
    end
})

VisualsTab:Space()

VisualsTab:Colorpicker({
    Title = "🎨 Color del Ambiente",
    Desc = "Cambia el color del ambiente",
    Default = Color3.fromRGB(128, 128, 128),
    Callback = function(color)
        Lighting.Ambient = color
        Lighting.OutdoorAmbient = color
    end
})

VisualsTab:Space()

VisualsTab:Slider({
    Title = "☀️ Brillo",
    Desc = "Ajusta el brillo del juego",
    Step = 0.1,
    Value = {
        Min = 0,
        Max = 5,
        Default = 1,
    },
    Callback = function(v)
        Lighting.Brightness = v
    end
})

VisualsTab:Space()

VisualsTab:Slider({
    Title = "⏰ Hora del Día",
    Desc = "Cambia la hora en el juego",
    Step = 1,
    Value = {
        Min = 0,
        Max = 24,
        Default = 12,
    },
    Callback = function(v)
        Lighting.ClockTime = v
    end
})

local SpectateTab = Window:Tab({
    Title = "Espectador",
    Icon = "video",
    IconColor = Color3.fromHex("#ECA201"),
})

local SpectateSection = SpectateTab:Section({
    Title = "📹 Sistema de Espectador Avanzado"
})

local CurrentSpectating = nil
local OriginalCamera = workspace.CurrentCamera.CameraSubject
local SelectedPlayer = ""

local PlayersList = {}
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(PlayersList, player.Name)
    end
end

SpectateTab:Dropdown({
    Title = "Seleccionar Jugador",
    Desc = "Elige un jugador para espectear",
    Values = (function()
        local values = {}
        for _, name in pairs(PlayersList) do
            table.insert(values, {
                Title = name,
                Icon = "user",
                Callback = function()
                    SelectedPlayer = name
                    WindUI:Notify({
                        Title = "Jugador Seleccionado",
                        Content = name
                    })
                end
            })
        end
        return values
    end)()
})

Players.PlayerAdded:Connect(function(player)
    task.wait(1)
    table.insert(PlayersList, player.Name)
end)

Players.PlayerRemoving:Connect(function(player)
    for i, name in pairs(PlayersList) do
        if name == player.Name then
            table.remove(PlayersList, i)
            break
        end
    end
    
    if CurrentSpectating and CurrentSpectating.Name == player.Name then
        workspace.CurrentCamera.CameraSubject = OriginalCamera
        CurrentSpectating = nil
    end
end)

SpectateTab:Space()

local SpectateToggle
SpectateToggle = SpectateTab:Toggle({
    Title = "📹 Espectear Jugador",
    Desc = "Ver desde su perspectiva",
    Value = false,
    Callback = function(v)
        if v then
            if SelectedPlayer ~= "" then
                local player = Players:FindFirstChild(SelectedPlayer)
                if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                    CurrentSpectating = player
                    workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                    WindUI:Notify({
                        Title = "Especteando",
                        Content = "Viendo a " .. player.Name
                    })
                else
                    SpectateToggle:Set({ Value = false })
                    WindUI:Notify({
                        Title = "Error",
                        Content = "Jugador no disponible"
                    })
                end
            else
                SpectateToggle:Set({ Value = false })
                WindUI:Notify({
                    Title = "Error",
                    Content = "Selecciona un jugador primero"
                })
            end
        else
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or OriginalCamera
            CurrentSpectating = nil
            WindUI:Notify({
                Title = "Espectear Desactivado",
                Content = "Volviendo a tu vista"
            })
        end
    end
})

SpectateTab:Space({ Columns = 2 })

local SpectateInfoSection = SpectateTab:Section({
    Title = "ℹ️ Información del Jugador"
})

local SpectateInfoText = SpectateTab:Section({
    Title = "Selecciona y activa el espectador",
    TextSize = 13,
    TextTransparency = 0.5,
})

task.spawn(function()
    while task.wait(0.5) do
        if CurrentSpectating and CurrentSpectating.Character then
            local humanoid = CurrentSpectating.Character:FindFirstChild("Humanoid")
            local rootPart = CurrentSpectating.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and rootPart then
                local info = string.format(
                    "👤 Jugador: %s\n❤️ Vida: %.0f/%.0f\n🏃 Velocidad: %.1f\n📍 Posición: %.0f, %.0f, %.0f\n📏 Distancia: %d studs",
                    CurrentSpectating.Name,
                    humanoid.Health,
                    humanoid.MaxHealth,
                    humanoid.WalkSpeed,
                    rootPart.Position.X,
                    rootPart.Position.Y,
                    rootPart.Position.Z,
                    GetPlayerDistance(CurrentSpectating)
                )
                SpectateInfoText:Set({ Title = info })
            end
        else
            SpectateInfoText:Set({ Title = "Selecciona y activa el espectador" })
        end
    end
end)

SpectateTab:Space({ Columns = 2 })

SpectateTab:Button({
    Title = "⏭️ Siguiente Jugador",
    Desc = "Cambia al siguiente jugador",
    Icon = "skip-forward",
    Callback = function()
        local players = Players:GetPlayers()
        local currentIndex = 1
        
        for i, player in ipairs(players) do
            if CurrentSpectating and player == CurrentSpectating then
                currentIndex = i
                break
            end
        end
        
        local nextIndex = currentIndex % #players + 1
        local nextPlayer = players[nextIndex]
        
        if nextPlayer ~= LocalPlayer and nextPlayer.Character and nextPlayer.Character:FindFirstChild("Humanoid") then
            CurrentSpectating = nextPlayer
            workspace.CurrentCamera.CameraSubject = nextPlayer.Character.Humanoid
            WindUI:Notify({
                Title = "Siguiente Jugador",
                Content = "Ahora viendo a " .. nextPlayer.Name
            })
        end
    end
})

SpectateTab:Space()

SpectateTab:Button({
    Title = "📸 Teleportarse al Jugador",
    Desc = "Teletransportate a quien estás viendo",
    Icon = "zap",
    Color = Color3.fromHex("#ff4830"),
    Callback = function()
        if CurrentSpectating and CurrentSpectating.Character then
            local targetRootPart = CurrentSpectating.Character:FindFirstChild("HumanoidRootPart")
            local myRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if targetRootPart and myRootPart then
                myRootPart.CFrame = targetRootPart.CFrame
                WindUI:Notify({
                    Title = "Teletransportado",
                    Content = "Te has teletransportado a " .. CurrentSpectating.Name
                })
            end
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Debes estar especteando a alguien"
            })
        end
    end
})

local OptimizationTab = Window:Tab({
    Title = "Optimización",
    Icon = "zap",
    IconColor = Color3.fromHex("#10C550"),
})

local PerformanceSection = OptimizationTab:Section({
    Title = "⚡ Optimización Extrema"
})

OptimizationTab:Toggle({
    Title = "🚀 Booster FPS Ultra",
    Desc = "Optimización máxima de rendimiento",
    Value = false,
    Callback = function(v)
        if v then
            local Terrain = workspace:FindFirstChildOfClass("Terrain")
            if Terrain then
                Terrain.Decoration = false
            end
            
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            
            for _, obj in pairs(game:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj.Enabled = false
                elseif obj:IsA("Explosion") then
                    obj.BlastPressure = 1
                    obj.BlastRadius = 1
                elseif obj:IsA("Fire") or obj:IsA("SpotLight") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj.Enabled = false
                elseif obj:IsA("MeshPart") then
                    obj.Material = Enum.Material.Plastic
                    obj.Reflectance = 0
                elseif obj:IsA("Part") then
                    obj.Material = Enum.Material.Plastic
                end
            end
            
            workspace.DescendantAdded:Connect(function(obj)
                if v then
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                        obj.Enabled = false
                    end
                end
            end)
            
            WindUI:Notify({
                Title = "FPS Booster Activado",
                Content = "Optimización máxima aplicada"
            })
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end
})

OptimizationTab:Space()

OptimizationTab:Toggle({
    Title = "📡 Optimizador de Ping",
    Desc = "Reduce la latencia de red",
    Value = false,
    Callback = function(v)
        if v then
            settings().Network.IncomingReplicationLag = 0
            WindUI:Notify({
                Title = "Ping Optimizado",
                Content = "Latencia reducida"
            })
        else
            settings().Network.IncomingReplicationLag = 0.1
        end
    end
})

OptimizationTab:Space()

OptimizationTab:Button({
    Title = "🧹 Limpieza Profunda",
    Desc = "Elimina todos los objetos innecesarios",
    Icon = "trash",
    Callback = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("Sound") or obj:IsA("SoundGroup") then
                obj:Destroy()
            end
        end
        
        for _, obj in pairs(Lighting:GetDescendants()) do
            if obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("SunRaysEffect") then
                obj.Enabled = false
            end
        end
        
        WindUI:Notify({
            Title = "Limpieza Completa",
            Content = "Workspace optimizado"
        })
    end
})

OptimizationTab:Space()

OptimizationTab:Toggle({
    Title = "🌫️ Eliminar Niebla",
    Desc = "Remueve toda la niebla del juego",
    Value = false,
    Callback = function(v)
        if v then
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
        else
            Lighting.FogEnd = 100
        end
    end
})

OptimizationTab:Space()

OptimizationTab:Toggle({
    Title = "🌓 Desactivar Sombras",
    Desc = "Elimina todas las sombras",
    Value = false,
    Callback = function(v)
        if v then
            Lighting.GlobalShadows = false
            
            for _, obj in pairs(Lighting:GetChildren()) do
                if obj:IsA("PostEffect") then
                    obj.Enabled = false
                end
            end
        else
            Lighting.GlobalShadows = true
        end
    end
})

OptimizationTab:Space({ Columns = 2 })

local MemorySection = OptimizationTab:Section({
    Title = "💾 Gestión de Memoria"
})

OptimizationTab:Button({
    Title = "🗑️ Limpiar Memoria",
    Desc = "Libera memoria RAM",
    Icon = "database",
    Callback = function()
        collectgarbage("collect")
        WindUI:Notify({
            Title = "Memoria Limpiada",
            Content = "RAM liberada exitosamente"
        })
    end
})

OptimizationTab:Space()

OptimizationTab:Toggle({
    Title = "🔄 Auto-Limpieza",
    Desc = "Limpia memoria automáticamente cada 60s",
    Value = false,
    Callback = function(v)
        if v then
            task.spawn(function()
                while v do
                    task.wait(60)
                    collectgarbage("collect")
                    WindUI:Notify({
                        Title = "Auto-Limpieza",
                        Content = "Memoria limpiada automáticamente"
                    })
                end
            end)
        end
    end
})

local SettingsTab = Window:Tab({
    Title = "Ajustes",
    Icon = "settings",
    IconColor = Color3.fromHex("#83889E"),
})

local UISection = SettingsTab:Section({
    Title = "🎨 Personalización de UI"
})

SettingsTab:Toggle({
    Title = "🌙 Tema Oscuro",
    Desc = "Alterna entre claro y oscuro",
    Value = true,
    Callback = function(v)
        Window:SetTheme(v and "Dark" or "Light")
    end
})

SettingsTab:Space()

SettingsTab:Slider({
    Title = "Transparencia de UI",
    Desc = "Ajusta la transparencia general",
    Step = 0.05,
    Value = {
        Min = 0,
        Max = 1,
        Default = 0,
    },
    Callback = function(v)
        Window:SetTransparency(v)
    end
})

SettingsTab:Space()

SettingsTab:Slider({
    Title = "Escala de UI",
    Desc = "Cambia el tamaño de la interfaz",
    Step = 0.1,
    Value = {
        Min = 0.5,
        Max = 1.5,
        Default = 1,
    },
    Callback = function(v)
        Window:SetUIScale(v)
    end
})

if Platform == "PC" then
    SettingsTab:Space({ Columns = 2 })
    
    local KeybindSection = SettingsTab:Section({
        Title = "⌨️ Controles"
    })
    
    SettingsTab:Keybind({
        Title = "Tecla para Abrir/Cerrar",
        Desc = "Cambia el keybind del menú",
        Value = "R",
        Callback = function(v)
            Window:SetToggleKey(Enum.KeyCode[v])
            WindUI:Notify({
                Title = "Keybind Cambiado",
                Content = "Ahora usa " .. v
            })
        end
    })
end

SettingsTab:Space({ Columns = 2 })

local GeneralSection = SettingsTab:Section({
    Title = "⚙️ General"
})

SettingsTab:Button({
    Title = "🔄 Reiniciar Personaje",
    Desc = "Respawn rápido",
    Icon = "refresh-cw",
    Callback = function()
        LocalPlayer.Character:BreakJoints()
    end
})

SettingsTab:Space()

SettingsTab:Button({
    Title = "📋 Copiar Info Completa",
    Desc = "Información técnica del hub",
    Icon = "clipboard",
    Callback = function()
        local info = string.format(
            "═══════════════════════════════════\n" ..
            "ZXZ COMMUNITY HUB v2.0.0\n" ..
            "═══════════════════════════════════\n" ..
            "👤 Usuario: %s (@%s)\n" ..
            "🆔 User ID: %s\n" ..
            "📅 Account Age: %d días\n" ..
            "💻 Plataforma: %s\n" ..
            "🎮 Juego: %s\n" ..
            "🌐 Server ID: %s\n" ..
            "⚙️ Executor: %s\n" ..
            "═══════════════════════════════════\n" ..
            "📡 Ping: %d ms\n" ..
            "⚡ FPS: %d\n" ..
            "💾 Memoria: %.1f MB\n" ..
            "═══════════════════════════════════\n" ..
            "🔗 Discord: discord.gg/D6Zq8Uc6nV\n" ..
            "👨‍💻 Desarrollador: insert\n" ..
            "═══════════════════════════════════",
            LocalPlayer.DisplayName,
            LocalPlayer.Name,
            LocalPlayer.UserId,
            LocalPlayer.AccountAge,
            Platform,
            game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
            game.JobId,
            identifyexecutor and identifyexecutor() or "Desconocido",
            GetPing(),
            GetFPS(),
            Stats:GetTotalMemoryUsageMb()
        )
        setclipboard(info)
        WindUI:Notify({
            Title = "¡Información Copiada!",
            Content = "Datos completos copiados"
        })
    end
})

SettingsTab:Space()

SettingsTab:Button({
    Title = "📱 Copiar Discord",
    Desc = "Link de la comunidad ZXZ",
    Icon = "message-circle",
    Color = Color3.fromHex("#5865F2"),
    Callback = function()
        setclipboard("https://discord.gg/D6Zq8Uc6nV")
        WindUI:Notify({
            Title = "Discord Copiado",
            Content = "discord.gg/D6Zq8Uc6nV"
        })
    end
})

SettingsTab:Space({ Columns = 3 })

local AboutSection = SettingsTab:Section({
    Title = "ℹ️ Acerca de ZXZ Hub"
})

SettingsTab:Section({
    Title = "ZXZ Community Hub es el ejecutor más completo y profesional para Roblox.\n\nCaracterísticas:\n• ESP Avanzado con distancias\n• Sistema de vuelo suave\n• Optimización extrema de FPS\n• Espectador profesional\n• Anti-AFK integrado\n• Y mucho más...\n\nDesarrollado con ❤️ por insert\nComunidad: ZXZ\nVersión: 2.0.0 Premium",
    TextSize = 13,
    TextTransparency = 0.4,
})

SettingsTab:Space()

SettingsTab:Button({
    Title = "⭐ Calificar Hub",
    Desc = "Danos tu feedback",
    Icon = "star",
    Color = Color3.fromHex("#FFD700"),
    Callback = function()
        WindUI:Notify({
            Title = "¡Gracias!",
            Content = "Tu opinión es muy importante para nosotros"
        })
    end
})

WindUI:Notify({
    Title = "¡Bienvenido a ZXZ Hub Premium!",
    Content = "Todas las funciones han sido cargadas exitosamente"
})
