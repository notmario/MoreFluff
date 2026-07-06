SMODS.Joker({
	key = "phyrexian_banner",
	name = "Phyrexian Banner",
	atlas = "mf_jokers",
	config = {
		extra = { poisonous = 1 },
	},
	pos = { x = 7, y = 16 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "joker", "score", },
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.poisonous,

                colours = {
                    darken(G.C.GREEN, 0.2)
                }
            }
        }
	end,
	calculate = function(self, card, context)
        -- does this ever trigger ? lol :p
		if context.post_trigger and card == context.other_card then
			return {
                score = G.GAME.blind.chips / 100 * card.ability.extra.poisonous,
                colour = darken(G.C.GREEN, 0.2),
				sound = "mf_poison"..math.random(2),
            }
		end
	end,
})

local old_add_multiboxes = FLUFF.add_extra_multiboxes
function FLUFF.add_extra_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    old_add_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
    if G.jokers and _c.set == "Joker" then
        local phyrexian_poison_count = #SMODS.find_card("j_mf_phyrexian_banner")
        if _c.key == "j_mf_phyrexian_banner" then
            -- Hate.
            phyrexian_poison_count = phyrexian_poison_count - 1
        end
        if phyrexian_poison_count >= 2 then
            local desc_text = G.localization.descriptions.Other.mf_phyrexian_poison_bigstack.text
            FLUFF.generate_ui_multiboxes({
                {
                    localized_text = desc_text,
                    loc_vars = function(self, card, center)
                        return { vars = { 1, phyrexian_poison_count, colours = {
                            darken(G.C.GREEN, 0.2)
                        } } }
                    end
                }
            })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        else
            local desc_text = G.localization.descriptions.Other.mf_phyrexian_poison.text
            for i = 1, phyrexian_poison_count do
                FLUFF.generate_ui_multiboxes({
                    {
                        localized_text = desc_text,
                        loc_vars = function(self, card, center)
                            return { vars = { 1, colours = {
                                darken(G.C.GREEN, 0.2)
                            } } }
                        end
                    }
                })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
            end
        end
    end
end

local ec = eval_card
function eval_card(card, context, ...)
    local ret, post = ec(card, context)

    if context.post_trigger and card == context.other_card and G.GAME.blind and G.GAME.blind.in_blind then
        if not ret.jokers then ret.jokers = {} end
        local phyrexian_poison_count = #SMODS.find_card("j_mf_phyrexian_banner")
        if card.config.center_key == "j_mf_phyrexian_banner" then
            -- Hate.
            phyrexian_poison_count = phyrexian_poison_count - 1
        end
        for i = 1, phyrexian_poison_count do
            ret.jokers = SMODS.merge_effects({ ret.jokers, {
                score = G.GAME.blind.chips / 100,
                colour = darken(G.C.GREEN, 0.2),
				sound = "mf_poison"..math.random(2),
                message_card = card,
            }})
        end
    end

    return ret, post
end