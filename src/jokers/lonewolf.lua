SMODS.Joker {
    key = "lonewolf",
    name = "tempname001",
    atlas = "mf_jokers",
    pos = { x = 0, y = 0, },
	config = { extra = { mult = 15, chips = 100 } },
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "mult", "chips", "joker", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.mult, center.ability.extra.chips },
		}
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            local give_chips = true
            local give_mult = true
            
            for _, other_card in pairs(G.jokers.cards) do
                if other_card ~= card then
                    if FLUFF.has_attribute(other_card, "chips") or FLUFF.has_attribute(other_card, "xchips") or FLUFF.has_attribute(other_card, "echips") or FLUFF.has_attribute(other_card, "eechips") or FLUFF.has_attribute(other_card, "hyperchips") then give_chips = false end
                    if FLUFF.has_attribute(other_card, "mult") or FLUFF.has_attribute(other_card, "xmult") or FLUFF.has_attribute(other_card, "emult") or FLUFF.has_attribute(other_card, "eemult") or FLUFF.has_attribute(other_card, "hypermult") then give_mult = false end
                end
            end
            
            if give_chips or give_mult then
                return {
                    chips = give_chips and card.ability.extra.chips or nil,
                    mult = give_mult and card.ability.extra.mult or nil
                }
            end
        end
	end,
}