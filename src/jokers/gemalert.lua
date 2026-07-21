SMODS.Joker({
	key = "gemalert",
	name = "Gem Alert",
	atlas = "mf_jokers",
	config = {
        extra = {
            xmult_per = 0.1,
            xmult = 1,
            rate_mod = 6.7,
        }
    },
	mf_art_credit = "Incognito",
	pos = { x = 0, y = 13 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "xmult", "joker", "rarity", },
	loc_vars = function(self, info_queue, card)
	    return {
	        vars = { card.ability.extra.xmult_per, card.ability.extra.xmult, card.ability.extra.rate_mod }
	    }
	end,
	calculate = function(self, card, context)
        if context.modify_shop_card and context.card.ability.set == "Joker" then
            if context.card.edition or context.card:is_rarity("Rare") and not context.blueprint then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "xmult_per",
                    message_key = "a_xmult",
                })
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.rare_mod = G.GAME.rare_mod * card.ability.extra.rate_mod
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.rare_mod = G.GAME.rare_mod / card.ability.extra.rate_mod
	end,
	draw = function(self, card, layer)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		card.children.center:set_sprite_pos({x = 6, y = 18})
		card.children.center:draw_shader("polychrome", nil, card.ARGS.send_to_shader, notilt, card.children.center)
		card.children.center:set_sprite_pos({x = 0, y = 13})
	end,
})
