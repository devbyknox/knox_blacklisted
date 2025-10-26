ESX = exports["es_extended"]:getSharedObject()

local Config = {}

RegisterNetEvent('knox_blacklisted:sendConfig')
AddEventHandler('knox_blacklisted:sendConfig', function(config)
    Config = config
end)

TriggerServerEvent('knox_blacklisted:requestConfig')

local function isObjectBlacklisted(model)
    for _, blacklistedModel in pairs(Config.ObjectList or {}) do
        if model == blacklistedModel then
            return true
        end
    end
    return false
end

local function isVehicleBlacklisted(model)
    for _, blacklistedModel in pairs(Config.VehicleList or {}) do
        if model == blacklistedModel then
            return true
        end
    end
    return false
end

local function isWeaponBlacklisted(weaponHash)
    for _, blacklistedWeapon in pairs(Config.WeaponList or {}) do
        if GetHashKey(blacklistedWeapon) == weaponHash then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if not Config.ObjectList or not Config.VehicleList then
            goto continue
        end
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        local objects = GetGamePool('CObject')
        for _, object in pairs(objects) do
            if DoesEntityExist(object) then
                local model = GetEntityModel(object)
                
                for _, blacklistedModel in pairs(Config.ObjectList) do
                    if model == GetHashKey(blacklistedModel) then
                        local coords = GetEntityCoords(object)
                        local distance = #(playerCoords - coords)
                        
                        if distance < 50.0 then
                            TriggerServerEvent('knox_blacklisted:detectedObject', blacklistedModel, coords)
                            DeleteEntity(object)
                        end
                        break
                    end
                end
            end
        end
        
        local vehicles = GetGamePool('CVehicle')
        for _, vehicle in pairs(vehicles) do
            if DoesEntityExist(vehicle) then
                local model = GetEntityModel(vehicle)
                
                for _, blacklistedModel in pairs(Config.VehicleList) do
                    if model == GetHashKey(blacklistedModel) then
                        local coords = GetEntityCoords(vehicle)
                        local distance = #(playerCoords - coords)
                        
                        if distance < 100.0 then
                            TriggerServerEvent('knox_blacklisted:detectedVehicle', blacklistedModel, coords)
                            DeleteEntity(vehicle)
                        end
                        break
                    end
                end
            end
        end
        
        ::continue::
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if not Config.WeaponList then
            goto continue
        end
        
        local playerPed = PlayerPedId()
        
        for _, weaponName in pairs(Config.WeaponList) do
            local weaponHash = GetHashKey(weaponName)
            if HasPedGotWeapon(playerPed, weaponHash, false) then
                TriggerServerEvent('knox_blacklisted:detectedWeapon', weaponName)
                RemoveWeaponFromPed(playerPed, weaponHash)
            end
        end
        
        ::continue::
    end
end)