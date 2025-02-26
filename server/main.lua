RegisterNetEvent('sk-wapenrepair:repair', function(weaponName, prijs)
    local xPlayer = ESX.GetPlayerFromId(source)
    local zwartGeld = xPlayer.getAccount('black_money').money 

    if zwartGeld >= prijs then
        local inventory = exports.ox_inventory:Search(source, 'slots', string.upper(weaponName))

        if inventory and #inventory > 0 then
            local slot = inventory[1].slot 

            xPlayer.removeAccountMoney('black_money', prijs)

            exports.ox_inventory:SetMetadata(source, slot, { durability = 100 })

            sendToDiscord(SK.Logs, "SK-logs", "**Naam**: " .. GetPlayerName(source) .. "\n **ID**: " ..source .. "\n **License**: " .. xPlayer.getIdentifier() .. "\n**Wapen** " .. weaponName .."\n**Prijs:** €" .. prijs .."", 246504)

            TriggerClientEvent('ox_lib:notify', source, { type = 'success', title = 'Succes', description = 'Je wapen is gerepareerd!' })
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Fout', description = 'Je hebt dit wapen niet.' })
        end
    else
        TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Fout', description = 'Je hebt niet genoeg zwart geld!' })
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