SMODS.Joker {
	key = "rot_canio",
	name = "Canio!",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = true,
        },
	},
	pos = { x = 0, y = 10 },
	soul_pos = { x = 0, y = 11 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", "face", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	prepared_card = "c_mf_doomblade",
	calculate = function(self, card, context)
	end,
}

SMODS.Consumable {
    key = 'doomblade',
	set = "Spectral",
    pos = { x = 0, y = 0 },
    atlas = "mf_rot_legendary_consumables",
	unlocked = true,
	discovered = true,
	no_collection = true,
	in_pool = function(...)
        return next(SMODS.find_card("j_mf_rot_canio"))
    end,
    config = { extra = { can_destroy = 3, xmult_given = 0.25 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.can_destroy, card.ability.extra.xmult_given },
		}
	end,
	use = function(self, card, area, copier)
        local destroy_count = #G.hand.highlighted
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                for _, v in ipairs(G.hand.cards) do
                    if not v:is_face() then
                        v.ability.perma_x_mult = v.ability.perma_x_mult or 0
                        v.ability.perma_x_mult = v.ability.perma_x_mult + card.ability.extra.xmult_given * destroy_count
                        card_eval_status_text(v, "extra", nil, nil, nil, {
                            message = localize("k_upgrade_ex"),
                            colour = G.C.MULT,
                            card = card,
                        })
                    end
                end
                return true
            end
        }))
	end,
	can_use = function(self, card)
        local can_use = G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.can_destroy
        for _, card in pairs(G.hand.highlighted) do
            if not card:is_face() then
                can_use = false
            end
        end
        return can_use
        -- return G.GAME.blind.in_blind
	end,
}