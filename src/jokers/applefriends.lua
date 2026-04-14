SMODS.Joker({
	key = "applefriends",
	name = "Apple Friends",
	atlas = "mf_jokers",
	config = {
		extra = { },
	},
	pos = { x = 9, y = 11 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "food", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { },
		}
	end,
	calculate = function(self, card, context)
		if
			context.selling_card
			and context.card ~= card
			and context.card.ability.set == "Joker"
		then
            SMODS.destroy_cards { card }
            return {
                message = localize "k_dead_ex",
                colour = G.C.RED,
            }
        end
	end,
})

local scalcieff = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	if key == "mult" or key == "mult_mod" or key == "h_mult" or
        key == "chips" or key == "chips_mod" or key == "h_chips" then
		local bonus = 1
		for _, card in ipairs(SMODS.find_card("j_mf_applefriends")) do
			bonus = bonus * 2
		end
		amount = amount * bonus
        if key == "mult_mod" or key == "chips_mod" then
            key = (key == "mult_mod") and "mult" or "chips"
            effect["mult_mod"] = nil
            effect["chips_mod"] = nil
            effect["message"] = nil
        end
	end
	return scalcieff(effect, scored_card, key, amount, from_edition)
end
