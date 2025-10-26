ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('knox_blacklisted:requestConfig')
AddEventHandler('knox_blacklisted:requestConfig', function()
    local source = source
    TriggerClientEvent('knox_blacklisted:sendConfig', source, Config)
end)

local function sendWebhook(webhookUrl, data)
    if webhookUrl and webhookUrl ~= '' then
        PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode(data), {['Content-Type'] = 'application/json'})
    end
end

RegisterNetEvent('knox_blacklisted:detectedObject')
AddEventHandler('knox_blacklisted:detectedObject', function(modelName, coords)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local playerName = GetPlayerName(source)
        local playerIdentifier = xPlayer.getIdentifier()
        
        local webhookData = {
            embeds = {{
                title = "Blacklisted Object Detected",
                color = 16711680,
                fields = {
                    {
                        name = "Player",
                        value = playerName .. " (" .. playerIdentifier .. ")",
                        inline = true
                    },
                    {
                        name = "Object Model",
                        value = modelName,
                        inline = true
                    }
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        
        sendWebhook(Config.WebhookObject, webhookData)
    end
end)

RegisterNetEvent('knox_blacklisted:detectedVehicle')
AddEventHandler('knox_blacklisted:detectedVehicle', function(modelName, coords)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local playerName = GetPlayerName(source)
        local playerIdentifier = xPlayer.getIdentifier()
        
        local webhookData = {
            embeds = {{
                title = "Blacklisted Vehicle Detected",
                color = 16711680,
                fields = {
                    {
                        name = "Player",
                        value = playerName .. " (" .. playerIdentifier .. ")",
                        inline = true
                    },
                    {
                        name = "Vehicle Model",
                        value = modelName,
                        inline = true
                    }
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        
        sendWebhook(Config.WebhookVehicles, webhookData)
    end
end)

RegisterNetEvent('knox_blacklisted:detectedWeapon')
AddEventHandler('knox_blacklisted:detectedWeapon', function(weaponName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local playerName = GetPlayerName(source)
        local playerIdentifier = xPlayer.getIdentifier()
        
        local webhookData = {
            embeds = {{
                title = "Blacklisted Weapon Detected",
                color = 16711680,
                fields = {
                    {
                        name = "Player",
                        value = playerName .. " (" .. playerIdentifier .. ")",
                        inline = true
                    },
                    {
                        name = "Weapon",
                        value = weaponName,
                        inline = true
                    }
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        
        sendWebhook(Config.WebhookWeapons, webhookData)
    end
end)