SMODS.Joker {
	key = "space_elevator",
	name = "Space Elevator",
	atlas = "mf_jokers",
	config = {
		extra = {
            threshold = 7,
            csl = 2,
            active = false,
        },
	},
	pos = { x = 0, y = 15 },

	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { "passive", "space", "exile", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.threshold, card.ability.extra.csl },
		}
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if not card.ability.mf_exile_until_id then card.ability.mf_exile_until_id = math.random(1000000000000) end
	end,
	update = function(self, card, dt)
		if G.mf_exile and card.area == G.jokers and G.jokers then
			if #G.mf_exile.cards >= 7 and not card.ability.extra.active then
                card.ability.extra.active = true
		        SMODS.change_play_limit(card.ability.extra.csl)
		        SMODS.change_discard_limit(card.ability.extra.csl)
            end
			if #G.mf_exile.cards < 7 and card.ability.extra.active then
                card.ability.extra.active = false
		        SMODS.change_play_limit(-card.ability.extra.csl)
		        SMODS.change_discard_limit(-card.ability.extra.csl)
            end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.active then
            SMODS.change_play_limit(card.ability.extra.csl)
            SMODS.change_discard_limit(card.ability.extra.csl)
        end
	end,
	remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.active then
            SMODS.change_play_limit(-card.ability.extra.csl)
            SMODS.change_discard_limit(-card.ability.extra.csl)
        end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
            FLUFF.draw_to_exile(false, nil, nil, function(other_card)
                other_card.ability.mf_pact_id = card.ability.mf_exile_until_id
            end)
		end
    end,
}