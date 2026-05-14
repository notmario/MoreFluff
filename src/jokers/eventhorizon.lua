local is_8_or_3 = function(card)
	return (card:get_id() == 8) or (card:get_id() == 3)
end
SMODS.Joker({
	key = "eventhorizon",
	name = "Disintegration Loop",
	config = {
		extra = {
            req = 5,
			cur = 0,
			bosses_left = 1,
		},
	},
	pos = { x = 0, y = 14 },
	atlas = "mf_jokers",
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    no_collection = true,
	attributes = { "rank", "eight", "three", },
	loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.req, card.ability.extra.cur, card.ability.extra.bosses_left }
        }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra.bosses_left = card.ability.extra.bosses_left - 1
			if
				card.ability.extra.bosses_left <= 0
			then
                card:set_ability(G.P_CENTERS["j_mf_crimsonglassdecomposition"])
                card:juice_up()
                G.jokers:unhighlight_all()

                return {
                    message = localize "k_transformed_ex"
                }
			end
			return {
				message = ""..card.ability.extra.bosses_left
			}
		end
		if context.individual and context.cardarea == G.play then
			if is_8_or_3(context.other_card) then
                card.ability.extra.one = 1
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "cur",
                    scalar_value = "one",
                    no_message = true,
                })
                if card.ability.extra.cur >= card.ability.extra.req then
                    card.ability.extra.cur = card.ability.extra.cur - card.ability.extra.req
                    local _poker_hands = {}

                    for handname, _ in pairs(G.GAME.hands) do
                        if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                            _poker_hands[#_poker_hands + 1] = handname
                        end
                    end

                    local selected_hand = pseudorandom_element(_poker_hands, 'mf_eventhorizon')
                    SMODS.smart_level_up_hand(card, selected_hand, false, 1, nil)
                    return nil, true
                else
                    return {
                        message = card.ability.extra.cur.."/"..card.ability.extra.req
                    }
                end
            end
        end
	end,
})