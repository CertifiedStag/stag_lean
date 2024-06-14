print('stag_lean', 'Version 1.0', 'Loaded')
local ox_target = exports.ox_target
local QBCore = exports['qb-core']:GetCoreObject()

local tableModel = Config.TableProp
local tableCoords = Config.TableLoc

print(tableModel)
print(tableCoords)

Citizen.CreateThread(function()
    RequestModel(tableModel)
    while not HasModelLoaded(tableModel) do
        Citizen.Wait(0)
    end

    local tableEntity = CreateObject(tableModel, tableCoords.x, tableCoords.y, tableCoords.z, false, false, false)
    SetEntityHeading(tableEntity, Config.heading)
    FreezeEntityPosition(tableEntity, true)

    -- Add the target options to the table
    if Config.Target == 'ox' then return
    ox_target:addLocalEntity(tableEntity, {
        {
            icon = "fa-solid fa-bottle",
            label = "Make Lean",
            onSelect = function()
                QBCore.Functions.Progressbar("creating_lean", "Mixing Ingredients", Config.creationTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                 }, {
                    animDict = "amb@prop_human_parking_meter@male@base",
                    anim = "base",
                    flags = 49,
                 }, {}, {}, function()
                    TriggerServerEvent('stag_lean:server:MakeLean')
                 end, function()
                    TriggerEvent('QBCore:Notify', source, 'Cancelled...', 'error', 1000)
                 end)
                
            end,
        }
    })

elseif Config.Target == 'qb' then return
    exports['qb-target']:AddTargetEntity(tableEntity, {
        options = { 
          {
            num = 1,
            icon = 'fa-solid fa-bottle', 
            label = 'Make Lean', 
            targeticon = 'fas fa-example', 
            action = function(entity)
              if IsPedAPlayer(entity) then return false end
              QBCore.Functions.Progressbar("creating_lean", "Mixing Ingredients", Config.creationTime, false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
             }, {
                animDict = "amb@prop_human_parking_meter@male@base",
                anim = "base",
                flags = 49,
             }, {}, {}, function()
                TriggerServerEvent('stag_lean:server:MakeLean')
             end, function()
                TriggerEvent('QBCore:Notify', source, 'Cancelled...', 'error', 1000)
             end)
            end,
          },
        },
        distance = 2.5,
      })
    end
end)

local function ecstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina -= 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, false, false, false)
    end
end

exports('useLean', function(data, slot)
     exports.ox_inventory:useItem(data, function(data)
         if data then
            ecstasyEffect()
         end
    end)
end)
