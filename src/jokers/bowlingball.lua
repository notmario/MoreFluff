SMODS.Joker {
    key = "bowlingball",
    name = "Bowling Ball",
    atlas = "mf_jokers",
    config = {
        extra = {chips=60, mult=10}
    },
	mf_art_credit = "footlongdingledong",
    pos = {x = 9, y = 2},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chips, center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 3 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
}