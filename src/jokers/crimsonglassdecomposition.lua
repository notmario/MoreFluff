local is_8_or_3 = function(card)
	return (card:get_id() == 8) or (card:get_id() == 3)
end
SMODS.Joker({
	key = "crimsonglassdecomposition",
	name = "Disintegration Loop",
	config = {
		extra = {
			fakeout_sprite = 0,
			bosses_left = 1,
			xmult = 1.5,
		},
	},
	pos = { x = 7, y = 13 },
	atlas = "mf_jokers",
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", "rank", "eight", "three", },
	loc_vars = function(self, info_queue, card)
		if card.area == G.jokers or card.ability.extra.fakeout_sprite == 5 then
			return {
				vars = { card.ability.extra.xmult, card.ability.extra.bosses_left },
			}
		else
        	return { key = "j_mf_fraud_fakeout_"..card.ability.extra.fakeout_sprite }
		end
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra.bosses_left = card.ability.extra.bosses_left - 1
			if
				card.ability.extra.bosses_left <= 0
			then
                card:set_ability(G.P_CENTERS["j_mf_halt"])
                card:juice_up()
				play_sound("mf_halt-alt")
				_G.halt_timer = 3.5
                G.jokers:unhighlight_all()

				for i = 1,3 do
					local stone_card = SMODS.add_card { set = "Base", enhancement = "m_mf_power", area = G.deck }
					SMODS.calculate_context({ playing_card_added = true, cards = { stone_card } })
				end

                return {
                    message = localize "k_transformed_ex",
					colour = HEX "ffff1f"
                }
			end
			return {
				message = ""..card.ability.extra.bosses_left
			}
		end
		if context.individual and context.cardarea == G.play then
			-- based on j8mod code. thanks !!
			local card_is_played = false
			for _, v in ipairs(G.play.cards) do
				if v == context.other_card then
					card_is_played = true
					break
				end
			end
			if not is_8_or_3(context.other_card) and card_is_played then
				local ctx = {
					cardarea = G.play,
					full_hand = G.play.cards,
					scoring_hand = context.scoring_hand,
					scoring_name = context.scoring_name,
					poker_hands = context.poker_hands
				}
				local cards_to_trigger = {}
				for _, v in ipairs(G.hand.cards) do
					if v:can_calculate() and is_8_or_3(v) then
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
			if is_8_or_3(context.other_card) and not card_is_played then
				local returns = { { xmult = card.ability.extra.xmult } }
				for _, v in ipairs(G.play.cards) do
					if is_8_or_3(v) then
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
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.fakeout_sprite = math.random(4)
	end,
    draw = function(self, card, layer)
        if (card.config.center.discovered or card.bypass_discovery_center) then
			local x_pos = card.ability.extra.fakeout_sprite + 2
			if card.area == G.jokers then x_pos = 7 end
			card.children.center:set_sprite_pos({x = x_pos, y = 13})
        end
    end,
})
