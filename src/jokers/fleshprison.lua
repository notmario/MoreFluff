SMODS.Joker({
	key = "fleshprison",
	name = "Flesh Prison",
	config = {
		extra = { boss_size = 5 },
	},
	pos = { x = 0, y = 2 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_shader_on_modbadge = true,
	no_collection = true,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	attributes = { "xblindsize", "generation", "spectral", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
		return {
			vars = { center.ability.extra.boss_size },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and context.blind.boss and not card.getting_sliced then
			card.gone = false
			return {
				xblindsize = 5
			}
		end
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and G.GAME.blind.boss
			and not card.gone
		then
			SMODS.add_card { key = "c_soul", edition = "e_negative" }
			SMODS.destroy_cards { card }
			card.gone = true
		end
	end,
})
