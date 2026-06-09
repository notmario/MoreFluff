SMODS.Joker({
	key = "yuckyrat",
	name = "Yucky Rat",
	atlas = "mf_jokers",
	config = {
		extra = {
			x_mult = 1,
			x_mult_mod = 0.05,
		},
	},
	pos = { x = 1, y = 5 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	attributes = { "xmult", "scaling", "modify_card", "enhancements", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_yucky

		return {
			vars = { center.ability.extra.x_mult_mod, center.ability.extra.x_mult },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.x_mult > 1.0 then
			return {
				xmult = card.ability.extra.x_mult, -- steamodded has this now??
			}
		end
		if context.cardarea == G.jokers and context.before then
			card.ability.extra.scale_by = 0
			local cards = {}
			for _, other_card in pairs(G.play.cards) do
				if other_card.config.center ~= G.P_CENTERS.c_base then
					goto continue
				end

				cards[#cards + 1] = other_card

				card.ability.extra.scale_by = card.ability.extra.scale_by + card.ability.extra.x_mult_mod
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						other_card:flip()
						play_sound("card1", 1)
						other_card:juice_up(0.3, 0.3)
						return true
					end,
				}))
				::continue::
			end
			for _, other_card in pairs(cards) do
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						other_card:flip()
						play_sound("card1", 1)
						other_card:set_ability(G.P_CENTERS["m_mf_yucky"])
						card:juice_up(0.3, 0.5)
						return true
					end,
				}))
			end
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "scale_by",
				message_key = "a_xmult",
			})
		end
	end,
})
