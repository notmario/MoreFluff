SMODS.Joker {
	key = "rot_yorick",
	name = "Yorick!",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = true,
            discards = 23,
            discards_remaining = 23
        },
	},
	pos = { x = 2, y = 10 },
	soul_pos = { x = 2, y = 11 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", "discard", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.discards, card.ability.extra.discards_remaining },
		}
	end,
	prepared_card = "c_mf_windfall",
	calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if card.ability.extra.discards_remaining <= 1 then
                card.ability.extra.discards_remaining = card.ability.extra.discards
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
                card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
                return nil, true -- This is for Joker retrigger purposes
            end
        end
	end,
}

SMODS.Consumable {
    key = 'windfall',
	set = "Spectral",
    pos = { x = 3, y = 0 },
    config = { extra = { xmult_given = 0.2 } },
    atlas = "mf_rot_legendary_consumables",
	unlocked = true,
	discovered = true,
	no_collection = true,
	in_pool = function(...)
        return next(SMODS.find_card("j_mf_rot_yorick"))
    end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult_given },
		}
	end,
	use = function(self, card, area, copier)
        for _, v in ipairs(G.hand.cards) do
            v.ability.perma_x_mult = v.ability.perma_x_mult or 0
            v.ability.perma_x_mult = v.ability.perma_x_mult + card.ability.extra.xmult_given
            G.hand.highlighted[#G.hand.highlighted + 1] = v
            G.E_MANAGER:add_event(Event({
                trigger = "after",
			    func = function()
                    v:highlight(true)
                    return true
                end,
            }))
            card_eval_status_text(v, "extra", nil, nil, nil, {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                card = card,
            })
        end
        G.FUNCS.discard_cards_from_highlighted(nil, true)
	end,
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
}