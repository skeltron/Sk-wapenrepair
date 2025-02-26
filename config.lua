SK = {}

SK.Logs = '' -- Webhook toevoegen voor logs
SK.Prijs = 250000 -- Maximale reparatieprijs in zwart geld

SK.PedData = {
    model = `cs_casey`, -- Npc model
    coords = vec4(-569.5328, -1602.1329, 27.0108, 131.5700),  -- Coords van waar de npc staat 
  
    target = {
      label = 'Spreek met de dealer', -- Tekst van het ox_target menu
      icon = "fa-solid fa-comment"  -- Icoontje van het ox_target menu
    },
  
    blip = {
      enabled = false, -- Blip = true is aanzetten : blip = false is uitzetten
      size = 0.7, -- Blip groote op de map
      sprite = 280, -- Blip icoontje
      color = 0, -- Blips kleur
      title = 'Repair'  -- Blip naam
    }
  }

  SK.Wapens = { -- De wapens die kunnen gerepareerd worden
    {
      label = 'Pistool', -- Naam van het wapen in het menu
      name = 'weapon_combatpistol', -- Spawnnaam van het wapen
    },
    {
      label = 'Ak', -- Naam van het wapen in het menu
      name = 'weapon_assaultrifle', -- Spawnnaam van het wapen
    },
  }
  
  SK.ColorPalette = {
    red = '#cf4030',
    green = '#479423',
    blue = '#3789bb',
    yellow = '#fdd041',
    orange = '#f7931a'
  }