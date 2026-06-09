SMODS.Joker {
	key = "crad_shuffler",
	name = "Crad Shuffler",

	atlas = "mf_purple",
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 7,
	pos = { x = 1, y = 0 },
	config = { extra = { } },
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", "tarot", },
	calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.01,
                func = function()
                    G.deck:shuffle()
                    return true
                end,
            }))
            return {
                message = localize('k_shuffled_ex'),
                colour = G.C.PURPLE
            }
        end
        if context.mf_add_to_hand then
            for i = 1, 3 do
                for _, other_card in ipairs(G.deck.cards) do
                    if not other_card.mf_added_to_hand then
                        other_card.mf_added_to_hand = true
                        other_card.mf_return_to_bottom_of_deck = true
                        
                        FLUFF.add_to_hand[#FLUFF.add_to_hand + 1] = other_card
                        break
                    end
                end
            end
        end
	end,
}

-- local gfdfptd = G.FUNCS.draw_from_play_to_discard

-- G.FUNCS.draw_from_play_to_discard = function(e)
--     local tuck_cards = {}
--     local non_tuck_cards = {}
--     for k, v in ipairs(G.play.cards) do
--         if (not v.shattered) and (not v.destroyed) and v.mf_return_to_bottom_of_deck then 
--             tuck_cards[#tuck_cards + 1] = v
--             v.mf_return_to_bottom_of_deck = nil
--         else
--             non_tuck_cards[#non_tuck_cards + 1] = v
--         end
--     end

--     G.play.cards = non_tuck_cards

--     for it = 1, #tuck_cards do
--         local ind = #tuck_cards - it + 1
--         local v = tuck_cards[ind]
--         -- draw_card(G.play, G.deck, it*10/#tuck_cards,'down', false, v)
--         G.play:remove_card(v)
--         G.deck:emplace(v)
--         G.VIBRATION = G.VIBRATION + 0.6
--         play_sound('card1', 0.85 + it*0.02/#tuck_cards, 0.6)
--     end

--     gfdfptd(e)
-- end