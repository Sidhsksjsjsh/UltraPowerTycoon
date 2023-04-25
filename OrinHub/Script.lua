local library = loadstring(game:HttpGet("https://pastebin.com/raw/Uub92rmN"))()


local Window = library:AddWindow("Orin - Cheat",
    {
        main_color = Color3.fromRGB(0, 128, 0),
        min_size = Vector2.new(373, 433),
        toggle_key = Enum.KeyCode.RightShift,
    })    

local player = game.Players.LocalPlayer

local function getTycoonOwned()
    
    for i, v in pairs(game:GetService("Workspace"):WaitForChild("Tycoons"):GetDescendants()) do
        
        if v and v:IsA("StringValue") and v.Value == player.Name and v.Name == "isim" then
            
            return v.Parent
            
        end
        
    end
    
end

--game:GetService("Workspace").Tycoons["Death Eye"].UltimaPad.CashRegister2.Ching

local function autoCollect()
    
    repeat
        
        -- try to locate tycoon
        getgenv().player_tycoon = getTycoonOwned()
        task.wait(1)
        
    until getgenv().player_tycoon
    
    local connection2
    local connection1 = getgenv().player_tycoon.CashRegister.Cash.Changed:Connect(function(Value)

        if getgenv().player_tycoon:FindFirstChild("UltimaPad") and getgenv().player_tycoon.UltimaPad:FindFirstChild("CashRegister2") and not connection2 then

            connection2 = getgenv().player_tycoon.UltimaPad.CashRegister2.Cash.Changed:Connect(function(Value)
            
                if Value > 0 then

                    firetouchinterest(getgenv().player_tycoon.UltimaPad.CashRegister2.Ching, player.Character.UpperTorso, 1)
                    firetouchinterest(getgenv().player_tycoon.UltimaPad.CashRegister2.Ching, player.Character.UpperTorso, 0)

                end

            end)

        end
        
        if Value > 0 then
            
            firetouchinterest(getgenv().player_tycoon.CashRegister.Ching, player.Character.UpperTorso, 1)
            firetouchinterest(getgenv().player_tycoon.CashRegister.Ching, player.Character.UpperTorso, 0)
            
        end
        
    end)
    
    return connection1, connection2
    
end

local function autoBuy()
    
    repeat
        
        -- try to locate tycoon
        getgenv().player_tycoon = getTycoonOwned()
        task.wait(1)
        
    until getgenv().player_tycoon
    
    
    local connection = player.leaderstats.Cash.Changed:Connect(function(Value)
        
        for i, v in pairs(getgenv().player_tycoon:GetChildren()) do
            
            if v and v:FindFirstChild("Touch") and v:IsA("Model") and v.Touch:FindFirstChild("Cost") and v.Touch.Cost.Value <= Value then
            
                firetouchinterest(v.Touch, player.Character.RightFoot, 1)
                firetouchinterest(v.Touch, player.Character.RightFoot, 0)
                
            elseif v.Name == "UpStairs" then
                
                for b, c in pairs(v:GetChildren()) do
                    
                    if c and c:FindFirstChild("Touch") and c:IsA("Model") and c.Touch:FindFirstChild("Cost") and c.Touch.Cost.Value <= Value then
            
                        firetouchinterest(c.Touch, player.Character.RightFoot, 1)
                        firetouchinterest(c.Touch, player.Character.RightFoot, 0)
                        
                    end
                    
                end
            
            end
            
        end
        
    end)
    
    return connection
    
end

local function spoofEssentials()
    
    local gmt = getrawmetatable(game)
    setreadonly(gmt, false)
    
    local oldindex = gmt.__index
    gmt.__index = newcclosure(function(self,b)
    
        if b == "WalkSpeed" then
        
            return 16
    
        end
        if b == "JumpPower" then

            return 50

        end
    
        return oldindex(self,b)
    
    end)
    
end

local function disableLasers()

    if not getgenv().player_tycoon then

        getgenv().player_tycoon = getTycoonOwned()
        return

    end

    for i, v in pairs(game.Workspace.Tycoons:GetChildren()) do

        if v and v ~= getgenv().player_tycoon then

            v.Door.ActDoor:Destroy()

        end

    end

end

local function claimAllWeapons()
    
    for i, v in pairs(game.Workspace.Tycoons:GetChildren()) do
        
        for b, c in pairs(v:GetChildren()) do
            
            local name = c.Name
            local new, removed = name:gsub(".?$","")

            if c and c:IsA("Model") and ("GearGiver" == new) then

                print("weapoon ulala")
                
                if c:FindFirstChild("Neon") then

                    firetouchinterest(c.Neon, player.Character.UpperTorso, 1)
                    firetouchinterest(c.Neon, player.Character.UpperTorso, 0)

                else

                    firetouchinterest(c.Touch, player.Character.UpperTorso, 1)
                    firetouchinterest(c.Touch, player.Character.UpperTorso, 0)

                end
                
            end
        
        end
        
    end
    
end

local function firePlayer(targetDropdw)

    claimAllWeapons()

    for i, v in pairs(player.Backpack:GetChildren()) do

        if v:IsA("Tool") and v:FindFirstChild("RemoteEvent") then

            player.Character.Humanoid:EquipTool(v)
            v.RemoteEvent:FireServer(game.Players:FindFirstChild(targetDropdw).Character.HumanoidRootPart.Position)

            task.wait(.1)

        end

    end

end

local function updatePlayerList(targetDropdw)

    local list = {}

    for i, v in pairs(game.Players:GetPlayers()) do

        table.insert(list, v.Name)

    end

    targetDropdw:Refresh(list)

end

getgenv().player_tycoon = nil
getgenv().auto_collect = false

getgenv().playersInServer = {}
getgenv().auto_buy = false

getgenv().Aimbot = false

local TycoonTab = Window:AddTab("Tycoon")
local PlayerTab = Window:AddTab("Player")
local WeaponTab = Window:AddTab("Weapons")

local connection1
local connection12
TycoonTab:AddSwitch("auto collect", function(state)
    
    if state then
        
        getgenv().auto_collect = true
        connection1, connection12 = autoCollect()
        
    else
        
        getgenv().auto_collect = false
        connection1:Disconnect()

        if connection12 then

            connection12:Disconnect()

        end
        
    end
    
end)

local connection2
TycoonTab:AddSwitch("auto buy", function(state)
    
    if state then
        
        getgenv().auto_buy = true
        connection2 = autoBuy()
        
    else
        
        getgenv().auto_buy = false
        connection2:Disconnect()
        
    end
    
end)

spoofEssentials()
PlayerTab:AddTextBox("WalkSpeed", function(s)
    player.Character.Humanoid.WalkSpeed = s
end)
PlayerTab:AddTextBox("JumpPower", function(s)
    player.Character.Humanoid.JumpPower = s
end)

TycoonTab:AddButton("Disable all lasers", function()
    disableLasers()
end)

TycoonTab:AddSwitch("Aimbot", function(state)
getgenv().Aimbot = state
end)

local Players = game:GetService("Players")
local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")

while true do
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for i, player in pairs(Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local distance = (player.Character.HumanoidRootPart.Position - humanoid.RootPart.Position).magnitude
            
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    
    if closestPlayer then
    if getgenv().Aimbot == true then
        firePlayer(closestPlayer)
        end
    end
    
    wait()
end

WeaponTab:AddButton("Claim all weapons", function()
    claimAllWeapons()
end)
