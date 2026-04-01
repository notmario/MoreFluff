SMODS.Joker({
	key = "burnerphone",
	name = "Burner Phone",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 5, y = 1 },
	cost = 2,
	config = { extra = {} },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "passive", "full_deck", },
	loc_vars = function(self, info_queue, center)
		if not G.deck or not G.deck.cards or #G.deck.cards == 0 then
			return {
				vars = {
					"no ",
					"cards ",
					"left,",
					"the deck ",
					"is ",
					"empty",
					colours = {
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
					},
				},
			}
		end
		if not next(SMODS.find_card("j_mf_burnerphone")) then
			return {
				vars = {
					"is ",
					"not ",
					"owned,",
					"you ",
					"get ",
					"nothing",
					colours = {
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
					},
				},
			}
		end
		local cardlist = G.deck.cards
		if #cardlist == 1 then
			local card = cardlist[#cardlist]

			local rank = localize(card.base.value, "ranks") .. " "
			local rank_col = G.C.FILTER
			if SMODS.has_no_rank(card) then
				rank = localize("k_rankless")
				rank_col = G.C.UI.TEXT_INACTIVE
			end
			local suit = localize(card.base.suit, "suits_plural")
			local suit_col = G.C.SUITS[card.base.suit]
			if SMODS.has_no_suit(card) then
				suit = localize("k_suitless")
				rank_col = G.C.UI.TEXT_INACTIVE
			end
			return {
				vars = {
					rank,
					"of ",
					suit,
					"that ",
					"is ",
					"all",
					colours = {
						rank_col,
						G.C.UI.TEXT_DARK,
						suit_col,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
						G.C.UI.TEXT_INACTIVE,
					},
				},
			}
		end

		local texts = {}
		local colours = {}
		for i = 0, 1 do
			local card = cardlist[#cardlist - i]
			local rank = localize(card.base.value, "ranks") .. " "
			local rank_col = G.C.FILTER
			if SMODS.has_no_rank(card) then
				rank = localize("k_rankless")
				rank_col = G.C.UI.TEXT_INACTIVE
			end
			local suit = localize(card.base.suit, "suits_plural")
			local suit_col = G.C.SUITS[card.base.suit]
			if SMODS.has_no_suit(card) then
				suit = localize("k_suitless")
				rank_col = G.C.UI.TEXT_INACTIVE
			end
			table.insert(texts, rank)
			table.insert(texts, "of ")
			table.insert(texts, suit)
			table.insert(colours, rank_col)
			table.insert(colours, G.C.UI.TEXT_DARK)
			table.insert(colours, suit_col)
		end
		texts.colours = colours
		return { vars = texts }
	end,
})
