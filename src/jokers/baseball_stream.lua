SMODS.Joker {
	key = "baseball_stream",
	name = "The Baseball Stream",
	atlas = "mf_jokers",
	config = {
		extra = {
            xmult = 1.25,
        },
	},
	pos = { x = 9, y = 16 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { "xmult", "joker", "rarity", },
	loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.xmult }
        }
	end,
	calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("Uncommon") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

local old_add_multiboxes = FLUFF.add_extra_multiboxes
function FLUFF.add_extra_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    old_add_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    if G.jokers and _c.set == "Joker" and (_c.rarity == 3 or _c.rarity == "Rare") then
        local baseball_stream_count = #SMODS.find_card("j_mf_baseball_stream")
        if _c.key == "j_mf_baseball_stream" then
            -- Hate.
            baseball_stream_count = baseball_stream_count - 1
        end
        if baseball_stream_count >= 2 then
            local desc_text = G.localization.descriptions.Other.mf_baseball_stream_bigstack.text
            FLUFF.generate_ui_multiboxes({
                {
                    localized_text = desc_text,
                    loc_vars = function(self, card, center)
                        return { vars = { 1.25, baseball_stream_count } }
                    end
                }
            })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        else
            local desc_text = G.localization.descriptions.Other.mf_baseball_stream.text
            for i = 1, baseball_stream_count do
                FLUFF.generate_ui_multiboxes({
                    {
                        localized_text = desc_text,
                        loc_vars = function(self, card, center)
                        return { vars = { 1.25 } }
                        end
                    }
                })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
            end
        end
    end
end

local old_add_effects = FLUFF.calculate_extra_effects
function FLUFF.calculate_extra_effects(card, context, jokers, triggered, ...)
    jokers, triggered = old_add_effects(card, context, jokers, triggered, ...)
    
    if context.other_joker and card:is_rarity("Rare") and context.other_joker:is_rarity("Uncommon") then
        if not jokers then jokers = {} end
        local baseball_stream_count = #SMODS.find_card("j_mf_baseball_stream")
        if card.config.center_key == "j_mf_baseball_stream" then
            -- Hate.
            baseball_stream_count = baseball_stream_count - 1
        end
        for i = 1, baseball_stream_count do
            jokers = SMODS.merge_effects({ jokers, {
                xmult = 1.25
            }})
        end
    end
    return jokers, triggered
end