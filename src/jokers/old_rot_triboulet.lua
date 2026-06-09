local is_k_or_q = function(card)
	return (card:get_id() == 12) or (card:get_id() == 13)
end
SMODS.Joker({
	key = "old_rot_triboulet",
	name = "Triboulet!?",
	config = {
		extra = {
			xmult = 1.5
		}
	},
	pos = { x = 0, y = 6 },
	-- soul_pos = { x = 1, y = 11 },
	mf_rotate_by = math.pi / 4,
	weight = 0.1,
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	no_collection = true,
	attributes = { "xmult", "rank", "king", "queen", },
	loc_vars = function(self, info_queue, center)
	    return {
	        vars = { center.ability.extra.xmult }
	    }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			-- based on j8mod code. thanks !!
			local card_is_played = false
			for _, v in ipairs(G.play.cards) do
				if v == context.other_card then
					card_is_played = true
					break
				end
			end
			if not is_k_or_q(context.other_card) and card_is_played then
				local ctx = {
					cardarea = G.play,
					full_hand = G.play.cards,
					scoring_hand = context.scoring_hand,
					scoring_name = context.scoring_name,
					poker_hands = context.poker_hands
				}
				local cards_to_trigger = {}
				for _, v in ipairs(G.hand.cards) do
					if v:can_calculate() and is_k_or_q(v) then
						table.insert(cards_to_trigger, v)
					end
				end
				if #cards_to_trigger > 0 then
					return {
						message_card = card,
						func = function()
							for _, v in ipairs(cards_to_trigger) do
								SMODS.score_card(v, ctx)
							end
							return true
						end
					}
				end
			end
			if is_k_or_q(context.other_card) and not card_is_played then
				local returns = { { xmult = card.ability.extra.xmult } }
				for _, v in ipairs(G.play.cards) do
					if is_k_or_q(v) then
						returns[#returns + 1] = {
							xmult = card.ability.extra.xmult,
							pre_func = function()
								G.E_MANAGER:add_event(Event({
									func = function()
										v:juice_up()
										return true
									end
								}))
							end
						}
					end
				end
				return SMODS.merge_effects(returns)
			end
		end
    end,
})
