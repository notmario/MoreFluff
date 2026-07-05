SMODS.Joker {
	key = "riding_the_dilu_horse",
	name = "Riding the Dilu Horse",
	atlas = "mf_jokers",
	config = {
        extra = {}
    },
	pos = { x = 3, y = 16 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	attributes = { "modify_card", "boss_blind", "retrigger", "position", },
	loc_vars = function(self, info_queue, card)
		return {}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
			right_card = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					right_card = G.jokers.cards[i + 1]
				end
			end
            if right_card then
                right_card.ability.mf_dilu_horse = (right_card.ability.mf_dilu_horse or 0) + 1
            end
            return {
                message = localize "k_horsed_ex",
                colour = G.C.GREEN
            }
		end
		if context.repetition and context.cardarea == G.play then
            local my_ind = 0
            local their_ind = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					my_ind = i
				end
			end
            for i = 1, #G.play.cards do
				if G.play.cards[i] == context.other_card then
					their_ind = i
				end
            end
            if my_ind == their_ind then
                return {
                    repetitions = 1,
                }
            end
		end
	end,
}

local old_add_multiboxes = FLUFF.add_extra_multiboxes
function FLUFF.add_extra_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    old_add_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    if ability and ability.mf_dilu_horse then
        if ability.mf_dilu_horse >= 5 then
            local desc_text = G.localization.descriptions.Other.mf_dilu_horse_bigstack.text
            FLUFF.generate_ui_multiboxes({
                {
                    localized_text = desc_text,
					loc_vars = function(self, card, center)
						return { vars = { ability.mf_dilu_horse } }
					end
                }
            })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        else
            local desc_text = G.localization.descriptions.Other.mf_dilu_horse.text
            for i = 1, ability.mf_dilu_horse do
                FLUFF.generate_ui_multiboxes({
                    {
                        localized_text = desc_text
                    }
                })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
                desc_text = G.localization.descriptions.Other.mf_dilu_horse_second.text
            end
        end
    end
end

local ec = eval_card
function eval_card(card, context, ...)
    local ret, post = ec(card, context)

    if context.repetition and context.cardarea == G.play and card.ability.mf_dilu_horse ~= 0 then
        local my_ind = 0
        local their_ind = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_ind = i
            end
        end
        for i = 1, #G.play.cards do
            if G.play.cards[i] == context.other_card then
                their_ind = i
            end
        end
        if my_ind == their_ind then
            if not ret.jokers then ret.jokers = {} end
            ret.jokers = SMODS.merge_effects({ ret.jokers, { repetitions = card.ability.mf_dilu_horse }})
        end
    end

    return ret, post
end