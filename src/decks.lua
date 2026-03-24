SMODS.Back({
	key = "oldfluff",

	atlas = "mf_enhancers",
	pos = { x = 4, y = 0 },

	unlocked = true,
	discovered = true,

	apply = function(self, back)
		G.GAME.modifiers.mf_pack_tax = (G.GAME.modifiers.mf_pack_tax or 0) + 1
		G.GAME.modifiers.mf_bonus_scrapped = true
	end,

	loc_vars = function(self, info_queue, card)
		return {
			vars = { colours = { HEX("000000") } },
		}
	end,
})

local csc = Card.set_cost

function Card:set_cost(...)
	if G.GAME.modifiers.mf_pack_tax and self.ability.set == "Booster" then
		G.GAME.inflation = (G.GAME.inflation or 0) + G.GAME.modifiers.mf_pack_tax
	end
	csc(self, ...)
	if G.GAME.modifiers.mf_pack_tax and self.ability.set == "Booster" then
		G.GAME.inflation = (G.GAME.inflation or 0) - G.GAME.modifiers.mf_pack_tax
	end
end
