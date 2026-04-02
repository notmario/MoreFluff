SMODS.Joker({
	key = "trianglewalker",
	name = "Triangle, Planeswalker",
	atlas = "mf_jokers",
	config = {
		extra = {
			loyalty = 3,
			uses = 1,
		},
	},
	pos = { x = 0, y = 9 },

	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,

	planeswalker = true,
	planeswalker_costs = { 2, -3, -11 },
	default_loyalty_effects = true,

	pronouns = "she_they",
	attributes = { "destroy_card", "modify_card", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "planeswalker_explainer", set = "Other", specific_vars = { 3 } }
	end,
	calculate = function(self, card, context) end,

	can_loyalty = function(card, idx)
		if idx == 1 then
			return #G.hand.cards >= 1
		elseif idx == 2 then
			return #G.hand.highlighted >= 1 and #G.hand.highlighted <= 3
		elseif idx == 3 then
			return #G.hand.highlighted >= 1 and #G.hand.highlighted <= 3
		else
			return false
		end
	end,

	loyalty = function(card, idx)
		if idx == 1 then
			SMODS.draw_cards(3)
		elseif idx == 2 then
			destroyed_cards = {}
			for i = #G.hand.highlighted, 1, -1 do
				destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
			end
			SMODS.destroy_cards(destroyed_cards)
		elseif idx == 3 then
			for i = 1, #G.hand.highlighted do
				local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						G.hand.highlighted[i]:flip()
						play_sound("tarot2", percent, 0.6)
						G.hand.highlighted[i]:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						G.hand.highlighted[i]:set_edition("e_polychrome")
						return true
					end,
				}))
			end
			delay(0.2)
			for i = 1, #G.hand.highlighted do
				local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						G.hand.highlighted[i]:flip()
						play_sound("tarot2", percent, 0.6)
						G.hand.highlighted[i]:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
		end
	end,
})
