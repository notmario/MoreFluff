SMODS.Joker {
    key = "cba",
    name = "Card Buffer Advanced",
    atlas = "mf_jokers",
    config = {
        cba = true
    },
    pos = {x = 9, y = 1},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pools = { ["Meme"] = true },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { }
        }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
            retrigger_card = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].edition then
                retrigger_card = G.jokers.cards[i]
                break
                end
            end
            if retrigger_card == context.other_card then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
}