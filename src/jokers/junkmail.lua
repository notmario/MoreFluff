SMODS.Joker({
	key = "junkmail",
	name = "Junk Mail",
	atlas = "mf_jokers",
	config = {
		extra = { val_mult = 1.5 },
	},
	pos = { x = 2, y = 6 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.val_mult },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round then
			card.ability.triggered = nil
		end
		if context.starting_shop and not card.ability.triggered then
			card.ability.triggered = true
			local other_card = SMODS.add_voucher_to_shop()
			other_card.base_cost = other_card.base_cost * card.ability.extra.val_mult
			other_card:set_cost()
			return {
				message = localize("k_plus_voucher"),
			}
		end
	end,
})
