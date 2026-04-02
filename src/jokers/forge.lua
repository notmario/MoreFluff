function progressbar(val, max)
	if max > 10 then
		return val, "/" .. max
	end
	return string.rep("🟩", val), string.rep("🟩", max - val)
end

SMODS.Joker({
	key = "forge",
	name = "Forge",
	atlas = "mf_jokers",
	mf_art_credit = "LFMoth",
	config = {
		partial_rounds = 0,
		upgrade_rounds = 2,
	},
	pos = { x = 8, y = 8 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "joker", "on_sell", },
	loc_vars = function(self, info_queue, center)
		local val, max = progressbar(center.ability.partial_rounds, center.ability.upgrade_rounds)
		return { vars = { val, max, center.ability.upgrade_rounds } }
	end,
	calculate = function(self, card, context)
		if
			context.selling_card
			and not context.selling_self
			and context.card.ability.set == "Joker"
			and context.card.config.center.key ~= "j_mf_forgeslop"
		then
			local count = 1
			local upgraded = false
			for i = 1, count do
				card.ability.partial_rounds = card.ability.partial_rounds + 1
				while card.ability.partial_rounds >= card.ability.upgrade_rounds do
					card.ability.partial_rounds = card.ability.partial_rounds - card.ability.upgrade_rounds

					local shenanigans = false

					for _, other_card in pairs(G.jokers.cards) do
						if other_card.config.center.key == "j_mf_forge" then
							if other_card ~= card then
								shenanigans = true
							end
							goto continue
						end
					end

					::continue::

					local force_key = nil
					if shenanigans then
						force_key = "j_mf_forgeslop"
					end

					play_sound("timpani")
					SMODS.add_card({ set = "Joker", key = force_key })
					card:juice_up(0.3, 0.5)

					upgraded = true

					-- card_eval_status_text(card, 'extra', nil, nil, nil, {
					--   message = localize('k_forged_ex'),
					--   colour = G.C.SECONDARY_SET.YELLOW,
					--   -- card = card
					-- })
				end
				if not upgraded then
					local str = card.ability.partial_rounds .. "/" .. card.ability.upgrade_rounds
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = str,
						colour = G.C.SECONDARY_SET.YELLOW,
						-- card = card
					})
				end
			end
		end
	end,
})
