SMODS.Joker {
	key = "whiplash",
	name = "Whiplash",
	atlas = "mf_jokers",
	config = {
		extra = {
            cards = 2,
        },
	},
	pos = { x = 2, y = 14 },

	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { "passive" },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards },
		}
	end,
	calculate = function(self, card, context)
        if context.mf_add_to_hand then
            for i = 1, card.ability.extra.cards do
                for _, other_card in ipairs(G.hand.cards) do
                    if not other_card.mf_added_to_hand then
                        other_card.mf_added_to_hand = true
                        FLUFF.add_to_hand[#FLUFF.add_to_hand + 1] = other_card
                        break
                    end
                end
            end
        end
    end,
}