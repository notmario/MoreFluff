SMODS.Joker({
	key = "lettergem_e",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	no_shader_on_modbadge = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 1 * 2,
	pos = { x = 5, y = 3 },
	config = { extra = { emult = 1.4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.emult } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if Talisman or Cryptid then
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
