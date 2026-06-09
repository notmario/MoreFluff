SMODS.Joker {
	key = "rot_triboulet",
	name = "Triboulet!",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = true,
        },
	},
	pos = { x = 1, y = 10 },
	soul_pos = { x = 1, y = 11 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "hand_type", "generation", "spectral", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	prepared_card = "c_mf_reinforcements",
	calculate = function(self, card, context)
		if context.pre_discard then
			local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
			if non_loc_disp_text == "Pair" then
                if not card.ability.extra.is_prepared then
                    card.ability.extra.is_prepared = true
                    return {
                        message = localize "k_prepared_ex",
                        colour = G.C.SECONDARY_SET.Spectral,
                    }
                end
			end
        end
	end,
}

SMODS.Consumable {
    key = 'reinforcements',
	set = "Spectral",
    pos = { x = 1, y = 0 },
    atlas = "mf_rot_legendary_consumables",
	unlocked = true,
	discovered = true,
	no_collection = true,
	in_pool = function(...)
        return next(SMODS.find_card("j_mf_rot_triboulet"))
    end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { (G.GAME.rot_trib_count or 0) },
		}
	end,
	use = function(self, card, area, copier)
        G.GAME.rot_trib_count = (G.GAME.rot_trib_count or 0) + 1
        play_sound("timpani", 0.6)
	end,
	can_use = function(self, card)
		return true
	end,
}