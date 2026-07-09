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
            FLUFF.sliver_effects[sliver_effect.key].add_box(sliver_effect.extra)(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        end
    end
end

local ec = eval_card
function eval_card(card, context, ...)
    local ret, post = ec(card, context)

    if FLUFF.has_attribute(card, "sliver") then
        for _, sliver_effect in ipairs(FLUFF.get_sliver_abilities()) do
            FLUFF.sliver_effects[sliver_effect.key].calculate(ret, post, context, card, sliver_effect.extra)
        end
    end

    return ret, post
end