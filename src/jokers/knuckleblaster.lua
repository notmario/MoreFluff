SMODS.Joker {
	key = "knuckleblaster",
	name = "Knuckleblaster",
	atlas = "mf_jokers",
	config = {
		extra = {
            xmult = 3,
            play_limit = 1,
        },
	},
	pos = { x = 1, y = 14 },

	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { },
	loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.xmult }
        }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-card.ability.extra.play_limit)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(card.ability.extra.play_limit)
	end,
}