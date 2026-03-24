SMODS.Joker {
	key = "aceupthesleeve",
	name = "Ace Up the Sleeve",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 4, y = 1 },
	cost = 6,
	config = { extra = {} },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.after and G.GAME.current_round.hands_left == 1 and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event {
				trigger = "after",
				delay = 0.1,
				func = function()
					local cen = SMODS.poll_enhancement { guaranteed = true, no_replace = true }
					SMODS.add_card {
						set = "Base",
						rank = "Ace",
						enhancement = cen,
					}
					return true
				end,
			})
		end
	end,
}
