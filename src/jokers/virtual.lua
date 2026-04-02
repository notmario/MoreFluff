SMODS.Joker({
	key = "virtual",
	name = "Virtual Joker",
	config = {
		extra = 3,
	},
	pos = { x = 8, y = 2 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_shader_on_modbadge = true,
	no_collection = true,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "xmult", "jokers", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if
			context.setting_blind
			and not self.getting_sliced
			and not (context.blueprint_card or card).getting_sliced
			and not context.blueprint
		then
			G.jokers:unhighlight_all()
			for k, v in ipairs(G.jokers.cards) do
				v:flip()
			end
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.jokers:shuffle("aajk")
							play_sound("cardSlide1", 0.85)
							return true
						end,
					}))
					delay(0.15)
					G.E_MANAGER:add_event(Event({
						func = function()
							G.jokers:shuffle("aajk")
							play_sound("cardSlide1", 1.15)
							return true
						end,
					}))
					delay(0.15)
					G.E_MANAGER:add_event(Event({
						func = function()
							G.jokers:shuffle("aajk")
							play_sound("cardSlide1", 1)
							return true
						end,
					}))
					delay(0.5)
					return true
				end,
			}))
		end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra,
			}
		end
	end,
})
