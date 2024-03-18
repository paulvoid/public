repeat wait()
until game:FindFirstChild("CoreGui")
        and game.Players.LocalPlayer

repeat wait(.25)
until game:IsLoaded()
        and game.Players.LocalPlayer.Character


local plr = game:GetService('Players').LocalPlayer
if game.GameId ~= 994732206 then
    warn('day k phai la blocc trai cay')
    return
end

repeat wait()
until plr:FindFirstChild("Backpack")
        and plr:FindFirstChild("DataLoaded")

repeat wait(1) until game:GetService('Players').LocalPlayer.Character
repeat wait(1) until game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
repeat wait(1) until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('Main')

pcall(function()
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('Main'):FindFirstChild('ChooseTeam').Visible then
        for i, v in next, getconnections(game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('Main').ChooseTeam.Container['Pirates'].Frame.TextButton.Activated) do
            v:Function()
        end
    end
end)

local UGS = UserSettings():GetService'UserGameSettings'
local InputService = game:GetService'UserInputService'
local RunService = game:GetService("RunService")
local OldVolume = UGS.MasterVolume
function performance()
    if _PERF then return end

    _PERF = true
    _TARGETFPS = 8

    if Message and tonumber(Message) then
        _TARGETFPS = tonumber(Message)
    end

    local OldLevel = settings().Rendering.QualityLevel

    RunService:Set3dRenderingEnabled(false)
    settings().Rendering.QualityLevel = 1

    InputService.WindowFocused:Connect(function()
        RunService:Set3dRenderingEnabled(false)
        settings().Rendering.QualityLevel = 1
        setfpscap(_TARGETFPS)
    end)

    InputService.WindowFocusReleased:Connect(function()
        OldLevel = settings().Rendering.QualityLevel

        RunService:Set3dRenderingEnabled(false)
        settings().Rendering.QualityLevel = 1
        setfpscap(_TARGETFPS)
    end)

    setfpscap(_TARGETFPS)
end

function mute()
    if (UGS.MasterVolume - OldVolume) > 0.01 then
        OldVolume = UGS.MasterVolume
    end

    UGS.MasterVolume = 0
end

-- getgenv().PVSetting.JoinLowServer set default is true if not set
-- check if PVSetting or Setting is not exist
if not getgenv().PVSetting then
    getgenv().PVSetting = {}
end

if not getgenv().Setting then
    getgenv().Setting = {}
end
performance()
mute()
local key = getgenv().PVSetting.key or getgenv().Setting.key
local note = getgenv().PVSetting.note or getgenv().Setting.note
local delay = getgenv().PVSetting.DelayUpdate or getgenv().Setting.DelayUpdate
pcall(function()
    while true do
        pcall(function()
            -- * Table
            local pvData = {}
            pvData['key'] = key
            pvData['robloxUser'] = game:GetService('Players').LocalPlayer.Name
            pvData['note'] = note
            pvData['content'] = {}
            pvData['content']['Fighting Style'] = {}
            pvData['content']['Data'] = {}
            pvData['content']['Inventory'] = {}
            pvData['content']['Inventory']['Sword'] = {}
            pvData['content']['Inventory']['Wear'] = {}
            pvData['content']['Inventory']['Gun'] = {}
            pvData['content']['Inventory']['Blox Fruit'] = {}
            pvData['content']['Inventory']['Material'] = {}
            pvData['content']['Awakened Abilities'] = {}
            dataFind = { 'Level', 'Beli', 'Fragments', 'DevilFruit' }
            meleeList = {
                { 'Superhuman', 'BuySuperhuman' },
                { 'Death Step', 'BuyDeathStep' },
                { 'Sharkman Karate', 'BuySharkmanKarate' },
                { 'Electric Claw', 'BuyElectricClaw' },
                { 'Dragon Talon', 'BuyDragonTalon' },
                { 'Godhuman', 'BuyGodhuman' }
            }

            -- ? Variable

            local CommF = game.ReplicatedStorage.Remotes.CommF_

            local race = " V1"

            if game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack({[1] = "Alchemist",[2] = "1"})) == -2 then
                race = " V2"

            end
            if game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack({[1] = "Wenlocktoad",[2] = "1"})) == -2 then
                race = " V3"

            end
            if plr.Backpack:FindFirstChild("Awakening") or plr.Character:FindFirstChild("Awakening") then
                race = " V4"
            end




            -- ! function

            getData = function(data)
                return CommF:InvokeServer(data)
            end

-- Thêm hàm mới để lấy thông tin từ người chơi ----------------------------------------------

local function isDevilFruitMasteryFull(devilFruitName, devilFruitMastery, masteryRequirements)
    -- Kiểm tra xem DevilFruitMastery có đạt mức full hay không
    local highestRequirement = 0
    for _, value in pairs(masteryRequirements) do
        if value > highestRequirement then
            highestRequirement = value
        end
    end

    print("Highest Requirement for Devil Fruit Main (" .. devilFruitName .. ") is", highestRequirement)

    return devilFruitMastery >= highestRequirement
end

local function getDataFromPlayer(player)
    local data = {}

    -- Lặp qua dữ liệu của người chơi
    for i, v in next, player:FindFirstChild('Data'):GetChildren() do
        if dataFind and table.find(dataFind, v.Name) then
            data[v.Name] = v.Value
        end
    end

    -- Lấy dữ liệu Devil Fruit từ hàm getData
    local devilFruitData = getData('getInventory') -- Thay thế 'getInventory' bằng hàm thực tế của bạn

    -- Kiểm tra xem có Devil Fruit không
    if devilFruitData then
        -- Tìm Devil Fruit theo tên
        local devilFruitMastery = nil
        local devilFruitInfo = nil
        for _, fruit in pairs(devilFruitData) do
            if fruit.Type == 'Blox Fruit' and fruit.Name == data['DevilFruit'] then
                devilFruitMastery = fruit.Mastery
                devilFruitInfo = fruit
                break
            end
        end

        if devilFruitMastery then
            data['MasteryDevilFruitMain'] = devilFruitMastery

            -- Kiểm tra và gán giá trị FullMasteryDevilFruitMain
            local isFull = isDevilFruitMasteryFull(data['DevilFruit'], devilFruitMastery, devilFruitInfo.MasteryRequirements)
            data['FullMasteryDevilFruitMain'] = isFull and "FullMastery" or "false-FullMastery"
        else
            data['MasteryDevilFruitMain'] = "false-NeedAwk"
            data['FullMasteryDevilFruitMain'] = "false-NeedAwk"
        end
    else
        data['MasteryDevilFruitMain'] = "false-DevilFruit"  -- Hoặc giá trị mặc định nếu không có Devil Fruit
        data['FullMasteryDevilFruitMain'] = "false-DevilFruit"
    end

    data['Race'] = player.Data.Race.Value .. race

    -- Kiểm tra và gán giá trị cho 'V4Tiers'
    if race == " V4" then
        data['V4Tiers'] = game.Players.LocalPlayer.Data.Race.C.Value
    else
        data['V4Tiers'] = 0
    end
    
    -- Kiểm tra và gán giá trị cho 'FullAWK'
    local awakenedAbilities = getData('getAwakenedAbilities')
    local isFullAwakened = "FullAwakened"
    for _, ability in pairs(awakenedAbilities) do
        if not ability.Awakened then
            isFullAwakened = "false-FullAwakened"
            break
        end
    end
    data['FullAWK'] = isFullAwakened

    return data
end

--------------------------------------------------------------------------------------------

            -- * Data
            pcall(function()
                for i, v in next, plr:FindFirstChild('Data'):GetChildren() do
                    if table.find(dataFind, v.Name) then
                        if string.find(v.Value, '-') then
                            pvData['content']['Data'][v.Name] = v.Value:gsub("-(.*)", "")
                        else
                            pvData['content']['Data'][v.Name] = v.Value
                        end
                    end
                end
                
                local additionalData = getDataFromPlayer(plr)

                pvData['content']['Data']['V4Tiers'] = additionalData['V4Tiers'] or "default_value_for_V4Tiers"
                pvData['content']['Data']['MasteryDevilFruitMain'] = additionalData['MasteryDevilFruitMain'] or "default_value_for_MasteryDevilFruitMain"
                pvData['content']['Data']['FullMasteryDevilFruitMain'] = additionalData['FullMasteryDevilFruitMain'] or "default_value_for_FullMasteryDevilFruitMain"
                pvData['content']['Data']['FullAWK'] = additionalData['FullAWK'] or "default_value_for_FullAWK"
                pvData['content']['Data']['Bounty'] = game.Players.LocalPlayer.leaderstats:FindFirstChild('Bounty/Honor').Value
                pvData['content']['Data']['Race'] = game.Players.LocalPlayer.Data.Race.Value..race
                warn('data')
            end)




            -- * Melee
            pcall(function()
                for i, v in next, meleeList do
                    if CommF:InvokeServer(v[2], true) == 1 then
                        table.insert(pvData['content']['Fighting Style'], v[1])
                    end
                end
                warn('melee')
            end)
            pcall(function()
                if #pvData['content']['Fighting Style'] < 1 then
                    pvData['content']['Fighting Style'] = { 'Fighting Style Data Not Found' }
                end
            end)

            -- * Fruit
            --[[
            for i,v in pairs(getdata('getInventoryFruits')) do
                table.insert(dot['Fruit'],tostring(v.Name:gsub("-(.*)","")))
            end
            ]]


            -- * Inventory
            pcall(function()
                for i, v in pairs(getData('getInventory')) do
                    if v.Type == 'Blox Fruit' then
                        table.insert(pvData['content']['Inventory'][v.Type], tostring(v.Name:gsub("-(.*)", "")))
                    elseif v.Type == 'Material' then
                        -- Type, Name , Count add V.Name = Count to table
                        pvData['content']['Inventory'][v.Type][v.Name] = v.Count
                    else
                        table.insert(pvData['content']['Inventory'][v.Type], tostring(v.Name:gsub("'", "")))
                    end
                end
                warn('inventory')
            end)

            -- * Current Server

            pcall(function()
                pvData['content']['Current Server'] = {
                    ['Place Name'] = game.PlaceId == 2753915549 and 'First Sea' or game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
                }
                warn('server')
            end)

            -- * Awaken

            local isAwaken = false

            pcall(function()
                for i, v in pairs(getData('getAwakenedAbilities')) do
                    if v.Awakened then
                        table.insert(pvData['content']['Awakened Abilities'], i)
                    end
                    isAwaken = true
                end
                warn('awaken')
            end)

            pcall(function()
                if not isAwaken then
                    table.insert(pvData['content']['Awakened Abilities'], 'Awakened Abilities Data Not Found')
                end
            end)
            for i, v in next, pvData do
                print(i, v)
            end
            -- ! post
            local url = 'https://paulvoid.com/api/ram/update';
            local Request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

            -- jobid
            local jobid = game.JobId
            local enemies = game:GetService("Workspace").Enemies:GetChildren()
            -- get list of enemies
            local enemyList = {}
            for i, v in next, enemies do

                table.insert(enemyList, v.Name)
            end
            -- get placeid
            local placeid = game.PlaceId
            -- get players length
            local players = game:GetService("Players"):GetPlayers()
            local playersLength = #players

            -- world

            local responses = Request({
                Url = url,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode(pvData)
            }
            )

            --local responses1 = Request({
            --    Url = "https://paulvoid.com/api/script/serverInfo",
            --    Method = "POST",
            --    Headers = {
            --        ["Content-Type"] = "application/json"
            --    },
            --    Body = game:GetService("HttpService"):JSONEncode({
            --        ["jobID"] = jobid,
            --        ["placeID"] = placeid,
            --        ["boss"] = enemyList,
            --        ["slot"] = playersLength
            --    })
            --})
            print(responses.Body)
        end)
        task.wait(delay)
    end
end)
