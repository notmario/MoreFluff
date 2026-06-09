SMODS.Joker({
	key = "talljoker",
	name = "Tall Joker",
	config = {
		extra = {
			mult = 44,
		},
	},
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	display_size = { w = 71.0 / 1.5, h = 95 * 1.5 },
	attributes = { "mult", "joker", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.mult },
		}
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            local give_mult = true
            
            for _, other_card in pairs(G.jokers.cards) do
                if other_card ~= card then
                    if FLUFF.has_attribute(other_card, "mult") or FLUFF.has_attribute(other_card, "xmult") or FLUFF.has_attribute(other_card, "emult") or FLUFF.has_attribute(other_card, "hypermult") then give_mult = false end
                end
            end
            
            if give_mult then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
	end,
})
