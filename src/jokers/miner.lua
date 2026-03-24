SMODS.Joker {
	key = "miner",
	name = "Miner",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 1, y = 1 },
	cost = 5,
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
		if context.setting_blind and context.blind.boss and not self.getting_sliced then
			G.E_MANAGER:add_event(Event {
				func = function()
					add_tag(Tag "tag_d_six")
					play_sound("generic1", 0.6 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.1 + math.random() * 0.1, 0.4)
					return true
				end,
			})
		end
	end,
}
