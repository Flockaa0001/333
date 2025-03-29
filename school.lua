getgenv().Index = {
    ['Start'] = {
        ['Options'] = { 
            ['Intro'] = { ['Enabled'] = true, ['Use Sound'] = false, },
            ['Execution Information'] = false,
            ['Version'] = ('2.7'),
            ['License'] = ('keygoeshere'), --[[ luarmor key ]]--
        },
        ['Silent'] = {
            ['Enabled'] = true,
            ['Type'] = 'Target', --[[ FOV, Target ]]--
            ['Prediction'] = 0,
            ['Hitpart'] = 'UpperTorso',
            ['AirPart'] = 'Head',
            ['ClosestPart'] = true,
            ['Nearest Point'] = false,
            ['Nearest Point Mode'] = 'Full', --[[ Generic, Static, Scalar, Dynamic, Full ]]--
            ['Anti Aim Viewer'] = false,
            ['FOV'] = {
                    ['Transparency'] = 1,
                    ['Visible'] = false,
                    ['Thickness'] = 1,
                    ['Color'] = Color3.fromRGB(111, 111, 11),
                    ['Radius'] = 150,
            },
        },
        ['SilentOffsets'] = { 
            ['Jump'] = 0, 
            ['Fall'] = 0
        },
        ['AimbotOffsets'] = { 
            ['Enabled'] = true, 
            ['Jump'] = 3, 
            ['Fall'] = -12
        },
        ['Aimbot'] = {
            ['Enabled'] = true,
            ['Keybind'] = 'C',
            ['Smoothness'] = 0.12,
            ['Prediction'] = 0.14,
            ['Hitpart'] = 'UpperTorso',
            ['ClosestPart'] = false,
            ['Notification'] = false
        },
        ['Style'] = {
            ['Easing'] = 'Bounce', --[[ Linear, Sine, Quad, Cubic, Exponential, Back, Bounce, Elastic ]]--
            ['Direction'] = 'InOut' --[[ In, Out, InOut ]]--
        },
        ['HitboxExpander'] = {
            ['Enabled'] = false,
            ['Visualize'] = false,
            ['NormalSize'] = 15,     
            ['Scaling'] = { --[[ custom scaling if u dont want to use the same value for each x,y,z ]]--
                    ['Enabled'] = false, --[[ if "false" then uses "normalsize" ]]--
                    ['X'] = 11,
                    ['Y'] = 1,
                    ['Z'] = 1
            },
        },
        ['MouseTp'] = {
            ['Enabled'] = false,
            ['LerpValues'] = 0.341941515,
            ['MousePrediction'] = 0.18014512
        },
        ['TriggerBot'] = {
            ['Enabled'] = false,
            ['Keybind'] = 'T',
            ['Prediction'] = 0.01, --[[ also known as delay ]]--
            ['Notification'] = true,
            ['Blacklisted'] = { --[[ can add any weapon / item to this such as food, katana and other things]]--
                   "[Knife]"
            },
        },
        ['Misc'] = {
            ['Adjustment'] = {
                ['VelocityThresold'] = 100,
            },
            ['Spread Modifier'] = {
                ['Enabled'] = true,
                ['Spread Percentage'] = 50, --[[ 100 for no spread modification ]]--
            },
            ['WalkSpeed'] = {
                ['Enabled'] = true,
                ['Mode'] = 'Humanoid', --[[ Humanoid, CFrame ]]--
                ['Speed'] = 275,
                ['Keybind'] = 'H',
            },
            ['No Jump Cool Down'] = {
                ['Enabled'] = true,
            },
            ['Resolver'] = {
                ['Enabled'] = false,
                ['Keybind'] = 'G',
                ['Method'] = 'Delta', --[[ Delta, Recalculate ]]--
                ['Adjust'] = 0.2,
                ['Notifications'] = false,
            },
            ['Macro'] = {
                ['Keybind'] = 'X',
                ['Enabled'] = true,
                ['Acceleration'] = 0.0,
                ['Variety'] = 'Third', --[[ First, Third ]]--
            },
            ['Spin'] = {
                ['Keybind'] = 'V',
                ['Degrees'] = 360,
                ['Acceleration'] = 4900,
                ['Directions'] = 'North',
                ['Smoothness'] = 1,
            },
            ['Textures'] = {
                ['Enabled'] = flse,
                ['Material'] = 'Brick', --[[ https://create.roblox.com/docs/reference/engine/enums/Material ]]--
                ['UseColor'] = false,
                ['Color'] = Color3.fromRGB(255,255,255),
            },
            ['Skyboxes'] = {
                ['Enabled'] = true,
                ['Texture ID'] = '5084474758',
            },
            ['Checks'] = {
                ['KO'] = true,
                ['Wall Check'] = true,
            },
        },
    },
}

--[[
Index.CC - 2024-2025 ALL RIGHTS RESERVED

mostly coded by @stolencoin (everything rewritten mostly except)
]]--



Script = {
    Drawing = {}
}




local function SanityCheck()
local UserVersion = getgenv().Index.Start.Options.Version
local URL = 'https://raw.githubusercontent.com/xc7b/index/refs/heads/main/table.lua'
local CurrentVersion = '2.7'
local KickMessages = {
    ['Outdated'] = 'outdated table, use the newest one with the link copied to your clipboard',
    ['Version'] = 'outdated version, table version: ' .. UserVersion .. ', newest version: ' .. CurrentVersion,
    ['Unsupported'] = 'Unsupported executor: ' .. identifyexecutor()
}
--
local function Kick(Reason)
    local message = KickMessages[Reason]
    if message then
        game.Players.LocalPlayer:Kick(message)
    else
        game.Players.LocalPlayer:Kick('Unknown error occurred.')
    end
end
--
if not getgenv().Index.Start.Options.Version then
    setclipboard(URL)
    Kick('Outdated')
end
--	
if CurrentVersion ~= UserVersion then
    setclipboard(URL)
    Kick('Version')
end
end
--
SanityCheck()
--

local updateconfig = true
    if getgenv().Loaded == true then
        if updateconfig == true then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "discord.gg/getindex",
                Text = "updated script configuration",
                Duration = 0.01
            })
        end
    return
end

--//  Services and Players
local click = false
local rotate = 0
local render = 0
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local freeFall = Enum.HumanoidStateType.Freefall
local jumping = Enum.HumanoidStateType.Jumping
local Client = game:GetService("Players").LocalPlayer

local Mooze = {
	Locals = {
		LastStutter = tick(),
		TriggerTick = tick(),
		CrossTick = tick(),
        VisualTick = tick(),
		SilentAim = true,
		Triggerbot = true,
		NoClipMacro = false,
		AntiAiming = false,
		Bounding = false,
		Pressed = false,
		Aimbot = true,
		Macro = false,
		Mode = 'Camera'
	},
	Universal = {
		FindPartOnRayWithIgnoreList = {
			ArgCountRequired = 3,
			Args = {
				'Instance', 'Ray', 'table', 'boolean', 'boolean'
			}
		},
		FindPartOnRayWithWhitelist = {
			ArgCountRequired = 3,
			Args = {
				'Instance', 'Ray', 'table', 'boolean'
			}
		},
		FindPartOnRay = {
			ArgCountRequired = 2,
			Args = {
				'Instance', 'Ray', 'Instance', 'boolean', 'boolean'
			}
		},
		Raycast = {
			ArgCountRequired = 3,
			Args = {
				'Instance', 'Vector3', 'Vector3', 'RaycastParams'
			}
		}
	},
	Safe = true
}

local function Args()
        if string.find(identifyexecutor(), 'Solara') then
            local i = game.PlaceId
            local Argument

            if i == 2788229376 or i == 7213786345 or i == 16033173781 then
                Argument = "UpdateMousePosI2"
            elseif i == 9825515356 then
                Argument = "MousePosUpdate"
            else
                Argument = "UpdateMousePos"
            end
        return Argument
    end
end

local Script = { --// variables for the table, target etc
    Table = getgenv().Index,
    Target = nil,
    MainEvent = nil,
    Argument = Args(),
    Functions = {},
    Connections = {},
}

if getgenv().Index.Start.Options['Execution Information'] then
    
    Script.Drawing.Intro = Drawing.new("Text")
    Script.Drawing.Intro.Text = "Loading Index"
    Script.Drawing.Intro.Size = 20
    Script.Drawing.Intro.Color = Color3.new(1.000000, 1.000000, 1.000000)
    Script.Drawing.Intro.Outline = true
    Script.Drawing.Intro.OutlineColor = Color3.fromRGB(0, 0, 0)
    Script.Drawing.Intro.Visible = true
    Script.Drawing.Intro.Font = 2
    
    local camera = workspace.CurrentCamera
    Script.Drawing.Intro.Position = Vector2.new(camera.ViewportSize.X / 2.2, camera.ViewportSize.Y - 370)
    
    task.spawn(function()
    while true do
        for i = 0, 1, 0.1 do
            Script.Drawing.Intro.Transparency = i
            task.wait(0.05)
        end
        for i = 1, 0, -0.1 do
            Script.Drawing.Intro.Transparency = i
            task.wait(0.05)
        end
    end
    end)
    
    local startoftheIntro = tick()
    wait(2)
    local LOADED = tick() - startoftheIntro
    
    Script.Drawing.Intro:Remove()
    Script.Drawing.Loaded = Drawing.new("Text")
    Script.Drawing.Loaded.Text = "Loaded In " .. string.format("%.3f", LOADED) .. " sec"
    Script.Drawing.Loaded.Size = 20
    Script.Drawing.Loaded.Color = Color3.new(1.000000, 1.000000, 1.000000)
    Script.Drawing.Loaded.Outline = true
    Script.Drawing.Loaded.OutlineColor = Color3.fromRGB(0, 0, 0)
    Script.Drawing.Loaded.Visible = true
    Script.Drawing.Loaded.Position = Vector2.new(camera.ViewportSize.X / 2.2, camera.ViewportSize.Y - 370)
    Script.Drawing.Loaded.Font = 2
    
    task.spawn(function()
    for i = 0, 1, 0.1 do
        Script.Drawing.Loaded.Transparency = i
        task.wait(0.05)
    end
    wait(1)
    for i = 1, 0, -0.1 do
        Script.Drawing.Loaded.Transparency = i
        task.wait(0.05)
    end
    Script.Drawing.Loaded:Remove()
    end)
    
    wait(1)
    
end

if getgenv().Index.Start.Options.Intro.Enabled then
Script.Functions.PlayThatBitch = function()
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "IntroScreen"
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Name = "IntroFrame"
    frame.Parent = screenGui
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "IntroImage"
    imageLabel.Parent = frame
    imageLabel.Size = UDim2.new(0.01, 0, 0.01, 0)  
    imageLabel.Position = UDim2.new(0.5, -0.1, 0.5, -0.1) 
    imageLabel.Image = "rbxassetid://106428636831184"
    imageLabel.BackgroundTransparency = 1
    imageLabel.ImageTransparency = 100
    imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    
    if getgenv().Index.Start.Options.Intro['Use Sound'] then
    local sound = Instance.new("Sound")
    sound.Name = "IntroSound"
    sound.Parent = frame
    sound.SoundId = "rbxassetid://6580172940"
    sound.Volume = 50
    sound:Play()
    end
    local tweenService = game:GetService("TweenService")

    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Parent = game.Lighting
    blurEffect.Size = 60

    local zoomTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  
    local blurTweenInfo = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  

    local fadeIn = tweenService:Create(imageLabel, zoomTweenInfo, {ImageTransparency = 0.5})
    local fadeOut = tweenService:Create(imageLabel, zoomTweenInfo, {ImageTransparency = 1})
    local blurTween = tweenService:Create(blurEffect, blurTweenInfo, {Size = 0})  
    local zoomTween = tweenService:Create(imageLabel, zoomTweenInfo, {Size = UDim2.new(0.35, 0, 0.35, 0)})

    fadeIn:Play()
    fadeIn.Completed:Wait()

    zoomTween:Play()
    blurTween:Play()

    wait(3)  

    fadeOut:Play()
    fadeOut.Completed:Wait()

    blurTween:Play()
    blurTween.Completed:Wait()

    blurEffect:Destroy()
    screenGui:Destroy()
end

Script.Functions.PlayThatBitch()
end

--// FOV
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local Gui = game:GetService("GuiService")
local Camera = workspace.CurrentCamera
local mouse = Player:GetMouse()
local insetX, insetY = Gui:GetGuiInset().X, Gui:GetGuiInset().Y
local rs = game:GetService("RunService")

Script.Functions.GetClosest = function() --// functions to get player near cursor this basically detects the player humanoidrootpart based on mouselocation of localplayers
local Target
local Closest = math.huge
for _, Player in pairs(Players:GetPlayers()) do
    if Player ~= Client and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local PartPos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
        local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - UserInputService:GetMouseLocation()).Magnitude
        if Magnitude < Closest and OnScreen then
            Target = Player
            Closest = Magnitude
        end
    end
end
return Target
end

--// Main Drwaing functions
local FOV = getgenv().Index.Start.Silent.FOV
local blunt = Drawing.new("Circle")
blunt.Radius = FOV.Radius
blunt.Transparency = FOV.Transparency
blunt.Thickness = FOV.Thickness
blunt.Visible = FOV.Visible
blunt.Color = FOV.Color


--// I used Inset To make it goes to the middle 
Script.Connections.FOVOptimization = rs.RenderStepped:Connect(function()
blunt.Position = Vector2.new(mouse.X + insetX, mouse.Y + insetY)
end)

Script.Functions.NearestPlayer = function()
local Target
local Closest = math.huge
for _, Player in pairs(Players:GetPlayers()) do
    if Player ~= Client and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local PartPos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
        local MouseLocation = UserInputService:GetMouseLocation()
        local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - MouseLocation).Magnitude
        if Magnitude < Closest and Magnitude <= blunt.Radius and OnScreen then
            Target = Player
            Closest = Magnitude
        end
    end
end
return Target
end



local player = game.Players.LocalPlayer
local Mouse = player:GetMouse()


Script.Functions.GetClosestPart = function(player)
local MaxDistance = math.huge
local ClosestPart = nil

for value, index in pairs(player.Character:GetChildren()) do
    if table.find({"Part", "MeshPart", "BasePart"}, index.ClassName) then
        local Position = workspace.CurrentCamera:WorldToScreenPoint(index.Position)
        local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(mouse.X, Mouse.Y)).Magnitude
        if Distance < MaxDistance then
            ClosestPart = index
            MaxDistance = Distance
        end
    end
end
return ClosestPart
end
Script.Functions.ResolvedVelocity = function(bodypart, delta, lastpos)
local ggpos = bodypart.Position
local tick = tick()
local timepos = ggpos - lastpos
local deltatime = tick - delta

deltatime = math.clamp(deltatime, 0, 0.033333333333333)

local latestvel = timepos / deltatime

return latestvel, ggpos, tick
end

Script.Functions.POS = function()
local silentSettings = getgenv().Index and getgenv().Index.Start.Silent
local target

if not silentSettings then return end

if silentSettings.Type == "FOV" and getgenv().Index.Start.Silent.Enabled then
    target = Script.Functions.NearestPlayer()
elseif silentSettings.Type == "Target" and getgenv().Index.Start.Silent.Enabled then
    target = Script.Target
end

if target and target.Character then
    local character = target.Character
    local bodyEffects = character:FindFirstChild("BodyEffects")
    local KOd = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
    local humanoid = character:FindFirstChild("Humanoid")
    
    if getgenv().Index.Start.Misc.Checks.KO and humanoid and (humanoid.Health <= 0 or KOd) then
        target = nil
    end

    if target and character then
        local targetPart = character:FindFirstChild(getgenv().Index.Start.Silent.Hitpart)
        local airPart = character:FindFirstChild(getgenv().Index.Start.Silent.AirPart)

        if targetPart then
            local prediction = targetPart.Velocity * silentSettings.Prediction
            local position

            if character:FindFirstChild("Humanoid") and character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                targetPart = airPart
                position = targetPart and targetPart.CFrame or nil
            else
                position = targetPart.CFrame
            end
            
            if getgenv().Index.Start.Misc.Resolver.Enabled then
            local parts = getgenv().Index.Start.Silent.Hitpart
            local formula = Script.Functions.ResolvedVelocity(targetPart, tick(), targetPart.Position)
            local endpoint = targetPart.Position + formula * silentSettings.Prediction
            return CFrame.new(endpoint)
            elseif silentSettings.ClosestPart then
                local closestPart = Script.Functions.GetClosestPart(target)
                local endpoint = closestPart and closestPart.Position + prediction
                return CFrame.new(endpoint)
            else
                local predictedPosition = position + prediction
                return predictedPosition
            end
        end
    end
end
end

Script.Functions.POS2 = function()
local silentSettings = getgenv().Index and getgenv().Index.Start.Silent
local target

if not silentSettings then return end

if silentSettings.Type == "FOV" and getgenv().Index.Start.Silent.Enabled then
    target = Script.Functions.NearestPlayer()
elseif silentSettings.Type == "Target" and getgenv().Index.Start.Silent.Enabled then
    target = Script.Target
end

if target and target.Character then
    local character = target.Character
    local bodyEffects = character:FindFirstChild("BodyEffects")
    local KOd = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
    local humanoid = character:FindFirstChild("Humanoid")
    
    if getgenv().Index.Start.Misc.Checks.KO and humanoid and (humanoid.Health <= 0 or KOd) then
        target = nil
    end

    if target and character then
        local targetPart = character:FindFirstChild(getgenv().Index.Start.Silent.Hitpart)
        local airPart = character:FindFirstChild(getgenv().Index.Start.Silent.AirPart)

        if targetPart then
            local prediction = targetPart.Velocity * silentSettings.Prediction
            local position

            if character:FindFirstChild("Humanoid") and character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                targetPart = airPart
                position = targetPart and targetPart.Position or nil
            else
                position = targetPart.Position
            end

            if getgenv().Index.Start.Misc.Resolver.Enabled then
            local parts = getgenv().Index.Start.Silent.Hitpart
            local formula = Script.Functions.ResolvedVelocity(targetPart, tick(), targetPart.Position)
            local endpoint = targetPart.Position + formula * silentSettings.Prediction
            return endpoint
            elseif silentSettings.ClosestPart then
                local closestPart = Script.Functions.GetClosestPart(target)
                local endpoint = closestPart and closestPart.Position + prediction
                return endpoint
            else
                local predictedPosition = position + prediction
                return predictedPosition
            end
        end
    end
end
end

if game.PlaceId == 9825515356 and getgenv().Index.Start.Silent.Enabled then
RunService.PostSimulation:Connect(function()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local framework = playerGui:WaitForChild("Framework", math.huge)
    
    if framework then
        local env = getsenv(framework)
        if env and env._G then
            local BIGNIGGER = Script.Functions.POS2()
            if BIGNIGGER then
                env._G.MOUSE_POSITION = BIGNIGGER
            end
        end
    end
end)
end

if game.PlaceId ~= 9825515356 and getgenv().Index.Start.Silent.Enabled then
local grmt = getrawmetatable(game)
local MousePosChanger2 = nil
setreadonly(grmt, false)
MousePosChanger2 = grmt.__index


grmt.__index = function(self, Index)
    if not checkcaller() and self == Mouse then
        if Index == "Hit" then
            local EndPoint = Script.Functions.POS()
            if EndPoint then
                return EndPoint
            end
        elseif Index == "Target" and game.PlaceId == 2788229376 then
            local EndPoint = Script.Functions.POS()
                if EndPoint then
                    return EndPoint
                end
            end
        end
        return MousePosChanger2(self, Index)
    end
end

-- // Nearest Point modes

function Mooze:GetNearestPointOnCharacter(Character, Mode, Type, UseCenter, Reduction)
    local Part = Mooze:GetAllBodyParts(Character)
    local Type = getgenv().Index.Start.Silent['Nearest Point Mode']

    --
    if Part ~= nil then
        if Mode then
            local LocalPosition = Part.CFrame:pointToObjectSpace(Mouse.Hit.Position)
            local Size = Part.Size / 2
            --
            local y = math.clamp(LocalPosition.y, -Size.y, Size.y)
            local w = Part.CFrame:pointToWorldSpace(Vector3new(0, y, 0))
            --
            return w    
        else
            if Type == 'Legacy' and getgenv().Index.Start.Silent['Nearest Point'] then
                local LocalPosition = Part.CFrame:pointToObjectSpace(Mouse.Hit.Position)
                local Size = Part.Size / 2
                --
                local x = math.clamp(LocalPosition.x, -Size.x, Size.x)
                local y = math.clamp(LocalPosition.y, -Size.y, Size.y)
                local z = math.clamp(LocalPosition.z, -Size.z, Size.z)
                local w = Part.CFrame:pointToWorldSpace(Vector3new(x, y, z))
                --
                return w    
            elseif Type == 'Dynamic' and getgenv().Index.Start.Silent['Nearest Point'] then
                local ClosestPointConfig = {
                    ReductionPercentage = Reduction,
                    Center = UseCenter,
                }
                --
                local Center = ClosestPointConfig.Center;
                local Point = UserInputService:GetMouseLocation()
                local ReductionPercentage = ClosestPointConfig.ReductionPercentage
                --
                local PointRay = Camera:ViewportPointToRay(Point.X, Point.Y)
                local Intersection = PointRay.Origin + (PointRay.Direction * PointRay.Direction:Dot(Part.Position - PointRay.Origin))
                local Transform = Part.CFrame:PointToObjectSpace(Intersection)
                local ReducedSize = (Part.Size - (Part.Size * ReductionPercentage / 100)) * (Center and Vector3.new(1, 1, 0) or 1)
                local HalfSize = ReducedSize / 2
                --
                return Part.CFrame * Vector3.new(math.clamp(Transform.X, -HalfSize.X, HalfSize.X), math.clamp(Transform.Y, -HalfSize.Y, HalfSize.Y), math.clamp(Transform.Z, -HalfSize.Z, HalfSize.Z))
            elseif Type == 'Full' and getgenv().Index.Start.Silent['Nearest Point'] then
                local Hit, Half = Mouse.Hit.Position, Part.Size * 0.25
                local Transform = Part.CFrame:PointToObjectSpace(Hit)
                local NearestPosition =
                    Part.CFrame *
                    Vector3.new(
                        math.clamp(Transform.X, -Half.X, Half.X),
                        math.clamp(Transform.Y, -Half.Y, Half.Y),
                        math.clamp(Transform.Z, -Half.Z, Half.Z)
                    )
                --
                return NearestPosition
            elseif Type == 'Static' and getgenv().Index.Start.Silent['Nearest Point'] then
                local LocalPosition = Part.CFrame:pointToObjectSpace(Mouse.Hit.Position)
                local Size = Part.Size / 2
                --
                local x = math.clamp(LocalPosition.x, -Size.x, Size.x)
                local y = math.clamp(LocalPosition.y, -Size.y, Size.y)
                local z = math.clamp(LocalPosition.z, -Size.z, Size.z)
                local w = Part.CFrame:pointToWorldSpace(Vector3.new(x, y, z))
                --
                return w    
            elseif Type == 'Scalar' and getgenv().Index.Start.Silent['Nearest Point'] then
                local Hit, Half = Mouse.Hit.p, Part.Size * 0.5
                local Transform = Part.CFrame:PointToObjectSpace(Hit)
                local Endpoint = Part.CFrame * Vector3.new(
                    math.clamp(Transform.X, - Half.X, Half.X), 
                    math.clamp(Transform.Y, - Half.Y, Half.Y), 
                    math.clamp(Transform.Z, - Half.Z, Half.Z)
                )
                --
                return Endpoint
            end
        end
    end
end

-- // Checks
local function GetClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPart = player.Character:FindFirstChild(getgenv().Index.Start.Aimbot.Hitpart)

            if targetPart and getgenv().Index.Start.Misc.Checks.Wall and PassesChecks(player) then
                local screenPosition, onScreen = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(targetPart.Position)
                local mousePos = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(screenPosition.X, screenPosition.Y) - mousePos).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end


--// Keybind  NOT OPTIMIZED i got lazy
Script.Connections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input, gameProcessedEvent)
if gameProcessedEvent then return end

local keybind = getgenv().Index.Start.Aimbot.Keybind
local AimbotEnabled = getgenv().Index.Start.Aimbot.Enabled

if Input.KeyCode == Enum.KeyCode[getgenv().Index.Start.Aimbot.Keybind] and AimbotEnabled then
    if Script.Target then
        Script.Target = nil
    else
        Script.Target = Script.Functions.GetClosest()
        if Script.Target then
            if getgenv().Index.Start.Aimbot.Notification then
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Index ; #1 Streamable",
                    Text = "Aimbot Target : " .. Script.Target.DisplayName,
                    Duration = 0.001,
                    Icon = "rbxassetid://106428636831184"
                })
            end
        end
    end
end
end)


local p_lr = game.Players.LocalPlayer
local players = game:GetService("Players")
local vec3 = Vector3.new
local renderstepped = game:GetService("RunService").RenderStepped

Utility = {}

if game.PlaceId == 2788229376 then
Utility.HitBoxExpander = function()
    if getgenv().Index.Start.HitboxExpander.Enabled then
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= p_lr then
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local part = character.HumanoidRootPart
                if getgenv().Index.Start.HitboxExpander.Scaling.Enabled then
                    part.Size = Vector3.new(
                        getgenv().Index.Start.HitboxExpander.Scaling.X,
                        getgenv().Index.Start.HitboxExpander.Scaling.Y,
                        getgenv().Index.Start.HitboxExpander.Scaling.Z
                    )
                else
                    part.Size = Vector3.new(
                        getgenv().Index.Start.HitboxExpander.NormalSize,
                        getgenv().Index.Start.HitboxExpander.NormalSize,
                        getgenv().Index.Start.HitboxExpander.NormalSize
                    )
                end
                    part.Transparency = 1
                    part.CanCollide = false

                    if getgenv().Index.Start.HitboxExpander.Visualize then
                        local edgeAdornment = part:FindFirstChild("HitboxEdges") or Instance.new("SelectionBox")
                        edgeAdornment.Name = "HitboxEdges"
                        edgeAdornment.Adornee = part
                        edgeAdornment.LineThickness = 0.05
                        edgeAdornment.SurfaceColor3 = Color3.fromRGB(0, 0, 255)
                        edgeAdornment.SurfaceTransparency = 0.9
                        edgeAdornment.Parent = part
                    end
                end
            end
        end
    end
end
end

Players.PlayerAdded:Connect(function(player)
player.CharacterAdded:Connect(function()
    if game.PlaceId == 2788229376 then
        Utility.HitBoxExpander()
    end
end)
end)


Script.Functions.isAirborne = function(player)
local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
return humanoid and humanoid:GetState() == Enum.HumanoidStateType.Freefall
end


--// Aimbot
Script.Functions.rewrittenAimbot = function()
if not Script.Target or not Script.Target.Character then return end

local bodyEffects = Script.Target.Character:FindFirstChild("BodyEffects")
if not bodyEffects then return end

local KOd = bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
local humanoid = Script.Target.Character:FindFirstChild("Humanoid")
if getgenv().Index.Start.Misc.Checks.KO and humanoid and (humanoid.Health <= 0 or KOd) then
    Script.Target = nil
    return
end

local partName = tostring(getgenv().Index.Start.Aimbot.Hitpart)
local Parts = Script.Target.Character:FindFirstChild(partName)
if not Parts then return end

local Smooth = getgenv().Index.Start.Aimbot.Smoothness
local future = getgenv().Index.Start.Aimbot.Prediction
local AirSmoothness = getgenv().Index.Start.MouseTp.LerpValues
local airpreds = getgenv().Index.Start.MouseTp.MousePrediction

if getgenv().Index.Start.MouseTp.Enabled and Script.Functions.isAirborne(Script.Target) then
    future = airpreds
    Smooth = AirSmoothness
end

local runService = game:GetService("RunService")
if getgenv().Index.Start.Misc.Resolver.Enabled and Parts then
    local lastPosition = Parts.Position
    task.wait()
    local currentPosition = Parts.Position
    local velocity = (currentPosition - lastPosition) / runService.RenderStepped:Wait()
    Parts.AssemblyLinearVelocity = velocity
    Parts.Velocity = velocity
end

local futurepos = Parts.Position + Parts.Velocity * future
if getgenv().Index.Start.AimbotOffsets.Enabled and humanoid then
    local humanoidState = humanoid:GetState()
    if humanoidState == Enum.HumanoidStateType.Jumping then
        futurepos = futurepos + Vector3.new(0, getgenv().Index.Start.AimbotOffsets.Jump, 0)
    elseif humanoidState == Enum.HumanoidStateType.Freefall then
        futurepos = futurepos + Vector3.new(0, getgenv().Index.Start.AimbotOffsets.Fall, 0)
    else
        futurepos = futurepos + Vector3.new(0, 0, 0)
    end
end

local Endpoint = Script.Functions.GetClosestPart(Script.Target)
local Mainendpoint = Endpoint.Position + Parts.Velocity * future

local TargetCamera
if getgenv().Index.Start.Aimbot.ClosestPart then
    TargetCamera = CFrame.new(workspace.CurrentCamera.CFrame.Position, Mainendpoint)
else
    TargetCamera = CFrame.new(workspace.CurrentCamera.CFrame.Position, futurepos)
end
workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(TargetCamera, Smooth,Enum.EasingStyle[getgenv().Index.Start.Style.Easing],Enum.EasingDirection[getgenv().Index.Start.Style.Direction])
end



local settings = getgenv().Index.Start
local isEnabled = false
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")

Script.Functions.handleMacro = function()
local acceleration = settings.Misc.Macro.Acceleration
if type(acceleration) ~= "number" then
    warn("Invalid Acceleration value") --// To handle a Value and make the variables from table to be enable only using number
    return
end

local speed = acceleration / 100000

if settings.Misc.Macro.Variety == "Third" then
    repeat
        task.wait(speed)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.I, false, game)
        task.wait(speed)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.O, false, game)
        task.wait(speed)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.I, false, game)
        task.wait(speed)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.O, false, game)
    until not isEnabled
elseif settings.Misc.Macro.Variety == "First" then
    repeat
        VirtualInputManager:SendMouseWheelEvent("0", "0", true, game)
        wait(speed)
        VirtualInputManager:SendMouseWheelEvent("0", "0", false, game)
        wait(speed)
        VirtualInputManager:SendMouseWheelEvent("0", "0", true, game)
        wait(speed)
        VirtualInputManager:SendMouseWheelEvent("0", "0", false, game)
        wait(speed)
    until not isEnabled
end
end

Script.Functions.onInputBegan = function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode[settings.Misc.Macro.Keybind] then
    isEnabled = not isEnabled
    if isEnabled then
        Script.Functions.handleMacro()
    end
end
end

UserInputService.InputBegan:Connect(Script.Functions.onInputBegan)

--// got this from my old tb kinda sucks 


Script.Functions.isDead = function(player)
local character = player.Character
if not character or not character:FindFirstChild("BodyEffects") then
    return false
end
local bodyEffects = character.BodyEffects
local ko = bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO")
return ko and ko.Value or false
end

Script.Functions.getTarget = function(instance)
if not instance then
    return false
end

for _, player in next, Players:GetPlayers() do
    if player.Character and (instance == player.Character or instance:IsDescendantOf(player.Character)) then
        if not Script.Functions.isDead(player) then
            return player
        end
    end
end

return false
end

Script.Functions.isToolBlacklisted = function(tool)
for _, toolName in ipairs(Script.Table.Start.TriggerBot.Blacklisted) do
    if tool.Name == toolName then
        return true
    end
end
return false
end
Script.Functions.sendNotification = function(message)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Index ; #1 Streamable",
    Text = message,
    Duration = 2
})
end

local JairoUGHH = false
Script.Functions.onKeyPress = function(input, gameProcessed)
if gameProcessed then return end
if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode[Script.Table.Start.TriggerBot.Keybind] then
    JairoUGHH = not JairoUGHH
    if Script.Table.Start.TriggerBot.Notification then
        Script.Functions.sendNotification("TriggerBot " .. (JairoUGHH and "Has Been Enabled" or "Has Been Disabled"))
    end
end
end

UserInputService.InputBegan:Connect(Script.Functions.onKeyPress)

Script.Functions.triggerBot = function()
local con
con = RunService.Heartbeat:Connect(function()
    if JairoUGHH then
        local target = mouse.Target

        if target and Script.Functions.getTarget(target) then
            if Client.Character then
                local tool = Client.Character:FindFirstChildWhichIsA('Tool')
                if tool and not Script.Functions.isToolBlacklisted(tool) then
                    if tool then
                        task.wait(Script.Table.Start.TriggerBot.Delay)
                        tool:Activate() --// tool activate is the best method
                    end
                end
            end
        end
    end
end)

Script.Connections.triggerBot = con
end



Script.Functions.triggerBot()

getgenv().disable = function()
getgenv().disable = nil
warn("Disconnecting:", Script.Connections.triggerBot)
Script.Connections.triggerBot:Disconnect() --// disconnect the fucking triggerbot when its disabled from the keybind 
end

--// ass rotation
Script.Functions.onKeyPress = function(Input, GameProcessedEvent)
if Input.KeyCode == Enum.KeyCode[getgenv().Index.Start.Misc.Spin.Keybind] and not GameProcessedEvent then
    click = not click
end
end

Script.Functions.getDirectionVector = function(direction)
if direction == "North" then
    return Vector3.new(0, 1, 0)
elseif direction == "South" then
    return Vector3.new(0, -1, 0)
elseif direction == "East" then
    return Vector3.new(1, 0, 0)
elseif direction == "West" then
    return Vector3.new(-1, 0, 0)
else
    return Vector3.new(0, 1, 0)
end
end

Script.Functions.rotateCamera = function()
if click then
    local currentTime = tick()
    local timeDelta = math.min(currentTime - render, 0.01)
    render = currentTime

    local rotationSpeed = getgenv().Index.Start.Misc.Spin.Acceleration * timeDelta
    local smoothRotation = rotationSpeed * getgenv().Index.Start.Misc.Spin.Smoothness

    local directionVector = Script.Functions.getDirectionVector(getgenv().Index.Start.Misc.Spin.Directions)
    local rotation = CFrame.fromAxisAngle(directionVector, math.rad(smoothRotation))
    Camera.CFrame = Camera.CFrame * rotation

    rotate = rotate + rotationSpeed
    if rotate >= getgenv().Index.Start.Misc.Spin.Degrees then
        click = false
        rotate = 0
    end
end
end

UserInputService.InputBegan:Connect(Script.Functions.onKeyPress)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end
if input.KeyCode == Enum.KeyCode[getgenv().Index.Start.Misc.Resolver.Keybind] then
    local resolver = getgenv().Index.Start.Misc.Resolver
    if resolver.Enabled then
        resolver.Enabled = false
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Resolver OFF",
            Text = "igettoomanyhuzz",
            Duration = 2,
        })
    else
        resolver.Enabled = true
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Resolver ON",
            Text = "igettoomanyhuzz",
            Duration = 2,
        })
    end
end
end)








local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()











local x = false
Script.Functions.Slavery = function(Character)
    local selfs = Character:WaitForChild("Humanoid")
    selfs:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if x then
            selfs.WalkSpeed = getgenv().Index.Start.Misc.WalkSpeed.Speed
        end
    end)
end

local player = game.Players.LocalPlayer
local character = player.Character

Script.Functions.Slavery(character)


game:GetService("UserInputService").InputBegan:Connect(function(Input, GameProcessedEvent)
    if Input.KeyCode == Enum.KeyCode[getgenv().Index.Start.Misc.WalkSpeed.Keybind] and not GameProcessedEvent then
        x = not x
    end
end)

Script.Functions.RemoveJumpCooldown = function(Character)
    if getgenv().Index.Start.Misc['No Jump Cool Down'].Enabled then
        local hum = Character:WaitForChild("Humanoid")
        hum:GetPropertyChangedSignal("JumpPower"):Connect(function()
            if hum.JumpPower ~= 55 then
                hum.JumpPower = 55
            end
        end)
    end
end

Script.Functions.RemoveJumpCooldown(character)

player.CharacterAdded:Connect(function(newCharacter)
    Script.Functions.Slavery(newCharacter)
    Script.Functions.RemoveJumpCooldown(newCharacter)
end)


RunService.RenderStepped:Connect(function()
if getgenv().Index.Start.HitboxExpander.Enabled and game.PlaceId == 2788229376 then
Utility.HitBoxExpander()
end
if Script.Target then
    Script.Functions.rewrittenAimbot()
end
Script.Functions.rotateCamera()
end)

if getgenv().Index.Start.Misc.Textures.Enabled == true then
for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = getgenv().Index.Start.Misc.Textures.Material -- replace with the texture name you want
    end
end
end

if getgenv().Index.Start.Misc.Textures.UseColor then
for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") then
        v.Color = getgenv().Index.Start.Misc.Textures.Color
    end
end
end

if getgenv().Index.Start.Misc.Skyboxes.Enabled then
    local s = Instance.new("Sky")
    s.Name = "SKY"
    local textureid = getgenv().Index.Start.Misc.Skyboxes['Texture ID']
    s.SkyboxBk = "http://www.roblox.com/asset/?id=" .. textureid
    s.SkyboxDn = "http://www.roblox.com/asset/?id=" .. textureid
    s.SkyboxFt = "http://www.roblox.com/asset/?id=" .. textureid
    s.SkyboxLf = "http://www.roblox.com/asset/?id=" .. textureid
    s.SkyboxRt = "http://www.roblox.com/asset/?id=" .. textureid
    s.SkyboxUp = "http://www.roblox.com/asset/?id=" .. textureid
    s.Parent = game.Lighting
end

getgenv().Loaded = true
