SMODS.Joker {
	key = "suspension",
	name = "Suspension of Disbelief",
	atlas = "mf_jokers",
	config = {
		extra = {
            active = true,
        },
	},
	pos = { x = 7, y = 14 },
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "tarot", "rotarot", "consumable", "exile", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
        if context.using_consumeable and card.ability.extra.active 
		and (context.consumeable.ability.set == "Tarot" or context.consumeable.ability.set == "Rotarot")
		and not context.consumeable.ability.mf_suspended then
            card.ability.extra.active = false
			G.E_MANAGER:add_event(Event({
				func = function()
                    FLUFF.create_and_suspend_card( {
                        key = context.consumeable.config.center_key,
                        area = G.play
                    }, 1)
					return true
				end,
			}))
        end
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
		then
			card.ability.extra.active = true
			return {
				message = localize("k_active_ex"),
			}
		end
	end,
}