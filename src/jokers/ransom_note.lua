SMODS.Joker {
	key = "ransom_note",
	name = "Ransom Note",
	atlas = "mf_jokers",
	config = {},
	pos = { x = 9, y = 14 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", "retrigger" },
	calculate = function(self, card, context)
	end,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				card.area:remove_card(card)
				G.deck:emplace(card)
				card:remove_from_deck()
				card:set_ability("m_mf_ransom_note")
				SMODS.change_base(card, 'Spades', 'Ace')
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				card.playing_card = G.playing_card
				table.insert(G.playing_cards, card)
				G.deck:shuffle()
				return true
			end,
		}))
	end,
	-- tech from ellejokers  ty elle
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

		local s = G.TILESCALE * G.TILESIZE
		local destroy_sprite = SMODS.create_sprite(0, 0, 320 / s, 151 / s, "mf_ransomnote", { x = 0, y = 0 })

		local destroy = {
			{
				n = G.UIT.O,
				config = { align = "cm", object = destroy_sprite },
			},
		}

		full_UI_table.main[1] = destroy
	end,
}

SMODS.Enhancement {
	key = "ransom_note",
	atlas = "mf_jokers",
	pos = { x = 9, y = 14 },
	config = {},
	replace_base_card = true,
	no_rank = true,
    no_suit = true,
	always_scores = true,
    no_collection = true,
    in_pool = function(self, args)
        return false
    end,
	loc_vars = function(self, info_queue, card)
	end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = 2,
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            return {
				xmult = 2,
			}
        end
    end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

		local s = G.TILESCALE * G.TILESIZE
		local destroy_sprite = SMODS.create_sprite(0, 0, 320 / s, 151 / s, "mf_ransomnote", { x = 0, y = 0 })

		local destroy = {
			{
				n = G.UIT.O,
				config = { align = "cm", object = destroy_sprite },
			},
		}

		full_UI_table.main[1] = destroy
	end,
}