SMODS.Joker({
	key = "broomcloset",
	name = "The Broom Closet",
	atlas = "mf_jokers",
	config = {
		extra = 4,
		active = true,
	},
	pos = { x = 6, y = 6 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", "reset", "shop", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra, center.ability.active and "active!" or "inactive" },
		}
	end,
	calculate = function(self, card, context)
		if ((context.buying_card and context.card ~= card) or context.open_booster) and card.ability.active then
			card.ability.active = false
			return {
				message = localize("k_disabled_ex"),
				colour = G.C.RED,
			}
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.active = true
			return {
				message = localize("k_reset"),
			}
		end
		if context.cardarea == G.jokers and context.joker_main and card.ability.active then
			return {
				xmult = card.ability.extra,
			}
		end
	end,
})
