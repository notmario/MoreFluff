SMODS.Joker {
    key = "luckycharm",
    name = "Lucky Charm",
    atlas = "mf_jokers",
    config = {
        extra = {mult_chance = 3, mult = 20, money_chance = 8, money = 20}
    },
    pos = {x = 8, y = 1},
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, 1, center.ability.extra.mult_chance, 'luckycharm_mult')
        local new_numerator_2, new_denominator_2 = SMODS.get_probability_vars(center, 1, center.ability.extra.money_chance, 'luckycharm_money')
        return {
            vars = {new_numerator, new_denominator, center.ability.extra.mult, new_numerator_2, new_denominator_2, center.ability.extra.money}
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                dollars = card.ability.extra.money,
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'lucky_charm_money', 1, card.ability.extra.money_chance, 'lucky_charm_money') then
                return {
                    dollars = card.ability.extra.money
                }
            end
        end
        
        if context.cardarea == G.jokers and context.joker_main  then
            if SMODS.pseudorandom_probability(card, 'lucky_charm_mult', 1, card.ability.extra.mult_chance, 'lucky_charm_mult') then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}