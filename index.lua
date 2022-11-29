assert(Drawing, "Exploit not supported!")

if getgenv().NXIsInjected == true then 
    game:GetService("CoreGui").ScreenGui:Destroy()
else
    getgenv().NXIsInjected = true
end

local player, lib = game.Players.LocalPlayer, loadstring(game:HttpGet("https://pastebin.com/raw/JsdM2jiP", true))()
lib.options.underlinecolor = "rainbow"

local Util = lib:CreateWindow("Utility")
local SBaby = lib:CreateWindow("Baby-Stuff")
local SNanny = lib:CreateWindow("Nanny-Stuff")
local Settings = lib:CreateWindow("Settings")


local babys = {"YourAvatar", "CowBoy", "Astronaut", "Cyborg", "Gothic", "Pirate", "Monke", "Knight", "Angel", "Samurai", "Neko", "Priest", "Doctor", "Baby Teddy", "Fairy", "Webman", "Nardo"}
local nannys = {"Nurse", "Butcher", "Student", "Nun", "Jason", "Werewolf", "Royal Vampire 1", "Royal Vampire 2"}
local meeles = {"Pulse Bottle", "Pink Bubbly Bottle", "Shiny Bottle", "Teddy Bear", "Cute Bear", "Shiny Bear", "Pacifier", "Toxic Pacifier", "Cute Pacifier", "Shiny Pacifier", "Dark Bottle", "Dark Pacifier", "Dark Bear"}


local myBaby, myNanny, myMeele, myFace = player.SkinSave.CurrentSkin.Value, player.SkinSave.CurrentNannySkin.Value, player.SkinSave.CurrentMeleeSkin.Value, player.SkinSave.CurrentFaceSkin.Value

local LibUtil = {}
local MyUtil = {}


local plrs = {}

for i, v in pairs(game.Players:GetChildren()) do
    if v and v ~= player then
        table.insert(plrs, v.Name)
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    table.insert(plrs, plr.Name)
end)
game.Players.PlayerRemoving:Connect(function(plr)
    for i, v in pairs(plrs) do
        if v == plr.Name then
            table.remove(plrs, i)
        end
    end
end)

-- [[   Baby Section    ]]
SBaby:Section("- Cosmetics -")
SBaby:Dropdown('BabySkin', {location = LibUtil, flag = 'Skin', list = babys}, function(s)
    warn("[Nanny-X] Baby Skin: "..s)
    MyUtil["BabySkin"] = s
end)
SBaby:Dropdown('MeleeSkin', {location = LibUtil, flag = 'Melee', list = meeles}, function(m)
    warn("[Nanny-X] Melee Skin: "..m)
    MyUtil["MeeleSkin"] = m
end)
SBaby:Button('Apply', function()
    local BabyCosmetic = MyUtil["BabySkin"] or "Default Blue"

    local args1 = {
        [1] = BabyCosmetic,
        [2] = "Baby",
        [3] = "Color1"
    }
    game:GetService("ReplicatedStorage").Equip:FireServer(unpack(args1))

    local MeeleCosmetic = MyUtil["MeeleSkin"] or "Default"

    local args2 = {
        [1] = MeeleCosmetic,
        [2] = "Melee"
    }
    game:GetService("ReplicatedStorage").Equip:FireServer(unpack(args2))

    warn("[Nanny-X] Cosmetic have been applied!")
end)
SBaby:Section("- Combat -")
MyUtil["InfScream"] = false
SBaby:Toggle("InfScream", {location = LibUtil, default = false, flag = "UseInfScream"}, function(s)
    MyUtil["InfScream"] = s
    local state = s == true and "On" or "Off"
    warn("[Nanny-X] InfScreaming is now: "..state.."!")
end)
SBaby:Bind('Scream', {kbonly = true, location = LibUtil, flag = "ScreamBind", default = Enum.KeyCode.X}, function()
    if MyUtil["InfScream"] == true then 
        game:GetService("ReplicatedStorage").ScreamWork:FireServer() 
    else 
        warn("[Nanny-X] InfScream is not enabled! [Buffer: NoScreams (Code: 3)]")
    end
end)
SBaby:Section("- Bypassing -")
SBaby:Button('Remove Doors', function()
    if #game.Workspace.CurrentMap:GetChildren() > 0 then
        for _, map in pairs(game.Workspace.CurrentMap:GetChildren()) do
            if map:FindFirstChild("Doors") then
                c = 0
                for i, door in pairs(map.Doors:GetChildren()) do
                    if door then door:Destroy() c = c + 1 end
                end
                warn("[Nanny-X] "..tostring(c).." Doors were deleted!")
            end
        end
    else
        warn("[Nanny-X] No Doors were destroyed!")
    end
end)
MyUtil["AntiTraps"] = false
SBaby:Toggle('Anti Traps', {location = LibUtil, default = false, flag = "NoTraps"}, function(s)
    MyUtil["AntiTraps"] = s
    local state = s == true and "On" or "Off"
    warn("[Nanny-X] AntiTraps is now: "..state.."!")
end)
MyUtil["AntiVentBlock"] = false
SBaby:Toggle('Anti Ventblock', {location = LibUtil, default = false, flag = "AntiVentBlockLib"}, function(s)
    MyUtil["AntiVentBlock"] = s
    local state = s == true and "On" or "Off"
    warn("[Nanny-X] AntiVentBlock is now: "..state.."!")
end)

-- [[   Nanny Section    ]]
SNanny:Section("- Cosmetics -")
SNanny:Dropdown('NannySkin', {location = LibUtil, flag = 'NannySkin', list = nannys}, function(s)
    warn("[Nanny-X] Nanny Skin: "..s)
    MyUtil["NannySkin"] = s
end)
SNanny:Button('Apply', function()
    local NannyCosmetic = MyUtil["NannySkin"] or "Default Blue"

    local args = {
        [1] = NannyCosmetic,
        [2] = "Nanny"
    }
    game:GetService("ReplicatedStorage").Equip:FireServer(unpack(args))

    warn("[Nanny-X] Cosmetic have been applied!")
end)
SNanny:Section("- Combat -")
SNanny:Button('Capture Babys', function()
    local oldc = player.Character.HumanoidRootPart.CFrame
    for i, plr in pairs(game.Players:GetChildren()) do
        if plr:FindFirstChild("InGame") then
            local captured = false
            while captured == false do
                player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                
                if not plr:FindFirstChild("InGame") then
                    captured = true
                end

                wait(0.01)
            end
        end
    end
    player.Character.HumanoidRootPart.CFrame = oldc
end)
SNanny:Bind('KeyBind', {kbonly = true, location = LibUtil, flag = "CaptureAllBind", default = Enum.KeyCode.C}, function()
    local oldc = player.Character.HumanoidRootPart.CFrame
    for i, plr in pairs(game.Players:GetChildren()) do
        if plr:FindFirstChild("InGame") then
            local captured = false
            while captured == false do
                player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                
                if not plr:FindFirstChild("InGame") then
                    captured = true
                end

                wait(0.01)
            end
        end
    end
    player.Character.HumanoidRootPart.CFrame = oldc
end)
SNanny:Section("- Bypassing -")
MyUtil["NannyToolsCooldown"] = false
SNanny:Toggle('Remove Tool-Cooldown', {location = LibUtil, default = false, flag = "NoCoolDownNanny"}, function(s)
    MyUtil["NannyToolsCooldown"] = s
    local state = s == true and "On" or "Off"
    warn("[Nanny-X] NannyToolsCooldown is now: "..state.."!")
end)



-- [[   Util Section    ]]
Util:Section("- Server -")
Util:Button('Crash Server', function()
    warn("[Nanny-X] Crashing Server!")
    count = 0
    crashed = false
    while crashed ~= true do
        if count >= 20 then crashed = true end
        for i = 1, 400 do
            for i = 1, 30 do
                game:GetService("ReplicatedStorage").ScreamWork:FireServer()
            end
        end
        count = count + 1
    end
end)
Util:Section("- Client -")
Util:Dropdown('Player', {location = Settings , flag = 'Target' , list = plrs}, function(p)
    if game.Players:FindFirstChild(p) then 
        MyUtil["PlayerTP"] = game.Players:FindFirstChild(p)
    end
    warn("[Nanny-X] PlayersTP player: "..MyUtil["PlayerTP"].Name)
end)
Util:Button('Teleport to Player', function()
    if MyUtil["PlayerTP"] ~= nil  then
        local hr = player.Character.HumanoidRootPart
        local suc, err = pcall(function()
            hr.CFrame = MyUtil["PlayerTP"].Character.HumanoidRootPart.CFrame
        end)
    end
end)
Util:Section("- ESP -")
MyUtil["ChamTrans"] = 0.5
Util:Slider('Transparency', {location = LibUtil, flag = 'ESPTransparency', default = 0.5, precise = true}, function(t)
    MyUtil["ChamTrans"] = t
    warn("[Nanny-X] ESP Transparency is now: "..tostring(t))
end)
MyUtil["NannyESP"] = false
Util:Toggle('Nanny ESP', {location = LibUtil, default = false, flag = "NannyESP"}, function(s)
    MyUtil["NannyESP"] = s
    local state = s == true and "On" or "Off"
    warn("[Nanny-X] NannyESP is now: "..state.."!")

    if s == false then
        if #game.Workspace.CurrentMap:GetChildren() > 0 then
            if MyUtil["CurrentNanny"] ~= nil and MyUtil["CurrentNanny"] ~= "" then
                for _, k in pairs(MyUtil["CurrentNanny"].Character:GetChildren()) do
                    if k:FindFirstChild("Cham") then
                        k:FindFirstChild("Cham"):Destroy()
                    end
                end
            end
        end
    end
end)
MyUtil["BabyESP"] = false
Util:Toggle('Baby ESP', {location = LibUtil, default = false, flag = "BabyESP"}, function(s)
    MyUtil["BabyESP"] = s
    local state = s == true and "On" or "Off"
    warn("[Nanny-X] BabyESP is now: "..state.."!")

    if s == false then
        if #game.Workspace.CurrentMap:GetChildren() > 0 then
            for _, k in pairs(game.Players:GetChildren()) do
                if k:FindFirstChild("InGame") then
                    for i, p in pairs(k.Character:GetChildren()) do
                        if p:FindFirstChild("Cham") then
                            p:FindFirstChild("Cham"):Destroy()
                        end
                    end
                end
            end
        end
    end
end)
MyUtil["ItemsESP"] = false
Util:Toggle('Items ESP', {location = LibUtil, default = false, flag = "ItemESP"}, function(s)
    MyUtil["ItemsESP"] = s
    local state = s == true and "On" or "Off"
    warn("[Nanny-X] ItemsESP is now: "..state.."!")

    if s == false then
        if #game.Workspace.CurrentMap:GetChildren() > 0 then
            for _, k in pairs(game.Workspace.CurrentMap:GetChildren()) do
                if k:FindFirstChild("Main Key")["Cham"] then
                    k:FindFirstChild("Main Key"):FindFirstChild("Cham"):Destroy()
                end
                if k:FindFirstChild("Main Key"):FindFirstChild("NameEsp") then
                    k:FindFirstChild("Main Key"):FindFirstChild("NameEsp"):Destroy()
                end
                local items = k.Randomizer.items:GetChildren() or {}
                for i, item in pairs(items) do
                    if item:FindFirstChild("Cham") then
                        item:FindFirstChild("Cham"):Destroy()
                    end 
                    if item:FindFirstChild("NameEsp") then
                        item:FindFirstChild("NameEsp"):Destroy()
                    end
                end
            end
        end
    end
end)



-- [[   Settings Section    ]]
Settings:Section("- KeyBinds -")
Settings:Bind("Toggle GUI", {kbonly = true, location = LibUtil, flag = "GUIToggle", default = Enum.KeyCode.RightShift}, function()
    local gui = game:GetService("CoreGui").ScreenGui or ""
    if gui ~= "" then gui.Enabled = not gui.Enabled end
end)



local hasElapsed = 0
-- [[   Loop Section    ]]
game:GetService("RunService").RenderStepped:Connect(function()
    if #game.Workspace.CurrentMap:GetChildren() > 0 then
        for i, plr in pairs(game.Players:GetChildren()) do
            if plr and plr:FindFirstChild("Boss") then
                MyUtil["CurrentNanny"] = plr
            end

            if plr and plr.Character then
                for _, obj in pairs(plr.Character:GetChildren()) do
                    if obj:FindFirstChild("Cham") and plr ~= MyUtil["CurrentNanny"] then
                        obj:FindFirstChild("Cham")
                    end
                end
            end
        end

        if MyUtil["NannyToolsCooldown"] == true then
            if MyUtil["CurrentNanny"] == player then
                if #player.Backpack:GetChildren() > 0 then
                    for i, obj in pairs(player.Backpack:GetChildren()) do
                        if obj and obj.Name ~= "Trap" then
                            obj:FindFirstChild("LocalScript").Disabled = false
                        end
                    end
                else
                    for i, obj in pairs(player.Character:GetChildren()) do
                        if obj and obj.Name ~= "Trap" and obj:IsA("Tool") and obj:FindFirstChild("LocalScript") then
                            obj:FindFirstChild("LocalScript").Disabled = false
                        end
                    end
                end
            end
        end
        
        if MyUtil["BabyESP"] == true then
            for _, k in pairs(game.Players:GetChildren()) do
                if k:FindFirstChild("InGame") then
                    for i, p in pairs(k.Character:GetChildren()) do
                        if p:FindFirstChild("Cham") then
                            p:FindFirstChild("Cham"):Destroy()
                        end
                    end
                end
            end

            for _, p in pairs(game.Players:GetChildren()) do
                if p:FindFirstChild("InGame") then
                    for i, k in pairs(p.Character:GetChildren()) do
                        if k:IsA 'BasePart' and not k:FindFirstChild 'Cham' then
                            local cham = Instance.new('BoxHandleAdornment', k)
                            cham.ZIndex = 10
                            cham.Adornee = k
                            cham.AlwaysOnTop = true
                            cham.Size = k.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(0, 1, 0)
                            cham.Name = 'Cham'
                        end
                    end
                end
            end
        end
        if MyUtil["NannyESP"] == true then
            if MyUtil["CurrentNanny"] ~= nil and MyUtil["CurrentNanny"] ~= "" and MyUtil["CurrentNanny"] ~= player and MyUtil["CurrentNanny"].Character ~= nil then
                for _, k in pairs(MyUtil["CurrentNanny"].Character:GetChildren()) do
                    if k:FindFirstChild("Cham") then
                        k:FindFirstChild("Cham"):Destroy()
                    end
                end
            end

            if MyUtil["CurrentNanny"] ~= player and MyUtil["CurrentNanny"] ~= nil and MyUtil["CurrentNanny"] ~= "" then
                for _, k in pairs(MyUtil["CurrentNanny"].Character:GetChildren()) do
                    if k:IsA 'BasePart' and not k:FindFirstChild 'Cham' then
                        local cham = Instance.new('BoxHandleAdornment', k)
                        cham.ZIndex = 10
                        cham.Adornee = k
                        cham.AlwaysOnTop = true
                        cham.Size = k.Size
                        cham.Transparency = MyUtil["ChamTrans"] or 0.5
                        cham.Color3 = Color3.new(1, 0, 0)
                        cham.Name = 'Cham'
                    end
                end
            end
        end
        
        local function round(n)
            return math.floor(tonumber(n) + 0.5)
        end

        if MyUtil["ItemsESP"] == true then
            for _, k in pairs(game.Workspace.CurrentMap:GetChildren()) do
                for i, part in pairs(k:GetChildren()) do
                    if part.Name == "Main Key" then
                        local item = k["Main Key"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "Coffee" then
                        local item = k["Coffee"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "Cross" then
                        local item = k["Cross"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "Battery" then
                        local item = k["Battery"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "RoboLeg" then
                        local item = k["RoboLeg"].Handle
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "Main KeyCard" then
                        local item = k["Main KeyCard"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "Crowbar" then
                        local item = k["Crowbar"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "Red KeyCard" then
                        local item = k["Red KeyCard"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    elseif part.Name == "Blue KeyCard" then
                        local item = k["Blue KeyCard"]
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    end
                end

                if k:FindFirstChild("Randomizer") then
                    local items = k.Randomizer.items:GetChildren() or {}
                    for i, item in pairs(items) do
                        if item:FindFirstChild("NameEsp") then
                            item:FindFirstChild("NameEsp"):FindFirstChild("TextLabel").Text = (item.Name ..' ' ..round((game:GetService('Players').LocalPlayer.Character.Head.Position -item.Position).Magnitude / 3) .. 'm')
                        end
                        if not item:FindFirstChild("Cham") then
                            local cham = Instance.new('BoxHandleAdornment', item)
                            cham.ZIndex = 10
                            cham.Adornee = item
                            cham.AlwaysOnTop = true
                            cham.Size = item.Size
                            cham.Transparency = MyUtil["ChamTrans"] or 0.5
                            cham.Color3 = Color3.new(69, 69, 69)
                            cham.Name = 'Cham'

                            local bill = Instance.new('BillboardGui', item)
                            bill.Name = 'NameEsp'
                            bill.Size = UDim2.new(1, 200, 1, 30)
                            bill.Adornee = item
                            bill.AlwaysOnTop = true
                            local name = Instance.new('TextLabel', bill)
                            name.TextWrapped = true
                            name.Text = (
                                item.Name ..
                                    ' ' ..
                                    round((
                                        game:GetService('Players').LocalPlayer.Character.Head.Position -
                                            item.Position).Magnitude / 3) .. 'm')
                            name.Size = UDim2.new(1, 0, 1, 0)
                            name.TextYAlignment = 'Top'
                            name.TextColor3 = Color3.new(1, 1, 1)
                            name.BackgroundTransparency = 1
                        end
                    end
                else
                    repeat wait(0.1) until k:FindFirstChild("Randomizer") ~= nil
                    wait(0.1)
                end
            end
        end

        if MyUtil["AntiTraps"] == true then
            for _, k in pairs(game.Workspace.CurrentMap:GetChildren()) do
                if k then
                    if k:FindFirstChild("ClownBox") and MyUtil["CurrentNanny"] ~= player then
                        local suc, err = pcall(function()
                            k:FindFirstChild("ClownBox"):Destroy()
                        end)
                    end
                end
            end
        end

        if MyUtil["AntiVentBlock"] == true then
            for _, k in pairs(game.Workspace.CurrentMap:GetChildren()) do
                if k then
                    if k:FindFirstChild("VentSystems") then
                        local suc, err = pcall(function()
                            for i, vent in pairs(k:FindFirstChild("VentSystems"):GetChildren()) do 
                                if vent:FindFirstChild("VentBlock1") and vent:FindFirstChild("VentBlock2") then
                                    vent:FindFirstChild("VentBlock1"):Destroy()
                                    vent:FindFirstChild("VentBlock2"):Destroy()
                                end
                            end
                        end)
                    end
                end
            end
        end
    else
        for i, p in pairs(game.Players:GetChildren()) do
            if p ~= player then
                if p.Character then
                    for i, obj in pairs(p.Character:GetChildren()) do
                        if obj:FindFirstChild("Cham") then
                            obj:FindFirstChild("Cham"):Destroy()
                        end
                    end
                end
            end
        end
    end
end)

