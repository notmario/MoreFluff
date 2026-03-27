SMODS.Joker {
    key = "grep",
    name = "grep",
    atlas = "mf_jokers",
    config = {
        extra = {}
    },
    pos = {x = 6, y = 8},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
            local rank = context.full_hand[1]:get_id()
            local suit = context.full_hand[1].base.suit
            table.sort(G.deck.cards, function(a,b)
                if ((b:get_id() == rank or b.base.suit == suit) and not (a:get_id() == rank or a.base.suit == suit))then
                    return true
                else
                    return false
                end
            end)
            local found_count = 0
            for _, other_card in pairs(G.deck.cards) do
                if other_card:get_id() == rank or other_card.base.suit == suit then
                    found_count = found_count + 1
                end
            end
            return {
				message = localize({ type = "variable", key = "a_searched", vars = { found_count } }),
            }
        end
    end
}
