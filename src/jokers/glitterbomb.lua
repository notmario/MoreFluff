SMODS.Joker {
	key = "glitterbomb",
	name = "Glitter Bomb",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 4, y = 0 },
	cost = 14,
	config = { extra = {} },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.selling_self then
			if #G.hand.cards >= 1 then
				for i, v in ipairs(G.hand.cards) do
					local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
					G.E_MANAGER:add_event(Event {
						trigger = "after",
						delay = 0.15,
						func = function()
							play_sound("card1", percent)
							G.hand.cards[i]:juice_up(0.3, 0.3)
							G.hand.cards[i]:flip()
							return true
						end,
					})
				end
				for i, v in ipairs(G.hand.cards) do
					local cen = SMODS.poll_enhancement { guaranteed = true, no_replace = true }
					local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
					G.E_MANAGER:add_event(Event {
						trigger = "after",
						delay = 0.15,
						func = function()
							play_sound("tarot2", percent)
							G.hand.cards[i]:set_ability(cen)
							G.hand.cards[i]:flip()
							return true
						end,
					})
				end
			else
				return {
					message = localize "k_nope_ex",
					colour = G.C.PURPLE,
				}
			end
		end
	end,
}
