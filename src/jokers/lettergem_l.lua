SMODS.Joker({
	key = "lettergem_l",
	atlas = "mf_letterjokers",
    display_size = { h = 78 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_letter",
	cost = 1 * 2,
	pos = { x = 2, y = 1 },
	config = { extra = { odds = 3 } },
	attributes = { "modify_card", "mod_chance", "position", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.check_enhancement and #G.play.cards > 0 and context.other_card == G.play.cards[1] then
    		return {
    			m_lucky = true,
    		}
		end
		if context.mod_probability and #G.play.cards > 0 and context.trigger_obj == G.play.cards[1] then
    		return {
    			numerator = context.numerator * card.ability.extra.odds,
    			denominator = context.denominator,
    		}
		end
	end,
})
