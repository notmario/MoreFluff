SMODS.Joker({
	key = "lettergem_v",
	atlas = "mf_letterjokers",
    display_size = { h = 78 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_letter",
	cost = 4 * 2,
	pos = { x = 3, y = 2 },
	config = { extra = {} },
	attributes = { "generation", "tag", },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.buying_card then
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag("tag_voucher"))
					play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
					return true
				end,
			}))
			return nil, true -- This is for Joker retrigger purposes
		end
	end,
})
