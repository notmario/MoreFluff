SMODS.Joker({
	key = "goldencarrot",
	name = "Golden Carrot",
	atlas = "mf_jokers",
	config = {
		extra = { gain = 10, loss = 1 },
	},
	pos = { x = 6, y = 0 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.gain, center.ability.extra.loss },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.after and not context.blueprint and not card.gone then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "gain",
				scalar_value = "loss",
				operation = "-",
				message_key = "a_minus_dollars",
			})
			if card.ability.extra.gain <= 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(self)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.MONEY,
				}
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		local bonus = math.max(0, card.ability.extra.gain)
		if bonus > 0 then
			return bonus
		end
	end,
})
