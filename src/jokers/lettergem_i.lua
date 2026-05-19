SMODS.Joker({
	key = "lettergem_i",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 1 * 2,
	pos = { x = 9, y = 3 },
	config = { extra = { straight_mult = 2 } },
	attributes = { "hand_type", "xmult", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.straight_mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			for _, hand in pairs(context.poker_hands["Straight"]) do
				if #hand >= 5 then
					return {
						xmult = card.ability.extra.straight_mult,
					}
				end
			end
		end
	end,
})

local smods_four_fingers_ref = SMODS.four_fingers
function SMODS.four_fingers(hand_type)
	local val = smods_four_fingers_ref(hand_type)
	if next(SMODS.find_card("j_mf_lettergem_i")) and hand_type == "straight" then
		return math.max(1, val - 2)
	end
	return val
end
