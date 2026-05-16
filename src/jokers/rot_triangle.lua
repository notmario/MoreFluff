SMODS.Joker {
	key = "rot_triangle",
	name = "Triangle!",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = true,
            should_prep = false,
        },
	},
	pos = { x = 5, y = 10 },
	soul_pos = { x = 9, y = 5 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "hand_type", "generation", "spectral", },
	pronouns = "she_they",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	prepared_card = "c_mf_refraction",
	calculate = function(self, card, context)
		if context.before and context.scoring_name == "Three of a Kind" and not context.blueprint and not card.ability.extra.should_prep then
			card.ability.extra.should_prep = true
            return {
                message = localize "k_ready_ex"
            }
		end
        if context.end_of_round and card.ability.extra.should_prep and context.cardarea == G.jokers then
            card.ability.extra.should_prep = false
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
        end
	end,
}

SMODS.Consumable {
    key = 'refraction',
	set = "Spectral",
    pos = { x = 5, y = 0 },
    atlas = "mf_rot_legendary_consumables",
	unlocked = true,
	discovered = true,
	no_collection = true,
	in_pool = function(...)
        return next(SMODS.find_card("j_mf_rot_triangle"))
    end,
	use = function(self, card, area, copier)
        local function use_colour(count, first) 
            -- G.E_MANAGER:add_event(Event({ func = function()
            G.E_MANAGER:add_event(Event({ func = function()
            G.E_MANAGER:add_event(Event({ func = function()
                if first then
                    delay(0.5)
                end
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = first and 0.15 or nil,
                    func = function()
                        local other_card = SMODS.add_card {
                            set = "Colour",
                            area = G.play,
                            allow_duplicates = true
                        }
                        other_card.ability.val = 1
                        return true
                    end,
                }))
                
                if first then
                    delay(0.5)
                end

                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = first and 0.15 or nil,
                    func = function()
                        if G.play.cards[1].config.center.key == "c_mf_yellow" then
                            ease_dollars(G.play.cards[1].ability.value_per)
                        end
                        G.FUNCS.use_card({
                            config = { ref_table = G.play.cards[1] }
                        }, nil, nil)
                        return true
                    end,
                }))
                if count > 1 then use_colour(count - 1, false) end
            return true end, }))
            return true end, }))
            -- return true end, }))
        end
        use_colour(5, true)
	end,
	can_use = function(self, card)
		return true
	end,
}