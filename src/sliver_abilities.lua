FLUFF.sliver_effects = {}

function FLUFF.get_sliver_abilities()
    local abilities = {}
    for _, card in ipairs(G.jokers.cards) do
        if card.config.center.mf_sliver_ability then
            abilities[#abilities + 1] = {
                key = card.config.center.mf_sliver_ability,
                extra = card.ability.extra
            }
        end
    end
    return abilities
end

local old_add_multiboxes = FLUFF.add_extra_multiboxes
function FLUFF.add_extra_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    old_add_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    if G.jokers and _c.set == "Joker" and FLUFF.has_attribute(_c.key, "sliver") then
        for _, sliver_effect in ipairs(FLUFF.get_sliver_abilities()) do
            default_text = nil
            if G.localization.descriptions.Other["mf_"..sliver_effect.key] then default_text = G.localization.descriptions.Other["mf_"..sliver_effect.key].text end
            FLUFF.sliver_effects[sliver_effect.key].add_box(sliver_effect.extra, default_text)(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        end
    end
end


local old_add_effects = FLUFF.calculate_extra_effects
function FLUFF.calculate_extra_effects(card, context, jokers, triggered, ...)
    jokers, triggered = old_add_effects(card, context, jokers, triggered, ...)

    if FLUFF.has_attribute(card, "sliver") then
        for _, sliver_effect in ipairs(FLUFF.get_sliver_abilities()) do
            jokers, triggered = FLUFF.sliver_effects[sliver_effect.key].calculate(jokers, triggered, context, card, sliver_effect.extra)
        end
    end

    return jokers, triggered
end