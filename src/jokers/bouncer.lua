SMODS.Joker {
	key = "bouncer",
	name = "Bouncer",
	atlas = "mf_jokers",
	config = {
		extra = {
            chips_per = 3,
            chips = 0,
		},
	},
	pos = { x = 2, y = 12 },
	rarity = 1,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "joker", "position", "consumable", "shop", },
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_mf_fish
		return {
			vars = { center.ability.extra.chips_per, SMODS.signed(center.ability.extra.chips) },
		}
	end,
    calculate = function(self, card, context)
        if context.starting_shop and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
                    local other_joker
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
                    end
                    local is_joker = not not other_joker
                    if not other_joker then other_joker = G.consumeables.cards[1] end
                    if other_joker then
						card.ability.extra.scale_by = other_joker.sell_cost * card.ability.extra.chips_per
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = "chips",
							scalar_value = "scale_by",
							message_key = "a_chips",
							message_colour = G.C.CHIPS,
						})

                        other_joker:remove_from_deck()
                        other_joker.area:remove_card(other_joker)
                        G.shop_jokers:emplace(other_joker)
                        create_shop_card_ui(other_joker, card.ability.set, G.shop_jokers)
                    end
                    if is_joker then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local other_card = SMODS.add_card {
                                    set = "Joker",
                                    key = "j_mf_fish"
                                }
                                SMODS.calculate_effect({
                                    message = localize "k_gift_ex",
                                    colour = G.C.BLUE
                                }, other_card)
                                return true
                            end
                        }))
                    end
                    return true
				end,
			}))
        end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
    end,
}