SMODS.Joker {
	key = "digital_exclusive",
	name = "Alchemy Joker",
	atlas = "mf_jokers",
	config = {},
	pos = { x = 2, y = 16 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	attributes = { "generation", "joker", "on_sell", "rank", "jack", "exile", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if
			context.selling_self
		then
			local gained_slots = 1
			if card.edition and card.edition.card_limit then
				gained_slots = 1 - card.edition.card_limit
			end
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit + gained_slots then
                local created_card = SMODS.add_card {
                    set = "Joker",
                    attributes = { "passive" },
                }
                created_card.ability.mf_alchemy_hit_the_road = (created_card.ability.mf_alchemy_hit_the_road or 0) + 1
			end
		end
	end,
}

local old_add_multiboxes = FLUFF.add_extra_multiboxes
function FLUFF.add_extra_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    old_add_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ...)
    if ability and ability.mf_alchemy_hit_the_road then
        local desc_text = G.localization.descriptions.Other.mf_alchemy_hit_the_road_perpetual.text
        for i = 1, ability.mf_alchemy_hit_the_road do
            FLUFF.generate_ui_multiboxes({
                {localized_text = desc_text}
            })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        end
    end
end

local ec = eval_card
function eval_card(card, context, ...)
    local ret, post = ec(card, context)

    if context.discard and context.other_card:get_id() == 11 then
        if not ret.jokers then ret.jokers = {} end
        for i = 1, (card.ability.mf_alchemy_hit_the_road or 0) do
			G.E_MANAGER:add_event(Event({
				func = function()
                    local copied_card = SMODS.copy_card(context.other_card)
                    FLUFF.exile_card(copied_card, nil, "ante")
					return true
				end,
			}))
        end
    end

    if context.joker_main then
        if not ret.jokers then ret.jokers = {} end
        for i = 1, (card.ability.mf_alchemy_hit_the_road or 0) do
            ret.jokers = SMODS.merge_effects({ ret.jokers, { xmult = 1 + #G.mf_exile.cards * 0.25 }})
        end
    end

    return ret, post
end