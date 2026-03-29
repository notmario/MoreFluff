SMODS.Joker({
	key = "philosophical",
	name = "Philosophical Joker",
	atlas = "mf_jokers",
	config = {
		extra = { slots = 1 },
	},
	pos = { x = 4, y = 0 },
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.slots },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end
})

local old_g_funcs_check_for_buy_space = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
  if card.ability.name == "Philosophical Joker" and card.ability.card_limit >= 1 then
    return true
  end
  return old_g_funcs_check_for_buy_space(card)
end

local old_g_funcs_can_select_card = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
  if e.config.ref_table.ability.name == "Philosophical Joker" and e.config.ref_table.ability.card_limit >= 1 then 
    e.config.colour = G.C.GREEN
    e.config.button = 'use_card'
  else
    old_g_funcs_can_select_card(e)
  end
end