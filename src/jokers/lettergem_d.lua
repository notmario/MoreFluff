SMODS.Joker {
	key = "lettergem_d",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	no_shader_on_modbadge = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 2 * 2,
	pos = { x = 4, y = 3 },
	config = { extra = { cards_per_round = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local cards = {}
			for i, v in pairs(G.playing_cards) do
				if not SMODS.is_eternal(v) then
					cards[#cards + 1] = v
				end
			end
			local num = card.ability.extra.cards_per_round
			pseudoshuffle(cards, "letter_d")
			for i = 1, num do
				local card = cards[i]
				card.area:remove_card(card)
				SMODS.destroy_cards(card)
			end
		end
	end,
	-- tech from ellejokers  ty elle
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

		local s = G.TILESCALE * G.TILESIZE
		local destroy_sprite = SMODS.create_sprite(0, 0, 259 / s, 79 / s, "mf_lettergem_destroy", { x = 0, y = 0 })

		local destroy = {
			{
				n = G.UIT.O,
				config = { align = "cm", object = destroy_sprite },
			},
		}

		full_UI_table.main[1] = destroy
	end,
}
