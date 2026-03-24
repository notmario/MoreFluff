SMODS.Joker({
	key = "rosetinted",
	name = "Rose-Tinted Glasses",
	config = {},
	pos = { x = 3, y = 0 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if
			context.destroying_card
			and not context.blueprint
			and #context.full_hand == 1
			and context.full_hand[1]:get_id() == 2
			and G.GAME.current_round.hands_played == 0
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag("tag_double"))
					play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
					return true
				end,
			}))
			return true
		end
		if context.forcetrigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag("tag_double"))
					play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
					return true
				end,
			}))
		end
	end,
})
