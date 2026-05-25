SMODS.Joker {
	key = "emeritus_eternity",
	name = "Emeritus of Eternity",
	atlas = "mf_oldfluff",
	config = {
		extra = {
			is_prepared = true,
			select_count = 0,
		},
	},
	prepared_card = "c_mf_fake_ass_hieroglyph",
	force_prep_card_type = "Voucher",
	pos = { x = 9, y = 5 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "voucher", "generation", "reset", },
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.select_count } }
	end,
	calculate = function(self, card, context)
		if context.mf_used_prepared and context.card == card then
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
			ease_hands_played(1)
		end
		if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
			card.ability.extra.select_count = card.ability.extra.select_count + 1
			if card.ability.extra.select_count >= 6 then
				card.ability.extra.select_count = card.ability.extra.select_count - 6
				if not card.ability.extra.is_prepared then
					card.ability.extra.is_prepared = true
					return {
						message = localize "k_prepared_ex",
						colour = G.C.SECONDARY_SET.Spectral,
					}
				else
					return {
						message = localize "k_reset",
						colour = G.C.RED,
					}
				end
			else
				return {
					message = card.ability.extra.select_count.."/5",
				}
			end
		end
	end,
}

SMODS.Consumable {
    key = 'fake_ass_hieroglyph',
	set = "Spectral",
    pos = { x = 5, y = 2 },
    atlas = "Voucher",
    prefix_config = { atlas = false },
	unlocked = true,
	discovered = true,
	no_collection = true,
	in_pool = function(...) return false end,
	use = function(self, card, area, copier)
        ease_ante(-1)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1

        -- Apply hand change
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        ease_hands_played(-1)
	end,
	can_use = function(self, card)
		return true
	end,
}