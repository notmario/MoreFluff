SMODS.Joker({
	key = "hold_music",
	name = "Hold Music",
	config = {
        extra = {
            chips = 5,
        }
	},
	atlas = "mf_jokers",
	pos = { x = 8, y = 15 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "hands", "chips", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips * #G.mf_exile.cards
			}
		end
		if context.after then
            -- pick that many random cards
            local temp_hand = {}
            for _, v in ipairs(G.hand.cards) do
                if not v.suspending then
                    temp_hand[#temp_hand + 1] = v
                end
            end
            pseudoshuffle(temp_hand, pseudoseed("mf_holdmusic"))
            
            for i = 1, 2 do
                if temp_hand[i] then
                    FLUFF.suspend_card(temp_hand[i], 1)
                end
            end
		end
	end,
})
