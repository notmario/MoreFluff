SMODS.Joker({
	key = "mrloans",
	name = "Mr. Loans",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 7, y = 1 },
	cost = 4,
	config = { extra = {} },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "prevents_death", "economy", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and context.game_over then
			ease_dollars(G.GAME.chips - G.GAME.blind.chips)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					play_sound("tarot1")
					-- self:start_dissolve()
					return true
				end,
			}))
			return {
				saved = "k_saved_mrloans",
				colour = G.C.PURPLE,
			}
		end
	end,
})
