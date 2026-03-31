SMODS.Joker({
	key = "widejoker",
	name = "Wide Joker",
	atlas = "mf_jokers",
	config = {
		extra = {
			powmult = 1.14,
		},
	},
	pos = { x = 3, y = 3 },
	rarity = 3,
	cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	display_size = { w = 71.0 * 1.5, h = 95 / 1.5 },
	pools = { ["Meme"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.powmult },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if FLUFF.should_talisman_key("emult") then
				return {
					emult = card.ability.extra.powmult,
				}
			else
				return {
					pre_func = function()
						mult = mod_mult(mult ^ card.ability.extra.powmult)
					end,
					message = "^" .. card.ability.extra.powmult .. " Mult",
					sound = "multhit2",
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
})
