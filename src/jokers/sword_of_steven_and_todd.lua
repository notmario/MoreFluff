SMODS.Joker {
	key = "sword_of_steven_and_todd",
	name = "Sword of Steven and Todd",
	atlas = "mf_jokers",
	config = {
		extra = {
            mult = 4,
            chips = 31,
        },
	},
	pos = { x = 8, y = 16 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "mult", "chips", "debuff", "face_down", "rank", "ace", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
            },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			local rets = {}
			local id = context.other_card:get_id()

			if id <= 10 and id >= 0 and id % 2 == 0 then
				rets[#rets + 1] = {
					mult = card.ability.extra.mult,
				}
			end
			if (id <= 10 and id >= 0 and id % 2 == 1) or (id == 14) then
				rets[#rets + 1] = {
					chips = card.ability.extra.chips,
				}
			end
			return SMODS.merge_effects(rets)
		end
	end,
}

local card_flip = Card.flip
function Card:flip(...)
    if self.facing == 'back' or not (self.ability.set == "Joker" and next(SMODS.find_card("j_mf_sword_of_steven_and_todd"))) then
        card_flip(self, ...)
    end
end