SMODS.Joker {
    key = "bloodpact",
    name = "Blood Pact",
    atlas = "mf_jokers",
    config = {
        extra = { xmult = 5 },
    },
	mf_art_credit = "footlongdingledong",
    pos = {x = 2, y = 3},
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.xmult }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.full_hand ~= nil then
            local non_hearts = 0
            for k, v in ipairs(context.full_hand) do
                if not v:is_suit('Hearts', nil, true) then
                    non_hearts = non_hearts + 1
                end
            end
            if non_hearts > 0 then
                if not context.blueprint then
                    SMODS.destroy_cards { card }
                    return {
                        message = localize('k_extinct_ex')
                    }
                end
            else
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end
    end
}