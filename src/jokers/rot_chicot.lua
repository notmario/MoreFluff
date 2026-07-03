SMODS.Joker {
	key = "rot_chicot",
	name = "Chicot!",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = true,
        },
	},
	pos = { x = 3, y = 10 },
	soul_pos = { x = 3, y = 11 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", "skip", "boss_blind", "consumable", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	prepared_card = "c_mf_negate",
	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint then
            if not card.ability.extra.is_prepared then
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
    key = 'negate',
	set = "Spectral",
    pos = { x = 3, y = 0 },
    atlas = "mf_rot_legendary_consumables",
	unlocked = true,
	discovered = true,
	no_collection = true,
	in_pool = function(...)
        return next(SMODS.find_card("j_mf_rot_chicot"))
    end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind:disable()
                        G.GAME.blind.chips = G.GAME.blind.chips ^ 0.8
                        play_sound('timpani')
                        delay(0.4)
                        return true
                    end
                }))
                SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                return true
            end
        }))
	end,
	can_use = function(self, card)
        return G.GAME.blind.in_blind
	end,
}