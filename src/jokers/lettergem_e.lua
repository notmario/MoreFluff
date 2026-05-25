SMODS.Joker({
	key = "lettergem_e",
	atlas = "mf_letterjokers",
    display_size = { h = 78 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_letter",
	cost = 1 * 2,
	pos = { x = 4, y = 0 },
	config = { extra = { emult = 1.4 } },
	attributes = { "emult",},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.emult } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if FLUFF.should_talisman_key("emult") then
				return {
					emult = card.ability.extra.emult,
				}
			else
				return {
					message = "^" .. card.ability.extra.emult .. " Mult",
					colour = G.C.DARK_EDITION,
					pre_func = function()
						mult = mod_mult(mult ^ card.ability.extra.emult)
					end,
				}
			end
		end
	end,
})
