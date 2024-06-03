local ox_target = exports.ox_target
local QBCore = exports['qb-core']:GetCoreObject()

local tableModel = 'v_ret_ml_tableb'
local tableCoords = vector3(941.98, -123.13, 74.42)

CreateThread(function()
    RequestModel(tableModel)
    while not HasModelLoaded(tableModel) do
        Wait(0)
    end

    local tableEntity = CreateObject(tableModel, tableCoords.x, tableCoords.y, tableCoords.z, false, false, false)
    SetEntityHeading(tableEntity, 0.0)
    FreezeEntityPosition(tableEntity, true)

    -- Add the target options to the table
    ox_target:addLocalEntity(tableEntity, {
        {
            icon = "fa-solid fa-bottle",
            label = "Make Lean",
            onSelect = function()
                QBCore.Functions.Progressbar("creating_lean", "Mixing Ingredients", 5000, false, true, {
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
end)
