SMODS.Joker({
	key = "jackofalltrades",
	name = "Jack of all Trades",
	atlas = "mf_jokers",
	config = {
		extra = {
			mult = 2,
			chips = 10,
			dollars = 1,
		},
	},
	pos = { x = 3, y = 8 },
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.mult,
				center.ability.extra.chips,
				center.ability.extra.dollars,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if context.other_card:get_id() == 11 then
				return {
					card = other_card,
					mult = card.ability.extra.mult,
					chips = card.ability.extra.chips,
					dollars = card.ability.extra.dollars,
				}
			end
		end
		if context.forcetrigger then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
				dollars = card.ability.extra.dollars,
			}
		end
	end,
})
