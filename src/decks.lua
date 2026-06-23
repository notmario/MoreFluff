SMODS.Back({
	key = "oldfluff",

	atlas = "mf_enhancers",
	pos = { x = 4, y = 0 },

	unlocked = true,
	discovered = true,

	apply = function(self, back)
		G.GAME.modifiers.mf_buffoon_pack_tax = (G.GAME.modifiers.mf_buffoon_pack_tax or 0) + 2
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
	if G.GAME.modifiers.mf_buffoon_pack_tax and self.ability.set == "Booster" and self.config.center.kind == "Buffoon" then
		G.GAME.inflation = (G.GAME.inflation or 0) + G.GAME.modifiers.mf_buffoon_pack_tax
	end
	csc(self, ...)
	if G.GAME.modifiers.mf_buffoon_pack_tax and self.ability.set == "Booster" and self.config.center.kind == "Buffoon" then
		G.GAME.inflation = (G.GAME.inflation or 0) - G.GAME.modifiers.mf_buffoon_pack_tax
	end
end

SMODS.Back {
	key = "philosophical",
	config = { jokers = { "j_mf_philosophical", "j_mf_philosophical", "j_mf_philosophical", "j_mf_philosophical", "j_mf_philosophical" } },
	pos = { x = 1, y = 0 },
	atlas = "mf_enhancers",
	unlocked = true,
	discovered = true,
}

SMODS.Back {
    name = "Rainbow Deck",
    key = "rainbow",
    config = { voucher = 'v_mf_paintroller', consumables = {'c_mf_white'} },
    pos = { x = 2, y = 0 },
    atlas = "mf_enhancers",
    unlocked = true,
	discovered = true,
}