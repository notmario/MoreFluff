SMODS.Joker({
	key = "stylemeter",
	name = "Style Meter",
	atlas = "mf_jokers",
	config = {
		extra = { per = 3 },
	},
	pos = { x = 1, y = 2 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.per, center.ability.extra.per * G.GAME.skips },
		}
	end,
	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("$") .. (G.GAME.skips * card.ability.extra.per),
						colour = G.C.MONEY,
						card = card,
					})
					return true
				end,
			}))
		end
	end,
	calc_dollar_bonus = function(self, card)
		if G.GAME.skips > 0 then
			return G.GAME.skips * card.ability.extra.per
		end
	end,
})
