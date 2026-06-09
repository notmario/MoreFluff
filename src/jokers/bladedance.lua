SMODS.Joker({
	key = "bladedance",
	name = "Blade Dance",
	atlas = "mf_jokers",
	config = {
		extra = 2,
		base_cost = 8,
	},
	pos = { x = 5, y = 2 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "enhancements", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return {
			vars = { center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if
			(context.first_hand_drawn and not card.getting_sliced)
			and not (context.blueprint_card or card).getting_sliced
		then
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.7,
				func = function()
					local cards = {}
					for i = 1, card.ability.extra do
						cards[i] = true
						local _suit, _rank = nil, nil
						_rank = pseudorandom_element(SMODS.Ranks, pseudoseed("bladedance_create")).card_key
						_suit = pseudorandom_element(SMODS.Suits, pseudoseed("bladedance_create")).card_key
						local card = create_playing_card(
							{ front = G.P_CARDS[_suit .. "_" .. _rank], center = G.P_CENTERS.m_steel },
							G.hand,
							nil,
							i ~= 1,
							{ G.C.SECONDARY_SET.Spectral }
						)
						card.ability.mf_temporary = true
					end
					playing_card_joker_effects(cards)
					return true
				end,
			}))
		end
	end,
})
