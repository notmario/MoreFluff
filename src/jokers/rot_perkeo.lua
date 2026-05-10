SMODS.Joker {
	key = "rot_perkeo",
	name = "Perkeo!",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = false,
        },
	},
	pos = { x = 4, y = 10 },
	soul_pos = { x = 4, y = 11 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	prepared_card = "c_mf_mirror",
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
            local suits = {}
            for suit, _ in pairs(SMODS.Suits) do
                suits[suit] = 0
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

			if suit_count >= 3 and not card.ability.extra.is_prepared then
				card.ability.extra.is_prepared = true
				return {
					message = localize "k_prepared_ex",
					colour = G.C.SECONDARY_SET.Spectral,
				}
			end
        end
	end,
}

SMODS.Consumable {
    key = 'mirror',
	set = "Spectral",
    pos = { x = 4, y = 0 },
    atlas = "mf_rot_legendary_consumables",
	unlocked = true,
	discovered = true,
	no_collection = true,
	in_pool = function(...)
        return next(SMODS.find_card("j_mf_rot_perkeo"))
    end,
	use = function(self, card, area, copier)
        if G.consumeables.cards[1] then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local card_to_copy, _ = pseudorandom_element(G.consumeables.cards, 'vremade_perkeo')
                    local copied_card = copy_card(card_to_copy)
                    copied_card:set_edition("e_negative", true)
                    copied_card:add_to_deck()
                    G.consumeables:emplace(copied_card)
                    return true
                end
            }))
            return { message = localize('k_duplicated_ex') }
        end
	end,
	can_use = function(self, card)
		return #G.consumeables.cards > 0
	end,
}