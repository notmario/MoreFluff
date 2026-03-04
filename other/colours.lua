function init()
  FLUFF.Colour = SMODS.Consumable:extend {
    object_type = "Consumable",
    set = "Colour",
    cost = 4,
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {
        card.ability.val,
        val,
        max,
        card.ability.upgrade_rounds
      } }
    end,

    set_ability = function(self, card, initial, delay_sprites)
      card.ability.val = card.ability.val or 0
      card.ability.partial_rounds = card.ability.partial_rounds or 0
    end,

    can_use = function(self, card)
      if card.ability.suit then
        return #G.hand.cards > 1
      end
      if card.ability.tag or card.ability.create_set or card.ability.create_key then
        return true
      end
    end,

    use = function(self, card, area)
      if card.ability.suit then
        local rng_seed = self.key
        local blacklist = {}
        for i = 1, card.ability.val do
          local temp_pool = {}
          for k, v in pairs(G.hand.cards) do
            if not v:is_suit(card.ability.suit) and not blacklist[v] then
              table.insert(temp_pool, v)
            end
          end
          local over = false
          if #temp_pool == 0 then break end
          local eligible_card = pseudorandom_element(temp_pool, rng_seed)
          blacklist[eligible_card] = true
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              eligible_card:flip()
              play_sound('card1', 1)
              eligible_card:juice_up(0.3, 0.3)
              return true
            end
          }))
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
              eligible_card:flip()
              play_sound('tarot2', percent)
              eligible_card:change_suit(card.ability.suit)
              return true
            end
          }))
          card:juice_up(0.3, 0.5)
        end
        delay(0.6)
      end

      if card.ability.tag then
        for i = 1, card.ability.val do
          G.E_MANAGER:add_event(Event({
            func = function()
              add_tag(Tag(card.ability.tag))
              play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
              play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
              return true
            end
          }))
          delay(0.2)
        end
        delay(0.6)
      end

      if card.ability.create_set or card.ability.create_key then
        local tbl = { edition = "e_negative" }
        if card.ability.create_set then tbl.set = card.ability.create_set end
        if card.ability.create_key then tbl.key = card.ability.create_key end
        for i = 1, card.ability.val do
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
              play_sound('timpani')
              SMODS.add_card(tbl)
              card:juice_up(0.3, 0.5)
              return true
            end
          }))
        end
        delay(0.6)
      end

      if self.colour_effect and type(self.colour_effect) == "function" then
        for i = 1, card.ability.val do
          self.colour_effect(self, card, area)
        end
        delay(0.6)
      end
    end
  }

  -- for the funny progress bar.
  function progressbar(val, max)
    local val = val or 0
    local max = max or 1
    if max > 10 then
      return val, "/"..max
    end
    return string.rep("#", val), string.rep("#", max - val)
  end

  SMODS.ConsumableType({
    key = "Colour",
    primary_colour = HEX("4f6367"),
    secondary_colour = HEX("4f6367"),
    collection_rows = { 4, 4 },
    shop_rate = 1.0, -- originally it was zero because implementing shop items used to be jank but now it isnt so it isnt
    loc_txt = {},
    default = "c_mf_deepblue",
    can_stack = false,
    can_divide = false,
    select_card = "consumeables",
  })

  SMODS.UndiscoveredSprite({
    key = "Colour",
    atlas = "mf_colours",
    path = "mf_colours_refresh.png", -- uh. 
    pos = { x = 0, y = 0 },
    px = 71,
    py = 95,
  })
  
  SMODS.Booster({
    key = "colour_normal_1",
    kind = "Colour",
    atlas = "mf_packs",
    pos = { x = 0, y = 0 },
    config = { extra = 2, choose = 1 },
    cost = 4,
    weight = 0.96,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      local n_card = create_card("Colour", G.pack_cards, nil, nil, true, true, nil, "mf_colour")
      local ed_roll = pseudorandom('colour_editionroll')
      if ed_roll < 0.4 and G.GAME.used_vouchers.v_mf_colourtheory then
        n_card:set_edition({polychrome = true}, true)
      elseif ed_roll >= 0.4 and ed_roll < 0.766666 and G.GAME.used_vouchers.v_mf_artprogram then
        n_card:set_edition({negative = true}, true)
      end
      return n_card
    end,
    ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Colour)
      ease_background_colour({ new_colour = G.C.SECONDARY_SET.Colour, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
    end,
    group_key = "k_colour_pack",
  })
  SMODS.Booster({
    key = "colour_normal_2",
    kind = "Colour",
    atlas = "mf_packs",
    pos = { x = 1, y = 0 },
    config = { extra = 2, choose = 1 },
    cost = 4,
    weight = 0.96,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      local n_card = create_card("Colour", G.pack_cards, nil, nil, true, true, nil, "mf_colour")
      local ed_roll = pseudorandom('colour_editionroll')
      if ed_roll < 0.4 and G.GAME.used_vouchers.v_mf_colourtheory then
        n_card:set_edition({polychrome = true}, true)
      elseif ed_roll >= 0.4 and ed_roll < 0.766666 and G.GAME.used_vouchers.v_mf_artprogram then
        n_card:set_edition({negative = true}, true)
      end
      return n_card
    end,
    ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Colour)
      ease_background_colour({ new_colour = G.C.SECONDARY_SET.Colour, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_colour_pack",
  })
  SMODS.Booster({
    key = "colour_jumbo_1",
    kind = "Colour",
    atlas = "mf_packs",
    pos = { x = 2, y = 0 },
    config = { extra = 4, choose = 1 },
    cost = 6,
    weight = 0.48,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      local n_card = create_card("Colour", G.pack_cards, nil, nil, true, true, nil, "mf_colour")
      local ed_roll = pseudorandom('colour_editionroll')
      if ed_roll < 0.4 and G.GAME.used_vouchers.v_mf_colourtheory then
        n_card:set_edition({polychrome = true}, true)
      elseif ed_roll >= 0.4 and ed_roll < 0.766666 and G.GAME.used_vouchers.v_mf_artprogram then
        n_card:set_edition({negative = true}, true)
      end
      return n_card
    end,
    ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Colour)
      ease_background_colour({ new_colour = G.C.SECONDARY_SET.Colour, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_colour_pack",
  })
  SMODS.Booster({
    key = "colour_mega_1",
    kind = "Colour",
    atlas = "mf_packs",
    pos = { x = 3, y = 0 },
    config = { extra = 4, choose = 2 },
    cost = 8,
    weight = 0.12,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      local n_card = create_card("Colour", G.pack_cards, nil, nil, true, true, nil, "mf_colour")
      local ed_roll = pseudorandom('colour_editionroll')
      if ed_roll < 0.4 and G.GAME.used_vouchers.v_mf_colourtheory then
        n_card:set_edition({polychrome = true}, true)
      elseif ed_roll >= 0.4 and ed_roll < 0.766666 and G.GAME.used_vouchers.v_mf_artprogram then
        n_card:set_edition({negative = true}, true)
      end
      return n_card
    end,
    ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Colour)
      ease_background_colour({ new_colour = G.C.SECONDARY_SET.Colour, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_colour_pack",
  })

  SMODS.Tag({
    key = "colour",
    atlas = "mf_tags",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue)
      info_queue[#info_queue + 1] = { set = "Other", key = "p_mf_colour_jumbo_1", specific_vars = { 1, 4 } }
      return { vars = {} }
    end,
    apply = function(self, tag, context)
      if context.type == "new_blind_choice" then
        tag:yep("+", G.C.SECONDARY_SET.Code, function()
          local key = "p_mf_colour_jumbo_1"
          local card = Card(
            G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
            G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
            G.CARD_W * 1.27,
            G.CARD_H * 1.27,
            G.P_CARDS.empty,
            G.P_CENTERS[key],
            { bypass_discovery_center = true, bypass_discovery_ui = true }
          )
          card.cost = 0
          card.from_tag = true
          G.FUNCS.use_card({ config = { ref_table = card } })
          -- uh. should this be here??
          if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
            card:set_edition(nil, true, true)
          elseif G.GAME.modifiers.cry_force_random_edition then
            local edition = Cryptid.poll_random_edition()
            card:set_edition(edition, true, true)
          end
          card:start_materialize()
          return true
        end)
        tag.triggered = true
        return true
      end
    end,
  })

  if Entropy and Entropy.AscendedTags then
    Entropy.AscendedTags["tag_mf_colour"] = "tag_entr_ascendant_twisted"
  end

  FLUFF.Colour {
    key = "black",
    name = "col_Black",
    atlas = "mf_colours",
    pos = { x = 0, y = 1 },
    config = {
      upgrade_rounds = 4
    },

    can_use = function(self, card)
      for k, v in pairs(G.jokers.cards) do
        if v.ability.set == "Joker" and ((not v.edition) or (v.edition and not v.edition.negative)) then
          return true
        end
      end
      return false
    end,

    colour_effect = function(self, card, area)
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          local temp_pool = {}
          local backup_pool = {}
          for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition) then
              table.insert(temp_pool, v)
            end
            if v.ability.set == 'Joker' and (v.edition and not v.edition.negative) then
              table.insert(backup_pool, v)
            end
          end
          if #temp_pool > 0 then
            local over = false
            local eligible_card = pseudorandom_element(temp_pool, pseudoseed("black"))
            local edition = {negative = true}
            eligible_card:set_edition(edition, true)
            check_for_unlock({type = 'have_edition'})
            card:juice_up(0.3, 0.5)
          elseif #backup_pool > 0 then
            local over = false
            local eligible_card = pseudorandom_element(backup_pool, pseudoseed("black"))
            local edition = {negative = true}
            eligible_card:set_edition(edition, true)
            check_for_unlock({type = 'have_edition'})
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
  }

  FLUFF.Colour {
    key = "deepblue",
    name = "col_Deep Blue",
    atlas = "mf_colours",
    pos = { x = 1, y = 1 },
    config = {
      upgrade_rounds = 1,
      suit = "Spades"
    }
  }

  FLUFF.Colour {
    key = "crimson",
    name = "col_Crimson",
    atlas = "mf_colours",
    pos = { x = 2, y = 1 },
    config = {
      upgrade_rounds = 3,
      tag = "tag_rare"
    }
  }

  FLUFF.Colour {
    key = "seaweed",
    name = "col_Seaweed",
    atlas = "mf_colours",
    pos = { x = 3, y = 1 },
    config = {
      upgrade_rounds = 1,
      suit = "Clubs"
    }
  }

  FLUFF.Colour {
    key = "brown",
    name = "col_Brown",
    atlas = "mf_colours",
    pos = { x = 0, y = 2 },
    config = {
      upgrade_rounds = 1,
      cash_per = 2
    },

    loc_vars = function(self, info_queue, card)
      local tbl = FLUFF.Colour.loc_vars(self, info_queue, card)
      table.insert(tbl.vars, card.ability.cash_per)
      return tbl
    end,

    can_use = function(self, card)
      return #G.hand.cards > 1
    end,

    use = function(self, card, area)
      local temp_hand = {}
      local destroyed_cards = {}
      for _, v in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = v end
      table.sort(temp_hand, function(a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
      pseudoshuffle(temp_hand, pseudoseed("brown"))

      for i = 1, math.min(#temp_hand, card.ability.val) do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

      G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.4,
        func = function()
          play_sound("tarot1")
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function() 
          for i=#destroyed_cards, 1, -1 do
            local card = destroyed_cards[i]
            SMODS.destroy_cards({card})
          end
          return true
        end
      }))
      delay(0.5)
      ease_dollars(card.ability.cash_per * card.ability.val)
      delay(0.6)
    end
  }
  
  FLUFF.Colour {
    key = "grey",
    name = "col_Grey",
    atlas = "mf_colours",
    pos = { x = 1, y = 2 },
    config = {
      upgrade_rounds = 3,
      tag = "tag_double"
    }
  }
  
  FLUFF.Colour {
    key = "silver",
    name = "col_Silver",
    atlas = "mf_colours",
    pos = { x = 2, y = 2 },
    config = {
      upgrade_rounds = 3,
      tag = "tag_polychrome"
    }
  }

  FLUFF.Colour {
    key = "white",
    name = "col_White",
    atlas = "mf_colours",
    pos = { x = 3, y = 2 },
    config = {
      upgrade_rounds = 3,
      create_set = "Colour"
    }
  }
  
  FLUFF.Colour {
    key = "red",
    name = "col_Red",
    atlas = "mf_colours",
    pos = { x = 0, y = 3 },
    config = {
      upgrade_rounds = 1,
      suit = "Hearts"
    }
  }

  FLUFF.Colour {
    key = "orange",
    name = "col_Orange",
    atlas = "mf_colours",
    pos = { x = 1, y = 3 },
    config = {
      upgrade_rounds = 1,
      suit = "Diamonds"
    }
  }

  FLUFF.Colour {
    key = "yellow",
    name = "col_Yellow",
    atlas = "mf_colours",
    pos = { x = 2, y = 3 },
    config = {
      upgrade_rounds = 3,
      value_per = 8
    },

    loc_vars = function(self, info_queue, card)
      local tbl = FLUFF.Colour.loc_vars(self, info_queue, card)
      table.insert(tbl.vars, card.ability.value_per)
      return tbl
    end
  }

  FLUFF.Colour {
    key = "green",
    name = "col_Green",
    atlas = "mf_colours",
    pos = { x = 3, y = 3 },
    config = {
      upgrade_rounds = 3,
      create_key = "j_mf_oopsallfives"
    },

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS["j_mf_oopsallfives"]
      return FLUFF.Colour.loc_vars(self, info_queue, card)
    end
  }

  FLUFF.Colour {
    key = "blue",
    name = "col_Blue",
    atlas = "mf_colours",
    pos = { x = 0, y = 4 },
    config = {
      upgrade_rounds = 2,
      create_set = "Planet"
    }
  }
  
  FLUFF.Colour {
    key = "lilac",
    name = "col_Lilac",
    atlas = "mf_colours",
    pos = { x = 1, y = 4 },
    config = {
      upgrade_rounds = 2,
      create_set = "Tarot"
    }
  }
  
  FLUFF.Colour {
    key = "pink",
    name = "col_Pink",
    atlas = "mf_colours",
    pos = { x = 2, y = 4 },
    config = {
      upgrade_rounds = 2
    },

    can_use = function(self, card)
      return true
    end,

    use = function(self, card, area)
      n_random_colour_rounds(card.ability.val)
    end
  }
  
  if mf_config["45 Degree Rotated Tarot Cards"] then
    FLUFF.Colour {
      key = "peach",
      name = "col_Peach",
      atlas = "mf_colours",
      pos = { x = 3, y = 4 },
      config = {
        upgrade_rounds = 2,
        create_set = "Rotarot"
      }
    }
  end
  
  FLUFF.Colour {
    key = "new_gold",
    name = "col_Gold",
    atlas = "mf_colours",
    pos = { x = 1, y = 6 },
    hidden = true,
    config = {
      upgrade_rounds = 4,
      create_key = "c_soul"
    }
  }

  if next(SMODS.find_mod("aikoyorisshenanigans")) then
    -- hell yeah 2
    FLUFF.Colour {
      key = "wordlegreen",
      name = "col_WordleGreen",
      atlas = "mf_colours",
      pos = { x = 0, y = 6 },
      config = {
        upgrade_rounds = 1,
        create_set = "Alphabet"
      },

      in_pool = function(self, args)
        return G.GAME.akyrs_character_stickers_enabled and G.GAME.akyrs_wording_enabled
      end,

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("aikoyorisshenanigans")[1] }, badges)
      end
    }
  end

  if next(SMODS.find_mod("LuckyRabbit")) then
    -- hell yeah 3
    FLUFF.Colour {
      key = "pastelpink",
      name = "col_PastelPink",
      atlas = "mf_colours",
      pos = { x = 2, y = 6 },
      config = {
        upgrade_rounds = 2,
        create_set = "Silly"
      },

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("LuckyRabbit")[1] }, badges)
      end
    }
  end

  if next(SMODS.find_mod("sillyseals")) then
    -- the rest of them are still hell yeahs i just cant be bothered writing it every time
    FLUFF.Colour {
      key = "royalblue",
      name = "col_RoyalBlue",
      atlas = "mf_colours",
      pos = { x = 3, y = 6 },
      hidden = true,
      soul_rate = 0.03,
      config = {
        upgrade_rounds = 4
      },

      can_use = function(self, card)
        return true
      end,

      colour_effect = function(self, card, area)
        local key = nil
        if jl.chance("sealspectralpack_legendary", 20, true) then
          key = pseudorandom_element(Seals.legendary_seal_spectrals, pseudoseed("sealspectrals"))
        elseif jl.chance("sealspectralpack_epic", 5, true) then
          key = pseudorandom_element(Seals.epic_seal_spectrals, pseudoseed("sealspectrals"))
        else
          key = pseudorandom_element(Seals.rare_seal_spectrals, pseudoseed("sealspectrals"))
        end

        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.4,
          func = function()
            SMODS.add_card { edition = "e_negative", key = key }
            return true
          end
        }))
      end
    }
    
    FLUFF.Colour {
      key = "respiceperprisma",
      name = "col_RespicePerPrisma",
      atlas = "mf_colours",
      pos = { x = 3, y = 7 },
      hidden = true,
      soul_rate = 0.0003,
      config = {
        upgrade_rounds = 12,
        create_key = "c_sillyseals_ringularity"
      },

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("sillyseals")[1] }, badges)
      end
    }
  end

  if next(SMODS.find_mod("Tsunami")) then
    FLUFF.Colour {
      key = "teal",
      name = "col_Teal",
      atlas = "mf_colours",
      pos = { x = 0, y = 7 },
      config = {
        upgrade_rounds = 2,
        create_key = "j_splash"
      },

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("Tsunami")[1] }, badges)
      end
    }
  end

  if next(SMODS.find_mod("egjs")) then
    FLUFF.Colour {
      key = "blank",
      name = "col_Blank",
      atlas = "mf_colours",
      pos = { x = 1, y = 7 },
      config = {
        upgrade_rounds = 3,
        create_key = "c_egjs_js_basic"
      },

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("egjs")[1] }, badges)
      end
    }
  end

  if next(SMODS.find_mod("sarcpot")) then
    FLUFF.Colour {
      key = "amber",
      name = "col_Amber",
      atlas = "mf_colours",
      pos = { x = 2, y = 7 },
      config = {
        upgrade_rounds = 3,
        create_set = "Travel"
      },

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("sarcpot")[1] }, badges)
      end
    }
  end

  if next(SMODS.find_mod("Prism")) then
    FLUFF.Colour {
      key = "moss",
      name = "col_Moss",
      atlas = "mf_colours",
      pos = { x = 0, y = 8 },
      config = {
        upgrade_rounds = 3,
        create_set = "Myth"
      },

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("Prism")[1] }, badges)
      end
    }
  end

  if next(SMODS.find_mod("sdm0sstuff")) then
    if SDM_0s_Stuff_Config and SDM_0s_Stuff_Config.sdm_bakery then
      FLUFF.Colour {
        key = "caramel",
        name = "col_Caramel",
        atlas = "mf_colours",
        pos = { x = 1, y = 8 },
        config = {
          upgrade_rounds = 3,
          create_set = "Bakery"
        },

        set_badges = function (self, card, badges)
          SMODS.create_mod_badges({ mod = SMODS.find_mod("sdm0sstuff")[1] }, badges)
        end
      }
    end
  end

  if next(SMODS.find_mod("finity")) then
    FLUFF.Colour {
      key = "violet",
      name = "col_Violet",
      atlas = "mf_colours",
      pos = { x = 2, y = 8 },
      hidden = true,
      config = {
        upgrade_rounds = 4,
        create_key = "c_finity_finity"
      },

      set_badges = function (self, card, badges)
        SMODS.create_mod_badges({ mod = SMODS.find_mod("finity")[1] }, badges)
      end
    }
  end

  SMODS.Voucher({
    object_type = "Voucher",
    key = "paintroller",
    atlas = "mf_vouchers",
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue)
      local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, 2, 'paintroller')
      return { vars = { new_numerator, new_denominator } }
    end,
  })
  SMODS.Voucher({
    object_type = "Voucher",
    key = "colourtheory",
    atlas = "mf_vouchers",
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue)
      return { vars = {} }
    end,
    requires = { "v_mf_paintroller" },
  })
  if next(SMODS.find_mod("Cryptid")) then
    SMODS.Voucher({
      object_type = "Voucher",
      key = "artprogram",
      atlas = "mf_vouchers",
      pos = { x = 2, y = 0 },
      unlocked = true,
      discovered = true,
      loc_vars = function(self, info_queue)
        return { vars = {} }
      end,
      requires = { "v_mf_colourtheory" },
    })
  end

  -- hooks
  local game_updateref = Game.update
  function Game:update(dt)
    game_updateref(self, dt)
    
    self.C.SECONDARY_SET.Colour[1] = 0.4+0.2*(1+math.sin(self.TIMERS.REAL*1.5 + 0))
    self.C.SECONDARY_SET.Colour[3] = 0.4+0.2*(1+math.sin(self.TIMERS.REAL*1.5 + math.pi * 2 / 3))
    self.C.SECONDARY_SET.Colour[2] = 0.4+0.2*(1+math.sin(self.TIMERS.REAL*1.5 + math.pi * 4 / 3))
    
    if G.ARGS.LOC_COLOURS ~= nil then
      G.ARGS.LOC_COLOURS["colourcard"] = G.C.SECONDARY_SET.Colour
    end
  end

  function colour_end_of_round_effects()
    for i=1, #G.consumeables.cards do
      trigger_colour_end_of_round(G.consumeables.cards[i])
    end
  end

  function n_random_colour_rounds(n, seed)
    for i=1, n do
      local temp_pool = {}
      for k, v in pairs(G.consumeables.cards) do
        if v.ability.set == 'Colour' or v.ability.set == "Shape" then
          table.insert(temp_pool, v)
        end
      end
      if #temp_pool == 0 then
        break
      end
      local _card = pseudorandom_element(temp_pool, pseudoseed(seed or "pink"))
      trigger_colour_end_of_round(_card)
    end
  end

  function trigger_colour_end_of_round(_card)
    if _card.ability.mf_halted then return false end
    if _card.ability.set == "Colour" or _card.ability.set == "Shape" then

      local base_count = 1
      if G.GAME.used_vouchers.v_mf_paintroller and SMODS.pseudorandom_probability(G.P_CENTERS["v_mf_paintroller"], 'paintroller', 1, 2, 'paintroller') then
        base_count = base_count + 1
      end

      -- it's back !!
      for _, jkr in pairs(SMODS.find_card("j_mf_paintcan")) do
        if SMODS.pseudorandom_probability(jkr, 'paintcan', 1, jkr.ability.extra.odds, 'paintcan') then
          base_count = base_count + 1
        end
      end
      
      base_count = base_count + #SMODS.find_card("j_akyrs_aikoyori")

      for j=1, base_count do
        -- all of them that go up over time
        if _card.ability.upgrade_rounds then
          _card.ability.partial_rounds = _card.ability.partial_rounds + 1
          local upgraded = false
          while _card.ability.partial_rounds >= _card.ability.upgrade_rounds do
            upgraded = true
            _card.ability.val = _card.ability.val + 1
            if _card.ability.val >= 10 then
              check_for_unlock({type = 'mf_ten_colour_rounds'})
            end
            _card.ability.partial_rounds = _card.ability.partial_rounds - _card.ability.upgrade_rounds
            
            if _card.ability.name == "col_Yellow" then
                  _card.ability.extra_value = _card.ability.extra_value + _card.ability.value_per
                  _card:set_cost()
                  card_eval_status_text(_card, 'extra', nil, nil, nil, {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY,
                    card = _card
                  }) 
            else
                  card_eval_status_text(_card, 'extra', nil, nil, nil, {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.SECONDARY_SET.ColourCard,
                    card = _card
                  }) 
            end
          end
          if not upgraded then
            local str = _card.ability.partial_rounds..'/'.._card.ability.upgrade_rounds
              card_eval_status_text(_card, 'extra', nil, nil, nil, {
                message = str,
                colour = G.C.SECONDARY_SET.ColourCard,
                card = _card
              }) 
          end
        end
      end
    end
  end
  
  -- -- special thanks to John Cryptid for this
  -- -- and Betmma, apparently
  -- G.FUNCS.can_reserve_card = function(e)
  --   if #G.consumeables.cards < G.consumeables.config.card_limit then
  --     e.config.colour = G.C.GREEN
  --     e.config.button = "reserve_card"
  --   else
  --     e.config.colour = G.C.UI.BACKGROUND_INACTIVE
  --     e.config.button = nil
  --   end
  -- end
  -- G.FUNCS.reserve_card = function(e)
  --   local c1 = e.config.ref_table
  --   G.E_MANAGER:add_event(Event({
  --     trigger = "after",
  --     delay = 0.1,
  --     func = function()
  --       c1.area:remove_card(c1)
  --       c1:add_to_deck()
  --       if c1.children.price then
  --         c1.children.price:remove()
  --       end
  --       c1.children.price = nil
  --       if c1.children.buy_button then
  --         c1.children.buy_button:remove()
  --       end
  --       c1.children.buy_button = nil
  --       remove_nils(c1.children)
  --       G.consumeables:emplace(c1)
  --       G.GAME.pack_choices = G.GAME.pack_choices - 1
  --       if G.GAME.pack_choices <= 0 then
  --         G.FUNCS.end_consumeable(nil, delay_fac)
  --       end
  --       return true
  --     end,
  --   }))
  -- end

  -- local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
  -- function G.UIDEF.use_and_sell_buttons(card)
  --   if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
  --     if card.ability.set == "Colour" then
  --       return {
  --         n = G.UIT.ROOT,
  --         config = { padding = -0.1, colour = G.C.CLEAR },
  --         nodes = {
  --           {
  --             n = G.UIT.R,
  --             config = {
  --               ref_table = card,
  --               r = 0.08,
  --               padding = 0.1,
  --               align = "bm",
  --               minw = 0.5 * card.T.w - 0.15,
  --               minh = 0.7 * card.T.h,
  --               maxw = 0.7 * card.T.w - 0.15,
  --               hover = true,
  --               shadow = true,
  --               colour = G.C.UI.BACKGROUND_INACTIVE,
  --               one_press = true,
  --               button = "use_card",
  --               func = "can_reserve_card",
  --             },
  --             nodes = {
  --               {
  --                 n = G.UIT.T,
  --                 config = {
  --                   text = localize("b_take"),
  --                   colour = G.C.UI.TEXT_LIGHT,
  --                   scale = 0.55,
  --                   shadow = true,
  --                 },
  --               },
  --             },
  --           },
  --         },
  --       }
  --     end
  --   end
  --   return G_UIDEF_use_and_sell_buttons_ref(card)
  -- end

  -- Joker Display

  if JokerDisplay then
    local cols = {
      "c_mf_black",
      "c_mf_deepblue",
      "c_mf_crimson",
      "c_mf_seaweed",
      "c_mf_brown",
      "c_mf_grey",
      "c_mf_silver",
      "c_mf_white",
      "c_mf_red",
      "c_mf_orange",
      "c_mf_yellow",
      "c_mf_green",
      "c_mf_blue",
      "c_mf_lilac",
      "c_mf_pink",
      "c_mf_peach",
      "c_mf_new_gold",

      "c_mf_purple",
      "c_mf_moonstone",
      "c_mf_gold",
      "c_mf_ooffoo",
      "c_mf_wordlegreen",
      "c_mf_pastelpink",
      "c_mf_royalblue",
      "c_mf_respiceperprisma",
      "c_mf_teal",
      "c_mf_blank",
      "c_mf_amber",
      "c_mf_moss",
      "c_mf_caramel",
      "c_mf_finity",
    }

    for _, col in pairs(cols) do
      if JokerDisplay then
        JokerDisplay.Definitions[col] = {
          text = {
            { ref_table = "card.ability", ref_value = "val", colour = G.C.DARK_EDITION  },
            { text = " (", colour = G.C.UI.TEXT_INACTIVE },
            { ref_table = "card.ability", ref_value = "partial_rounds", colour = G.C.UI.TEXT_INACTIVE },
            { text = "/", colour = G.C.UI.TEXT_INACTIVE },
            { ref_table = "card.ability", ref_value = "upgrade_rounds", colour = G.C.UI.TEXT_INACTIVE },
            { text = ")", colour = G.C.UI.TEXT_INACTIVE },
          }
        }
      end
    end
  end
end

return init
