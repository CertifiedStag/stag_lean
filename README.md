# stag_lean
A Simple Lean Creation Script

# Add to qb-core/shared/items.lua

 --Lean
 
    lean = { name = 'lean', label = 'Lean', weight = 0, type = 'item', image = 'lean.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'Lean...' },
    coughsyrup = { name = 'coughsyrup', label = 'Cough Syrup', weight = 0, type = 'item', image = 'coughsyrup.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'For that tickly throat' },
    antihistemine = { name = 'antihistemine', label = 'Antihistemine', weight = 0, type = 'item', image = 'antihistemine.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'Got allergies?' },
    kurkakola = { name = 'kurkakola', label = 'Cola', weight = 500, type = 'item', image = 'cola.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'For all the thirsty out there' },

# Add to ox_inventory/data/items.lua
`["lean"] = {
		label = "Lean",
		weight = 0,
		stack = true,
		close = true,
		description = "Lean...",
		client = {
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			export = "stag_lean.useLean",
			image = "lean.png",
		}
	},`

  # Discord: https://discord.gg/GRyqv5yfST
