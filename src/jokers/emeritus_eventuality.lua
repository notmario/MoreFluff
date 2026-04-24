SMODS.Joker {
	key = "emeritus_eventuality",
	name = "Emeritus of Eventuality",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = true,
			round_hands = {

			},
		},
	},
	prepared_card = "c_black_hole",
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "spectral", "generation", "reset", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center and center.ability and center.ability.extra and localize(center.ability.extra.is_prepared and "k_prepared" or "k_unprepared") },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and (#card.ability.extra.round_hands > 0) then
			card.ability.extra.round_hands = {}
			return {
				message = "k_reset",
				colour = G.C.RED,
			}
		end
        if context.before then
            if (#context.scoring_hand > 3) and not card.ability.extra.round_hands[context.scoring_name] then
				card.ability.extra.round_hands[context.scoring_name] = "asdf"
				card.ability.extra.round_hands[#card.ability.extra.round_hands + 1] = "asdf"
				if (#card.ability.extra.round_hands == 3) and not card.ability.extra.is_prepared then
					card.ability.extra.is_prepared = true
					return {
						message = localize "k_prepared_ex"
					}
				else
					return {
						message = #card.ability.extra.round_hands .. "/" .. 3
					}
				end
			end
        end
	end,
}