SMODS.Joker {
	key = "rot_marigold",
	name = "Marigold!",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = true,
        },
	},
	pos = { x = 6, y = 10 },
	soul_pos = { x = 0, y = 5 },
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
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_marigold
		return {
			vars = {},
		}
	end,
	prepared_card = "c_mf_lotusbloom",
	calculate = function(self, card, context)
		if context.mf_card_converted and not SMODS.has_enhancement(context.card, "m_mf_marigold") then
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
    key = 'lotusbloom',
	set = "Spectral",
    pos = { x = 6, y = 0 },
    atlas = "mf_rot_legendary_consumables",
	unlocked = true,
	discovered = true,
	no_collection = true,
	config = {
		-- max_highlighted = 1,
	},
	in_pool = function(...)
        return next(SMODS.find_card("j_mf_rot_marigold"))
    end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_marigold

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = "m_mf_marigold" }),
			},
		}
	end,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability("m_mf_marigold")
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))

        local cards = {}
        for _, area in ipairs({G.deck, G.discard}) do
            for _, other_card in ipairs(area.cards) do
                if SMODS.has_enhancement(other_card, "m_mf_marigold") then
                    cards[#cards + 1] = other_card
                end
            end
        end
        for _, other_card in ipairs(cards) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    other_card.area:remove_card(other_card)
                    G.hand:emplace(other_card)
                    play_sound("chips1", 0.4 + (0.9 + 0.2 * math.random()) * 0.2, 1)
                    return true
                end
            }))
        end
            
        delay(0.5)
	end,
	can_use = function(self, card)
        return G.hand and #G.hand.highlighted <= 1
	end,
}

local sah = Card.set_ability
function Card:set_ability(center, ...)
    sah(self, center, ...)
    if self.ability.set == "Enhanced" and not FLUFF.opening_pack then
        SMODS.calculate_context { mf_card_converted = true, card = self }
    end
    self.mf_just_opened = nil
end