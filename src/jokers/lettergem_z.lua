SMODS.Joker({
	key = "lettergem_z",
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
	cost = 10 * 2,
	pos = { x = 6, y = 5 },
	config = { extra = {} },
	attributes = { "prevents_death", "destroy_card", },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over and context.main_eval and #G.playing_cards >= 13 then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand_text_area.blind_chips:juice_up()
					G.hand_text_area.game_chips:juice_up()
					play_sound("tarot1")
					return true
				end,
			}))
			local cards = {}
			for i, v in pairs(G.playing_cards) do
				if not SMODS.is_eternal(v) then
					cards[#cards + 1] = v
				end
			end
			local num = 13
			pseudoshuffle(cards, "letter_z")
			for i = 1, num do
				local card = cards[i]
				card.area:remove_card(card)
				SMODS.destroy_cards(card)
			end
			return {
				message = localize("k_saved_ex"),
				saved = "k_zenith",
				colour = G.C.RED,
			}
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

		full_UI_table.main[2] = destroy
	end,
})
