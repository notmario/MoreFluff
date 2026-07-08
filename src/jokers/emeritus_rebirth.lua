SMODS.Joker {
	key = "emeritus_rebirth",
	name = "Emeritus of Rebirth",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = false,
		},
	},
	prepared_card = "c_death",
	pos = { x = 6, y = 12 },
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "tarot", "generation", "reset", "consumable", },
	loc_vars = function(self, info_queue, center)
		return {}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
            local ranks = {}
            local suits = {}
            for suit, _ in pairs(SMODS.Suits) do
                suits[suit] = 0
            end
            for rank, _ in pairs(SMODS.Ranks) do
                ranks[rank] = 0
            end

            for i = 1, #context.scoring_hand do
                for rank, real_rank in pairs(SMODS.Ranks) do
					if context.scoring_hand[i]:get_id() == real_rank.id and ranks[rank] == 0 then
						ranks[rank] = ranks[rank] + 1
						break
					end
				end
            end
            local rank_count = 0
            for _, count in pairs(ranks) do
                if count > 0 then rank_count = rank_count + 1 end
            end

            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    for suit, _ in pairs(suits) do
                        if context.scoring_hand[i]:is_suit(suit, true) and suits[suit] == 0 then
                            suits[suit] = suits[suit] + 1
                            break
                        end
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    for suit, _ in pairs(suits) do
                        if context.scoring_hand[i]:is_suit(suit) and suits[suit] == 0 then
                            suits[suit] = suits[suit] + 1
                            break
                        end
                    end
                end
            end
            local suit_count = 0
            for _, count in pairs(suits) do
                if count > 0 then suit_count = suit_count + 1 end
            end

			if (rank_count >= 3 or suit_count >= 3) and not card.ability.extra.is_prepared then
				card.ability.extra.is_prepared = true
				return {
					message = localize "k_prepared_ex",
					colour = G.C.SECONDARY_SET.Spectral,
				}
			end
		end
	end,
}