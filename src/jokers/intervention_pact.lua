SMODS.Joker {
	key = "intervention_pact",
	name = "Intervention Pact",
	atlas = "mf_jokers",
	config = {
		extra = {
            cards = 23,
        },
	},
	pos = { x = 5, y = 15 },

	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { "prevents_death", "exile", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over and context.main_eval then
			local real_count = #G.playing_cards
			for _, other_card in pairs(G.mf_exile.cards) do
				if other_card.playing_card then
					real_count = real_count - 1
				end
			end
			if real_count >= card.ability.extra.cards then
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
				pseudoshuffle(cards, "letter_z")
				local i = 0
				local j = 1
				while i < card.ability.extra.cards do
					if cards[j].area ~= G.mf_exile then
						i = i + 1
						FLUFF.exile_card(cards[j], i / card.ability.extra.cards)
					end
					j = j + 1
				end
				return {
					message = localize("k_saved_ex"),
					saved = "k_intervention_pact",
					colour = G.C.RED,
				}
			end
		end
    end,
}