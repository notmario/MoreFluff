SMODS.Joker({
	key = "unregisteredhypercam",
	name = "Unregistered Hypercam 2",
	atlas = "mf_jokers",
	config = {
		val = 1.04,
	},
	pos = { x = 7, y = 6 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	immutable = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.val } }
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or context.initial_scoring_step then
			if Talisman and Big and Big.arrow then
				return {
					eemult = card.ability.val,
				}
			else
				return {
					message = "^^1.04 Mult",
					pre_func = function()
						mult = mod_mult(mult ^ (mult ^ 0.04))
					end,
					sound = "multhit2",
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
})
