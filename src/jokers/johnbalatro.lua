SMODS.Joker({
	key = "johnbalatro",
	name = "John Balatro?",
	atlas = "mf_jokers",
	config = {
		extra = {
			loyalty = 1,
			uses = 1,
		},
	},
	pos = { x = 2, y = 9 },

	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,

	planeswalker = true,
	planeswalker_costs = { 1, -11 },
	default_loyalty_effects = true,

	pronouns = "she_her",

	attributes = { "mult", "modify_card", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "planeswalker_explainer", set = "Other", specific_vars = { 1 } }
	end,
	calculate = function(self, card, context) end,

	can_loyalty = function(card, idx)
		if idx == 1 then
			if #G.hand.highlighted ~= 5 then
				return false
			end
			for _, o_card in pairs(G.hand.highlighted) do
				if o_card.ability.perma_mult ~= 0 then
					return false
				end
			end
			return true
		elseif idx == 2 then
			return true
		end
		return false
	end,

	loyalty = function(card, idx)
		if idx == 1 then
			for i = 1, #G.hand.highlighted do
				o_card = G.hand.highlighted[i]
				o_card.ability.perma_mult = (o_card.ability.perma_mult or 0) + 4
				local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						play_sound("multhit1", percent, 0.6)
						G.hand.highlighted[i]:juice_up(0.3, 0.3)
						return true
					end,
				}))
			end
		elseif idx == 2 then
			if Jen then
				card:set_ability(G.P_CENTERS["j_mf_johnbalatro_super_ultra_mega_upgraded_deluxe"])
			else
				card:set_ability(G.P_CENTERS["j_mf_johnbalatrotrue"])
			end
			play_sound("mf_treethree")
			card:juice_up()
			G.jokers:unhighlight_all()
		end
	end,
})

return joker
