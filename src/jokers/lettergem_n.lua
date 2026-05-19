SMODS.Joker({
	key = "lettergem_n",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 1 * 2,
	pos = { x = 4, y = 4 },
	config = { extra = {} },
	attributes = { "generation", "joker", "boss_blind", },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and context.blind.boss then
			local card = SMODS.add_card({
				set = "Joker",
				key = "j_joker",
				edition = "e_negative",
			})
			return {
				message = localize("k_plus_joker"),
				colour = G.C.BLUE,
			}
		end
	end,
})
