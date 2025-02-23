local joker = {
  name = "Basepaul Card",
  config = {
    extra = {x_mult = 1.25}
  },
  pos = {x = 1, y = 0},
  rarity = 1,
  cost = 5,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  loc_txt = {
    name = "Basepaul Card",
    text = {
      "{X:mult,C:white} X#1# {} Mult. {X:mult,C:white} X#2# {} Mult",
      "instead for {C:red}Paul{}",
      "{C:inactive}(Who's Paul?)"
    }
  },
  loc_vars = function(self, info_queue, center)
    return {
      vars = { center.ability.extra.x_mult, center.ability.extra.x_mult * 10 }
    }
  end,
  calculate = function(self, card, context)
    if context.joker_main and context.cardarea == G.jokers and context.joker_main then
      if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "paul") then
        check_for_unlock({type = 'mf_trigger_paul'})
        return {
          message = localize({type='variable',key='a_xmult',vars={
            card.ability.extra.x_mult * 10
          }}),
          Xmult_mod = card.ability.extra.x_mult * 10,
        }
      else
        return {
          message = localize({type='variable',key='a_xmult',vars={
            card.ability.extra.x_mult
          }}),
          Xmult_mod = card.ability.extra.x_mult,
        }
      end
    end
  end
}

if JokerDisplay then
  JokerDisplay.Definitions["j_mf_basepaul_card"] = {
    text = {
      {
        border_nodes = {
          { text = "X" },
          { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" },
        },
      }
    },
    reminder_text = {
      {
        ref_table = "card.joker_display_values", ref_value = "inactive_text",
        colour = G.C.GRAY,
      },
      {
        ref_table = "card.joker_display_values", ref_value = "active_text",
        colour = G.C.RED,
      }
    },
    calc_function = function(card)
      if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "paul") then
        card.joker_display_values.x_mult = card.ability.extra.x_mult * 10
        card.joker_display_values.inactive_text = ""
        card.joker_display_values.active_text = localize("k_display_for_paul_ex")
      else
        card.joker_display_values.x_mult = card.ability.extra.x_mult
        card.joker_display_values.inactive_text = localize("k_display_for_paul")
        card.joker_display_values.active_text = ""
      end
    end,
  }
end

return joker
