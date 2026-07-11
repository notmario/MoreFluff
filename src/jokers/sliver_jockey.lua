SMODS.Joker {
	key = "sliver_jockey",
	name = "Sliver Jockey",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 2,
        }
    },
	pos = { x = 1, y = 18 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "retrigger", "position", "joker", "sliver", }, 
    mf_sliver_ability = "sliver_jockey",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, }}
	end,
	calculate = function(self, card, context)
		if context.modify_weights and context.pool_types.Joker then
			for _, c in pairs(context.pool) do
				if FLUFF.has_attribute(c.key, "sliver") then
					c.weight = c.weight * card.ability.extra.odds
				end
			end
		end
    end,
}

FLUFF.sliver_effects.sliver_jockey = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
		if context.repetition and context.cardarea == G.play then
            local my_ind = 0
            local their_ind = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					my_ind = i
				end
			end
            for i = 1, #G.play.cards do
				if G.play.cards[i] == context.other_card then
					their_ind = i
				end
            end
            if my_ind == their_ind then
                if not jokers then jokers = {} end
                jokers = SMODS.merge_effects({ jokers, {
                    repetitions = 1,
                }})
            end
		end
        return jokers, triggered
    end,
}