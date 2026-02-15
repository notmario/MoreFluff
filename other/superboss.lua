function init()
  G.get_new_superboss = function()
    local superboss_pool = {}
    for k, v in pairs(G.P_BLINDS) do
      if v.debuff.superboss or v.debuff.akyrs_blind_difficulty == "expert" then
        if k ~= "bl_akyrs_expert_inflation" then
          superboss_pool[k] = true
        end
      end
    end

    local _, boss = pseudorandom_element(superboss_pool, pseudoseed('boss'))

    return boss
  end

  SMODS.Voucher {
    key = "superboss_ticket",
    atlas = "mf_vouchers",
    pos = { x = 3, y = 0 },

    no_collection = true,

    cost = 0,

    loc_vars = function(self)
      return {
        vars = {
          G.GAME.win_ante or 8,
          (G.GAME.win_ante and G.GAME.round_resets.ante) and math.floor(
            G.GAME.round_resets.ante + (G.GAME.win_ante - G.GAME.round_resets.ante % G.GAME.win_ante)
          ) or 8,
        },
      }
    end,

    redeem = function(self, card)
      G.GAME.superboss_active = true

      -- Increase ante scaling
      G.GAME.modifiers.scaling = G.GAME.modifiers.scaling or 1
      G.GAME.modifiers.bonus_scaling = 3

      G.GAME.modifiers.scaling = G.GAME.modifiers.scaling + G.GAME.modifiers.bonus_scaling

      G.GAME.round_resets.blind_choices.Small = "bl_mf_bigger_blind"
      G.GAME.round_resets.blind_choices.Big = get_new_boss()
      G.GAME.round_resets.blind_choices.Boss = G.get_new_superboss()

      ease_background_colour_blind(G.STATE, 'Small Blind')
    end,

    requires = {"v_mf_impossiblevoucher"},
  }

  SMODS.Blind {
    key = "bigger_blind",
    name = "Bigger Blind",

    atlas = "mf_blinds",
    pos = {x=0,y=0},

    dollars = 6,
    mult = 1,

    boss_colour = HEX('793aab'),

    no_collection = true,

    in_pool = function(self) return false end
  }

  SMODS.Blind {
    key = "violet_vessel_dx",
    name = "Violet Vessel DX",

    atlas = "mf_blinds",
    pos = {x=0,y=1},

    discovered = true,

    dollars = 10,
    mult = 24,

    boss_colour = HEX('ac3232'),
    
    debuff = { -- if you have aiko installed it gets more difficult lolollolol
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    boss = {
      min=9, max=10, showdown = true
    },

    disable = function(self)
      G.GAME.blind.chips = G.GAME.blind.chips/8
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "cerulean_bell_dx",
    name = "Cerulean Bell DX",

    atlas = "mf_blinds",
    pos = {x=0,y=2},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,

      force_select_count = 3,
    },

    loc_vars = function(self)
      return { vars = { self.debuff.force_select_count } }
    end,

    disable = function(self)
      for k, v in ipairs(G.playing_cards) do
        v.ability.forced_selection = nil
      end
    end,

    drawn_to_hand = function(self)
      local any_forced = nil
      for k, v in ipairs(G.hand.cards) do
        if v.ability.forced_selection then
          any_forced = true
        end
      end
      if not any_forced then 
        G.hand:unhighlight_all()
        local cb_dx_pool = {}
        for _, card in pairs(G.hand.cards) do
          cb_dx_pool[#cb_dx_pool + 1] = card
        end
        for _ = 1, self.debuff.force_select_count do
          if #cb_dx_pool == 0 then break end
          local forced_card = pseudorandom_element(cb_dx_pool, pseudoseed('cerulean_bell_dx'))
          -- table.remove(cb_dx_pool, forced_card)
          
          for i = 1,#cb_dx_pool do
            if cb_dx_pool[i] == forced_card then
              table.remove(cb_dx_pool, i)
              break
            end
          end

          forced_card.ability.forced_selection = true
          G.hand:add_to_highlighted(forced_card)
        end
      end
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "needle_dx",
    name = "The Needle DX",

    atlas = "mf_blinds",
    pos = {x=0,y=3},

    discovered = true,

    dollars = 10,
    mult = 1,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    disable = function(self)
      ease_hands_played(G.GAME.blind.hands_sub)
      ease_discard(G.GAME.blind.discards_sub)
      G.GAME.current_round.discards_used = G.GAME.current_round.discards_used - G.GAME.blind.discards_sub
    end,

    set_blind = function(self)
      G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
      ease_hands_played(-G.GAME.blind.hands_sub)
      G.GAME.blind.discards_sub = G.GAME.round_resets.discards - 1
      ease_discard(-G.GAME.blind.discards_sub)
      G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + G.GAME.blind.discards_sub
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "manacle_dx",
    name = "The Manacle DX",

    atlas = "mf_blinds",
    pos = {x=0,y=4},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    disable = function(self)
      if not G.GAME.blind.disabled then
        G.hand:change_size(3)
        
        G.FUNCS.draw_from_deck_to_hand(3)
      end
    end,

    defeat = function(self)
      if not G.GAME.blind.disabled then
        G.hand:change_size(3)
      end
    end,

    set_blind = function(self)
      G.hand:change_size(-3)
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "pillar_dx",
    name = "The Pillar DX",

    atlas = "mf_blinds",
    pos = {x=0,y=5},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    set_blind = function(self)
      for _, card in pairs(G.playing_cards) do
        if card.ability.mf_played_this_game and pseudorandom('pillar_dx') < 1 / 2 then
          card.ability.mf_played_this_game = false
        end
      end
    end,

    recalc_debuff = function(self, card, from_blind)
      if not G.GAME.blind.disabled and card.area ~= G.jokers then
        if card.ability.mf_played_this_game then
          return true
        end
      end
      return false
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "serpent_dx",
    name = "The Serpent DX",

    atlas = "mf_blinds",
    pos = {x=0,y=6},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "club_dx",
    name = "The Club DX",

    atlas = "mf_blinds",
    pos = {x=0,y=7},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    recalc_debuff = function(self, card, from_blind)
      if not G.GAME.blind.disabled and card.area ~= G.jokers then
        if not card:is_suit("Clubs") then
          return true
        end
      end
      return false
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "goad_dx",
    name = "The Goad DX",

    atlas = "mf_blinds",
    pos = {x=0,y=8},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    recalc_debuff = function(self, card, from_blind)
      if not G.GAME.blind.disabled and card.area ~= G.jokers then
        if not card:is_suit("Spades") then
          return true
        end
      end
      return false
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "window_dx",
    name = "The Window DX",

    atlas = "mf_blinds",
    pos = {x=0,y=9},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    recalc_debuff = function(self, card, from_blind)
      if not G.GAME.blind.disabled and card.area ~= G.jokers then
        if not card:is_suit("Diamonds") then
          return true
        end
      end
      return false
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "head_dx",
    name = "The Head DX",

    atlas = "mf_blinds",
    pos = {x=0,y=10},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    recalc_debuff = function(self, card, from_blind)
      if not G.GAME.blind.disabled and card.area ~= G.jokers then
        if not card:is_suit("Hearts") then
          return true
        end
      end
      return false
    end,

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "arm_dx",
    name = "The Arm DX",

    atlas = "mf_blinds",
    pos = {x=0,y=11},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    boss = {
      min=9, max=10, showdown = true
    },

    debuff_hand = function(self, cards, hand, handname, check)
      if G.GAME.blind.disabled then return end
      G.GAME.blind.triggered = false
      if to_number(G.GAME.hands[handname].level) > 0 then
        G.GAME.blind.triggered = true
        if not check then
          level_up_hand(nil, handname, nil, -G.GAME.hands[handname].level)
        end
      end 
    end,

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "wheel_dx",
    name = "The Wheel DX",

    atlas = "mf_blinds",
    pos = {x=0,y=12},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    boss = {
      min=9, max=10, showdown = true
    },

    stay_flipped = function(self, area, card)
      if not G.GAME.blind.disabled then
        if area == G.hand then
          for _, other_card in pairs(G.hand.cards) do
            if other_card.facing == "front" then
              return true
            end
          end
        end
      end
      return false
    end,

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "house_dx",
    name = "The House DX",

    atlas = "mf_blinds",
    pos = {x=0,y=13},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    boss = {
      min=9, max=10, showdown = true
    },

    drawn_to_hand = function(self)
      if not G.GAME.blind.has_discarded then
        for _, v in ipairs(G.hand.cards) do
          G.hand.highlighted[#G.hand.highlighted+1] = v
          v:highlight(true)
        end
        G.FUNCS.discard_cards_from_highlighted(nil, true)
        G.GAME.blind.has_discarded = true
      end
    end,

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "psychic_dx",
    name = "The Psychic DX",

    atlas = "mf_blinds",
    pos = {x=0,y=14},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      h_size_le = 4,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    boss = {
      min=9, max=10, showdown = true
    },

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Blind {
    key = "hook_dx",
    name = "The Hook DX",

    atlas = "mf_blinds",
    pos = {x=0,y=15},

    discovered = true,

    dollars = 10,
    mult = 3,

    boss_colour = HEX('ac3232'),
    
    debuff = {
      superboss = true,

      akyrs_blind_difficulty = "dx",
      akyrs_cannot_be_disabled = true,
    },

    boss = {
      min=9, max=10, showdown = true
    },

    drawn_to_hand = function(self)
      if G.GAME.blind.should_discard then
        for _, v in ipairs(G.hand.cards) do
          G.hand.highlighted[#G.hand.highlighted+1] = v
          v:highlight(true)
        end
        G.FUNCS.discard_cards_from_highlighted(nil, true)
        G.GAME.blind.should_discard = false
      end
    end,

    press_play = function(self)
      G.GAME.blind.should_discard = true
    end,

    in_pool = function(self) 
      return G.GAME.round_resets.ante > G.GAME.win_ante
    end
  }

  SMODS.Challenge {
    key = "superboss_always",
    rules = {
      custom = {
        { id = "mf_superboss_active" },
        { id = "scaling", value = 4 },
        { id = "bonus_scaling", value = 4 },
      },
      modifiers = {
        { id = "dollars", value = 14 },
      },
    },
    consumeables = {
      { id = "c_judgement" },
    },
  }
end


local gba = get_blind_amount
function get_blind_amount(ante)
  local amt = gba(ante)

  if (Jen or true) and G.GAME.superboss_active then
    amt = amt:tetrate(33333)
  end

  return amt
end

return init