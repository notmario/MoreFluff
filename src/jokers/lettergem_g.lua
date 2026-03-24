SMODS.Joker {
	key = "lettergem_g",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	no_shader_on_modbadge = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 2 * 2,
	pos = { x = 7, y = 3 },
	config = { extra = { xmult = 1.01 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			return {
				message = "G",
				colour = G.C.DARK_EDITION,
				sound = "mf_g_riff",
				pitch = 1,
			}
		end
		if context.individual and context.cardarea == G.play then
			return {
				message = "G",
				colour = G.C.DARK_EDITION,
				remove_default_message = true,
				xmult = card.ability.extra.xmult,
				sound = "mf_g_riff",
				pitch = 1,
			}
		end
	end,
	-- tech from ellejokers  ty elle
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

		local s = G.TILESCALE * G.TILESIZE
		local destroy_sprite = SMODS.create_sprite(0, 0, 76 / s, 92 / s, "mf_lettergem_g", { x = 0, y = 0 })

		local destroy = {
			{
				n = G.UIT.O,
				config = { align = "cm", object = destroy_sprite },
			},
		}

		full_UI_table.main[1] = destroy
	end,
}
