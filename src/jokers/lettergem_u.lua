SMODS.Joker({
	key = "lettergem_u",
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
	pos = { x = 1, y = 5 },
	config = { extra = { mult = 13 } },
	attributes = { "mult", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.modify_scoring_hand and not context.blueprint then
			return {
				remove_from_hand = true,
			}
		end
		if context.joker_main then
			local effects = {}
			for _, other_card in ipairs(G.play.cards) do
				if not other_card.debuff then
					effects[#effects + 1] = {
						mult = card.ability.extra.mult,
						message_card = other_card,
					}
				end
			end
			return SMODS.merge_effects(effects)
		end
	end,
})
