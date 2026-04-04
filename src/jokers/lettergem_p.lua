SMODS.Joker({
	key = "lettergem_p",
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
	cost = 3 * 2,
	pos = { x = 6, y = 4 },
	config = { extra = { per_ante = 0.9 } },
	attributes = { "xblindsize", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.per_ante, card.ability.extra.per_ante ^ G.GAME.round_resets.ante } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not card.getting_sliced and G.GAME.round_resets.ante >= 0 then
			local effects = {}
			for i = 1, G.GAME.round_resets.ante do
				effects[#effects + 1] = { xblindsize = card.ability.extra.per_ante }
			end
			return SMODS.merge_effects(effects)
		end
	end,
})
