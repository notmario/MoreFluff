SMODS.Joker {
	key = "lettergem_r",
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
	cost = 1 * 2,
	pos = { x = 8, y = 4 },
	config = { extra = { rounds_per = 1, mult_per = 1 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.rounds_per,
				card.ability.extra.mult_per,
				card.ability.extra.mult_per * G.GAME.round,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event {
				func = function()
					ease_round(card.ability.extra.rounds_per)
					return true
				end,
			})
			return {
				message = localize {
					type = "variable",
					key = "a_plus_rounds",
					vars = { card.ability.extra.rounds_per },
				},
			}
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult_per * (G.GAME.round or 0),
			}
		end
	end,
}
