SMODS.Joker {
	key = "shopping_spree",
	name = "Shopping Spree",

	config = {
		extra = {
            rerolls = 0,
            reroll_cost = 2,

            skips = 0,
        },
	},
	atlas = "mf_jokers",
	rarity = 2,
	pos = { x = 6, y = 15 },
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "reroll", "shop", "skip", },
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.rerolls,
                card.ability.extra.reroll_cost,
                card.ability.extra.skips,
            }
        }
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint and card.ability.extra.rerolls < 10 then
            card.ability.extra.rerolls = card.ability.extra.rerolls + 1
            if card.ability.extra.rerolls >= 10 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.reroll_cost
                        G.GAME.current_round.reroll_cost = math.max(0,
                            G.GAME.current_round.reroll_cost - card.ability.extra.reroll_cost)
                        return true
                    end
                }))
                return {
                    message = localize "k_active_ex"
                }
            end
            return {
                message = card.ability.extra.rerolls .. "/10"
            }
        end
		if context.skip_blind and not context.blueprint and card.ability.extra.skips < 2 then
            card.ability.extra.skips = card.ability.extra.skips + 1
            if card.ability.extra.skips >= 2 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        change_shop_size(1)
                        return true
                    end
                }))
                return {
                    message = localize "k_active_ex"
                }
            end
            return {
                message = card.ability.extra.skips .. "/2"
            }
        end
	end,
	add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.rerolls >= 10 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.reroll_cost
                    G.GAME.current_round.reroll_cost = math.max(0,
                        G.GAME.current_round.reroll_cost - card.ability.extra.reroll_cost)
                    return true
                end
            }))
        end
        if card.ability.extra.skips >= 2 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_shop_size(1)
                    return true
                end
            }))
        end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.rerolls >= 10 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.reroll_cost
                    G.GAME.current_round.reroll_cost = math.max(0,
                        G.GAME.current_round.reroll_cost + card.ability.extra.reroll_cost)
                    return true
                end
            }))
        end
        if card.ability.extra.rerolls >= 2 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_shop_size(-1)
                    return true
                end
            }))
        end
	end,
}