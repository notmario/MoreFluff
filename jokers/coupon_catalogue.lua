local joker = {
  name = "Coupon Catalogue",
  config = {
    extra = { mult = 15 }
  },
  pos = {x = 2, y = 0},
  rarity = 2,
  cost = 7,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_txt = {
    name = "Coupon Catalogue",
    text = {
      "{C:mult}+#1#{} Mult for each",
      "{C:attention}Voucher{} purchased",
      "this run",
      "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
    }
  },
  loc_vars = function(self, info_queue, center)
    local redeemed = 0
    for k,v in pairs(G.GAME.used_vouchers) do
      if v == true then
        redeemed = redeemed + 1
      end
    end
    return {
      vars = { center.ability.extra.mult, redeemed * center.ability.extra.mult }
    }
  end,
  calculate = function(self, card, context)
    if context.joker_main and context.cardarea == G.jokers and context.joker_main then
      local redeemed = 0
      for k,v in pairs(G.GAME.used_vouchers) do
        if v == true then
          redeemed = redeemed + 1
        end
      end
      if redeemed > 0 and card.ability.extra.mult then
        return {
          message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult * to_big(redeemed)}},
          mult_mod = card.ability.extra.mult * to_big(redeemed)
        }
      end
    end
  end
}

if JokerDisplay then
  JokerDisplay.Definitions["j_mf_coupon_catalogue"] = {
    text = {
      { text = "+", colour = G.C.MULT },
      { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
    },
    reminder_text = {
      { text = "(", color = G.C.INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "mult_base", color = G.C.INACTIVE },
      { text = " ", color = G.C.INACTIVE },
      { ref_table = "card.joker_display_values", ref_value = "reminder_text", color = G.C.INACTIVE },
      { text = ")", color = G.C.INACTIVE },
    },
    calc_function = function(card)
      local redeemed = 0
      for k,v in pairs(G.GAME.used_vouchers) do
        if v == true then
          redeemed = redeemed + 1
        end
      end
      card.joker_display_values.mult = card.ability.extra.mult * redeemed
      card.joker_display_values.mult_base = card.ability.extra.mult
      card.joker_display_values.reminder_text = localize("k_display_per_voucher")
    end,
  }
end

return joker
