RegisterNetEvent('sk-wapenrepair:geldcheck', function(weaponName, prijs)
    local xPlayer = ESX.GetPlayerFromId(source)
    local zwartGeld = xPlayer.getAccount(SK.Account).money 

    if zwartGeld >= prijs then
        TriggerClientEvent('sk-wapenrepair:startRepair', source, weaponName, prijs)
    else
        TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Fout', description = SK.Notify.Geld })
    end
end)

RegisterNetEvent('sk-wapenrepair:completeRepair', function(weaponName, prijs)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = exports.ox_inventory:Search(source, 'slots', string.upper(weaponName))

    if inventory and #inventory > 0 then
        local slot = inventory[1].slot 

        xPlayer.removeAccountMoney(SK.Account, prijs)
        exports.ox_inventory:SetMetadata(source, slot, { durability = 100 })

        sendToDiscord(SK.Logs, "SK-logs", "**Naam**: " .. GetPlayerName(source) .. "\n **ID**: " ..source .. "\n **License**: " .. xPlayer.getIdentifier() .. "\n**Wapen** " .. weaponName .."\n**Prijs:** €" .. prijs .."", 246504)

        TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Succes', description = SK.Notify.Wapenreparatie })
    else
        TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Fout', description = SK.Notify.Geenwapen })
    end
end)


function sendToDiscord(webhook, name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "".. name .."",
              ["description"] = message,
              ["footer"] = {
              ["text"] = "SK-logs • " ..os.date("%x %X %p"),
              },
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "SK-logs", embeds = connect}), { ['Content-Type'] = 'application/json' })
  end