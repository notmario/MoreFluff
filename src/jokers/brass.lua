-- you love to see it
function progressbar(val, max)
	if max > 10 then
		return val, "/" .. max
	end
	return string.rep("🟩", val), string.rep("🟩", max - val)
end

SMODS.Joker({
	key = "brass",
	name = "Brass Joker",
	atlas = "mf_jokers",
	config = {
		retriggers = 0,
		partial_rounds = 0,
		upgrade_rounds = 3,
	},
	pos = { x = 2, y = 5 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	enhancement_gate = "m_mf_brass",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_brass

		local val, max = progressbar(center.ability.partial_rounds, center.ability.upgrade_rounds)
		return { vars = { center.ability.retriggers, val, max, center.ability.upgrade_rounds } }
	end,
	calculate = function(self, card, context)
		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and context.other_card ~= self
			and card.ability.retriggers >= 1
		then
			retrigger_card = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					retrigger_card = G.jokers.cards[i + 1]
				end
			end
			if retrigger_card == context.other_card then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.retriggers,
					card = card,
				}
			end
		end
		if context.remove_playing_cards then
			local count = 0
			for _, other_card in pairs(context.removed) do
				if other_card.config.center.key == "m_mf_brass" then
					count = count + 1
				end
			end
			for i = 1, count do
				card.ability.partial_rounds = card.ability.partial_rounds + 1
				while card.ability.partial_rounds >= card.ability.upgrade_rounds do
					upgraded = true
					card.ability.retriggers = card.ability.retriggers + 1
					card.ability.partial_rounds = card.ability.partial_rounds - card.ability.upgrade_rounds

					-- card_eval_status_text(card, 'extra', nil, nil, nil, {
					--   message = localize('k_upgrade_ex'),
					--   colour = G.C.SECONDARY_SET.YELLOW,
					--   card = card
					-- })
				end
				if not upgraded then
					local str = card.ability.partial_rounds .. "/" .. card.ability.upgrade_rounds
					-- card_eval_status_text(_card, 'extra', nil, nil, nil, {
					--   message = str,
					--   colour = G.C.SECONDARY_SET.YELLOW,
					--   card = card
					-- })
				end
			end
		end
	end,
})
