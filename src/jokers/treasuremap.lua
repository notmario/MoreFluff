SMODS.Joker {
    key = "treasuremap",
    name = "Treasure Map",
    atlas = "mf_jokers",
    config = {
        extra = {
            c_rounds = 0,
            rounds = 2,
            money = 13,
        }
    },
    pos = {x = 8, y = 3},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {vars = { center.ability.extra.c_rounds, center.ability.extra.rounds, center.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition  and not context.blueprint then
            card.ability.extra.c_rounds = card.ability.extra.c_rounds + 1
            if card.ability.extra.c_rounds >= card.ability.extra.rounds and (card.ability.extra.c_rounds - 1) < card.ability.extra.rounds then 
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.c_rounds < card.ability.extra.rounds) and (card.ability.extra.c_rounds..'/'..card.ability.extra.rounds) or localize('k_active_ex'),
            }
        end
        if (context.forcetrigger or (context.selling_self and (card.ability.extra.c_rounds >= card.ability.extra.rounds))) and not context.blueprint then
            return {
                dollars = card.ability.extra.money
            }
        end
    end
}