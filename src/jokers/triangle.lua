SMODS.Joker {
    key = "triangle",
    name = "Triangle",
    atlas = "mf_jokers",
    config = {
        extra = {
            x_mult = 3,
        }
    },
    pos = {x = 9, y = 4},
    soul_pos = {x = 9, y = 5},
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pronouns = "she_they",
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.x_mult }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.scoring_name == "Three of a Kind" then
            return {
                x_mult = card.ability.extra.x_mult,
                colour = G.C.RED,
                card = card
            }
        end
        if context.forcetrigger then
            return {
                xmult = card.ability.extra.x_mult,
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" },
                    },
                },
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "hand" },
                { text = ")" },
            },
            calc_function = function(card)
                local mult = 1
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                local _, _, _, _, non_loc_disp_text = G.FUNCS.get_poker_hand_info(scoring_hand)
                if non_loc_disp_text == "Three of a Kind" then
                    if old_text ~= 'Unknown' then
                        for _, scoring_card in pairs(scoring_hand) do
                            mult = mult * card.ability.extra.x_mult ^ JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.x_mult = mult
                card.joker_display_values.hand = localize("Three of a Kind", 'poker_hands')
            end,
        }
    end,
}