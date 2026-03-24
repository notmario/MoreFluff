SMODS.Joker {
	key = "lollipop",
	name = "Lollipop",
	atlas = "mf_jokers",
	config = { extra = { xmult = 1.75, xmult_per = 0.15 } },
	pos = { x = 7, y = 1 },
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	demicoloncompat = true,
	pools = { ["Food"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.xmult, center.ability.extra.xmult_per },
		}
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and not context.retrigger_joker
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "xmult_per",
				operation = "-",
				message_key = "a_xmult_minus",
				message_colour = G.C.PURPLE,
			})
			if card.ability.extra.xmult <= 1.01 then
				G.E_MANAGER:add_event(Event {
					func = function()
						play_sound "tarot1"
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event {
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						})
						return true
					end,
				})
				return {
					message = localize "k_eaten_ex",
					colour = G.C.FILTER,
				}
			else
				-- card.ability.x_mult = card.ability.x_mult - card.ability.extra
			end
		elseif context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
}
