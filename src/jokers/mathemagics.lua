SMODS.Joker {
	key = "mathemagics",
	name = "Mathemagics",
	atlas = "mf_jokers",
	config = {
		extra = {
            current_sold = 0,
		},
	},
	pos = { x = 1, y = 12 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "joker", "reset", "on_sell", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { 2 ^ math.floor(center.ability.extra.current_sold / 2), (math.floor(center.ability.extra.current_sold / 2) == 0) and "" or "s"},
		}
	end,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and not context.selling_self then
            card.ability.extra.current_sold = card.ability.extra.current_sold + 1
            if math.fmod(card.ability.extra.current_sold, 2) <= 0.0001 then
                return {
                    message = localize "k_upgrade_ex",
                    colour = G.C.PURPLE
                }
            end
		end
		if context.first_hand_drawn then
			SMODS.draw_cards(2 ^ math.floor(card.ability.extra.current_sold / 2))
            local did_reset = card.ability.extra.current_sold ~= 0
            card.ability.extra.current_sold = 0
            if did_reset then
                return {
                    message = localize "k_reset",
                    colour = G.C.RED
                }
            end
		end
    end,
}