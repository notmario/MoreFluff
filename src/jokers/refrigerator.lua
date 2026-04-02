SMODS.Joker {
    key = "refrigerator",
    name = "Refrigerator",
	atlas = "mf_jokers",
	config = { extra = { odds = 3 } },
	pos = { x = 8, y = 10 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "joker", },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds }}
	end,
    calculate = function(self, card, context)
        if context.check_eternal and FLUFF.has_attribute(context.other_card, "food") and context.trigger.destroy_cards then
            return { no_destroy = { override_compat = true } }
        end
		if context.modify_weights and context.pool_types.Joker then
			for _, c in pairs(context.pool) do
				if FLUFF.has_attribute(c.key, "food") then
					c.weight = c.weight * card.ability.extra.odds
				end
			end
		end
    end,
}

local ssc = SMODS.scale_card
function SMODS.scale_card(card, ...)
    if next(SMODS.find_card("j_mf_refrigerator")) and FLUFF.has_attribute(card, "food") then return nil end
    return ssc(card, ...)
end