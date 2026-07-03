SMODS.Joker {
	key = "emeritus_lore",
	name = "Emeritus of Lore",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = false,
            buy_values = {
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
                false,
            },
            prep_rot = false,
		},
	},
	prepared_card = function(card)
        return card.ability.extra.prep_rot and "c_mf_rot_soul" or "c_soul"
    end,
	pos = { x = 5, y = 12 },
	rarity = 2,
	cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "spectral", "generation", "reset", "consumable", },
	loc_vars = function(self, info_queue, center)
		local funny = function(val)
			return val and G.C.FILTER or G.C.UI.TEXT_INACTIVE
		end
		return {
			vars = {
				colours = {
					funny(center.ability.extra.buy_values[1]),
					funny(center.ability.extra.buy_values[2]),
					funny(center.ability.extra.buy_values[3]),
					funny(center.ability.extra.buy_values[4]),
					funny(center.ability.extra.buy_values[5]),
					funny(center.ability.extra.buy_values[6]),
					funny(center.ability.extra.buy_values[7]),
					funny(center.ability.extra.buy_values[8]),
					funny(center.ability.extra.buy_values[9]),
					funny(center.ability.extra.buy_values[10]),
				},
			},
		}
	end,
	calculate = function(self, card, context)
		if context.buying_card and context.card ~= card and context.card.ability.set == "Joker" then
            if not card.ability.extra.buy_values[context.card.cost] and context.card.cost >= 1 and context.card.cost <= 10 then
                card.ability.extra.buy_values[context.card.cost] = true

                local count = 0
                for _, value in pairs(card.ability.extra.buy_values) do
                    if value then count = count + 1 end
                end
                if count >= 7 then
                    for i, _ in pairs(card.ability.extra.buy_values) do
                        card.ability.extra.buy_values[i] = false
                    end
                    if not card.ability.extra.is_prepared then
                        card.ability.extra.is_prepared = true
                        return { message = localize "k_prepared_ex", colour = G.C.SECONDARY_SET.Spectral }
                    else
                        return { message = localize "k_reset", colour = G.C.RED }
                    end
                else
                    return { message = count .. "/" .. 7 }
                end
            end
        end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.prep_rot = not card.ability.extra.prep_rot
            return { message = localize "k_rotated_ex", colour = G.C.PURPLE }
		end
	end,
}