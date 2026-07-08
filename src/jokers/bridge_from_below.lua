SMODS.Joker {
	key = "bridge_from_below",
	name = "Bridge from Below",
	atlas = "mf_jokers",
	config = {
        extra = {}
    },
	pos = { x = 0, y = 17 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false, -- It doesn't tick down in exile. While this makes sense if another card is exiled, it doesnt make sense here
    attributes = { "exile", "on_sell" --[[ :troll: ]], "generation", "spectral", "discard", "hand_type", }, 
	loc_vars = function(self, info_queue, card)
	    return { }
	end,
	calculate = function(self, card, context)
		if context.mf_bridge_from_below_pre_discard and not context.hook then
			local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
			if non_loc_disp_text == "Straight" then
				if
					#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
				then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						trigger = "before",
						delay = 0.0,
						func = function()
							local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "sea")
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
							return true
						end,
					}))
					return {
						message = localize("k_plus_spectral"),
						colour = G.C.SECONDARY_SET.Spectral,
						card = card,
					}
				end
			else
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						SMODS.destroy_cards { card }
						return true
					end,
				}))
			end
		end
    end,
}

local gfsc = G.FUNCS.sell_card
G.FUNCS.sell_card = function(e, ...)
    local card = e.config.ref_table
    if card.config.center_key == "j_mf_bridge_from_below" then
        FLUFF.exile_card(card, 0.1)
    else
        gfsc(e, ...)
    end
end

local sgca = SMODS.get_card_areas
function SMODS.get_card_areas(_type, _context, ...)
    if FLUFF.joker_areas_is_exile and _type == "jokers" then
		return { G.mf_exile }
	else
		return sgca(_type, _context, ...)
	end
end