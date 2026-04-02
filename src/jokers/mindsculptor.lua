SMODS.Joker({
	key = "mindsculptor",
	name = "Jimbo, the Mind Sculptor",
	atlas = "mf_jokers",
	config = {
		extra = {
			loyalty = 3,
			uses = 1,
		},
	},
	pos = { x = 1, y = 9 },
	mf_art_credit = "Ice",

	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,

	planeswalker = true,
	planeswalker_costs = { 2, 0, -1, -12 },
	default_loyalty_effects = true,

	attributes = { "destroy_card", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { key = "planeswalker_explainer", set = "Other", specific_vars = { 3 } }
	end,
	calculate = function(self, card, context) end,

	can_loyalty = function(card, idx)
		if idx == 1 then
			return #G.hand.cards > 0
		elseif idx == 2 then
			return #G.hand.cards > 0
		elseif idx == 3 then
			return #G.hand.cards > 0
		elseif idx == 4 then
			return true
		end
		return false
	end,

	loyalty = function(card, idx)
		if idx == 1 then
			SMODS.draw_cards(1)
		elseif idx == 2 then
			SMODS.draw_cards(4)
			for i = 1, 3 do --draw cards from deck
				draw_card(G.hand, G.deck, i * 100 / 3, "down", nil, nil, 0.08)
			end
			G.deck:shuffle("jace" .. G.GAME.round_resets.ante)
		elseif idx == 3 then
			local hand_count = #G.hand.cards
			for i = 1, hand_count do --draw cards from deck
				draw_card(G.hand, G.deck, i * 100 / hand_count, "down", nil, nil, 0.08)
			end
			G.deck:shuffle("jace" .. G.GAME.round_resets.ante)
		elseif idx == 4 then
			local d_c = {}
			for _, card in pairs(G.deck.cards) do
				d_c[#d_c + 1] = card
			end

			SMODS.destroy_cards(d_c)
		end
	end,
})
