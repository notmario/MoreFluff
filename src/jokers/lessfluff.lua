SMODS.Joker({
	key = "lessfluff",
	name = "Less Fluff",
	atlas = "mf_jokers",
	config = {
		extra = {
			x_mult = 1,
			x_mult_per = 0.2,
		},
	},
	pos = { x = 9, y = 7 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	attributes = { "xmult", "scaling", "destroy_card", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_mult, center.ability.extra.x_mult_per },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra.x_mult,
			}
		end
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
			local gained_xmult_times = 0

			for _, other_jkr in pairs(G.jokers.cards) do
				if other_jkr.getting_sliced then
					goto continue
				end
				if not other_jkr.config.center.original_mod then
					goto continue
				end

				gained_xmult_times = gained_xmult_times + 1
				other_jkr.getting_sliced = true
				G.E_MANAGER:add_event(Event({
					func = function()
						other_jkr:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))

				::continue::
			end

			if gained_xmult_times > 0 then
				-- card.ability.extra.x_mult = card.ability.extra.x_mult + gained_xmult
				for i = 1, gained_xmult_times do
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "x_mult",
						scalar_value = "x_mult_per",
					})
				end
				play_sound("slice1", 0.96 + math.random() * 0.08)
				return {
					message = localize({ type = "variable", key = "x_mult", vars = { card.ability.extra.x_mult } }),
					colour = G.C.RED,
				}
			end
		end
	end,
})
