local joker = {
  name = "Golden Carrot",
  config = {
    extra = { mult = 10, coeff = 7, dilation = 8 }
  },
  pos = {x = 1, y = 1},
  rarity = 1,
  cost = 5,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_txt = {
    name = "Spiral Joker",
    text = {
      "{C:mult}+(#1#+#2#cos(pi/#3# x {C:attention}$${C:mult})){} Mult",
      "{C:inactive}({C:attention}$${C:inactive} is your current money)",
      "{C:inactive}(Currently gives {C:mult}+#4#{C:inactive} Mult)"
    }
  },
  loc_vars = function(self, info_queue, center)
    local cash = to_number(G.GAME.dollars) or 0
    local val = center.ability.extra.mult + math.floor(center.ability.extra.coeff * math.cos(math.pi/center.ability.extra.dilation * cash) + 0.5)
    return {
      vars = { center.ability.extra.mult, center.ability.extra.coeff, center.ability.extra.dilation, val }
    }
  end,

  calculate = function(self, card, context)
    if context.cardarea == G.jokers and not context.before and not context.after then
      local cash = to_number(G.GAME.dollars) or 0
      local val = card.ability.extra.mult + math.floor(card.ability.extra.coeff * math.cos(math.pi/card.ability.extra.dilation * cash) + 0.5)
        return {
          message = localize{type='variable',key='a_mult',vars={val}},
          mult_mod = val
        }
    end
  end
}

if JokerDisplay then
  JokerDisplay.Definitions["j_mf_spiral"] = {
    text = {
      { text = "+", colour = G.C.MULT },
      { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
    },
    calc_function = function(card)
      local cash = to_number(G.GAME.dollars) or 0
      card.joker_display_values.mult = card.ability.extra.mult + math.floor(card.ability.extra.coeff * math.cos(math.pi/card.ability.extra.dilation * cash) + 0.5)
    end,
  }
end

return joker
