local function openrepairmenu()
    local options = {}

    for _, wapen in ipairs(SK.Wapens) do
        local durability = wapenDurability(wapen.name)

        if durability and durability < 100 then 

            local prijs = math.floor((100 - durability) / 100 * SK.Prijs) 

            table.insert(options, {
                title = wapen.label .. " (" .. durability .. "%)",
                description = 'Reparatie kost: $' .. prijs .. ' zwart geld',
                icon = "fa-solid fa-wrench",
                onSelect = function()

                    TriggerEvent('dp:startEmote', 'mechanic')

                    lib.progressCircle({
                        duration = 20000, 
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            car = true,
                            move = true,
                        },
                    })

                    TriggerEvent('dp:cancelEmote')

                    TriggerServerEvent('sk-wapenrepair:repair', wapen.name, prijs) 
                end
            })
        end
    end

    if #options == 0 then
        lib.notify({
            title = 'Fout',
            description = 'Je hebt geen beschadigde wapens om te repareren.',
            type = 'error'
        })
        return
    end

    lib.registerContext({
        id = 'wapens-repareren',
        title = 'Wapen Repareren',
        menu = 'wapensrepair_main',
        options = options
    })

    lib.showContext('wapens-repareren')
end

function BuildManagerContext()
    lib.registerContext({
        id = 'wapensrepair_main',
        title = 'Wapens Repareren',
        options = {
            {
                title = 'Lijst Bekijken',
                description = 'Klik hier om de wapens te repareren.',
                icon = "fa-solid fa-cart-shopping",
                iconColor = SK.ColorPalette.green,
                onSelect = function()
                    openrepairmenu()
                end
            },
        },
    })
    lib.showContext('wapensrepair_main')
end