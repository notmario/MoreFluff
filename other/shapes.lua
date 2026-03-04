function init()
  -- for the funny progress bar.
  function progressbar(val, max)
    local val = val or 0
    local max = max or 0
    if max > 10 then
      return val, "/"..max
    end
    return string.rep("#", val), string.rep("#", max - val)
  end

  SMODS.ConsumableType({
    key = "Shape",
    primary_colour = HEX("316ea0"),
    secondary_colour = HEX("316ea0"),
    collection_rows = { 4, 4 },
    loc_txt = {},
    default = "c_mf_cloud",
    can_stack = false,
    can_divide = false,
    can_be_pulled = "b_take",
    no_use_button = true
  })

  SMODS.UndiscoveredSprite({
    key = "Shape",
    atlas = "mf_shapes",
    path = "mf_shapes.png",
    pos = { x = 0, y = 0 },
    px = 71,
    py = 95,
  })

  G.C.SECONDARY_SET.Shape = HEX("316ea0")

  -- SMODS.Tag({
  --   key = "colour",
  --   atlas = "mf_tags",
  --   pos = { x = 0, y = 0 },
  --   unlocked = true,
  --   discovered = true,
  --   loc_vars = function(self, info_queue)
  --     info_queue[#info_queue + 1] = { set = "Other", key = "p_mf_colour_jumbo_1", specific_vars = { 1, 4 } }
  --     return { vars = {} }
  --   end,
  --   apply = function(self, tag, context)
  --     if context.type == "new_blind_choice" then
  --       tag:yep("+", G.C.SECONDARY_SET.Code, function()
  --         local key = "p_mf_colour_jumbo_1"
  --         local card = Card(
  --           G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
  --           G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
  --           G.CARD_W * 1.27,
  --           G.CARD_H * 1.27,
  --           G.P_CARDS.empty,
  --           G.P_CENTERS[key],
  --           { bypass_discovery_center = true, bypass_discovery_ui = true }
  --         )
  --         card.cost = 0
  --         card.from_tag = true
  --         G.FUNCS.use_card({ config = { ref_table = card } })
  --         -- uh. should this be here??
  --         if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
  --           card:set_edition(nil, true, true)
  --         elseif G.GAME.modifiers.cry_force_random_edition then
  --           local edition = Cryptid.poll_random_edition()
  --           card:set_edition(edition, true, true)
  --         end
  --         card:start_materialize()
  --         return true
  --       end)
  --       tag.triggered = true
  --       return true
  --     end
  --   end,
  -- })

  SMODS.Tag({
    key = "absolute",
    atlas = "mf_tags",
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue)
      info_queue[#info_queue + 1] = { set = "Other", key = "cry_absolute" }
      return { vars = {} }
    end,
    in_pool = function() return false end or nil,
    config = { type = "store_joker_modify", sticker = "cry_absolute" },
    apply = function(self, tag, context)
      if context.type == "store_joker_modify" then
        local _applied = nil
        if Cryptid.forced_edition() then
          tag:nope()
        end
        if not context.card.temp_edition and context.card.ability.set == "Joker" then
          local lock = tag.ID
          G.CONTROLLER.locks[lock] = true
          context.card.temp_edition = true
          tag:yep("+", G.C.DARK_EDITION, function()
            context.card.cry_absolute = true
            context.card.ability.couponed = true
            context.card:set_cost()
            context.card:juice_up(0.5, 0.5)
            context.card.temp_edition = nil
            G.CONTROLLER.locks[lock] = nil
            return true
          end)
          _applied = true
          tag.triggered = true
        end
      end
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  SMODS.Tag({
    key = "eabsolute",
    atlas = "mf_ascendant_tags",
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue)
      info_queue[#info_queue + 1] = { set = "Other", key = "cry_absolute" }
      return { vars = {} }
    end,
    config = { type = "store_joker_modify", sticker = "cry_absolute" },
    in_pool = function() return false end or nil,
    apply = function(self, tag, context)
      if context.type == "store_joker_modify" then
        if not context.card.temp_edition and context.card.ability.set == "Joker" then
          tag:yep("+", G.C.RARITY[colour], function()
            for i, v in pairs(G.shop_jokers.cards) do
              v.cry_absolute = true
            end
            for i, v in pairs(G.shop_booster.cards) do
              v.cry_absolute = true
            end
            for i, v in pairs(G.shop_vouchers.cards) do
              v.cry_absolute = true
            end
            return true
          end)
          tag.triggered = true
        end
      end
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })
  
  if Entropy.AscendedTags then
    Entropy.AscendedTags["tag_mf_absolute"] = "tag_mf_eabsolute"
  end

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Cloud",
    key = "cloud",
    pos = { x = 0, y = 1 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 5,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'j_mf_philosophical', 'sup')
        n_card:add_to_deck()
        n_card:set_edition({negative = true}, true)
        G.jokers:emplace(n_card)
        card:juice_up(0.3, 0.5)
        return true end }))
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  local full_deck_suit_stuff = function (card, copier, suit)
    local used_tarot = copier or card

    local destroyed_cards = {}

    for i = 1, (card.ability.val*2) do
      if #G.playing_cards == 0 then break end
      local conv_card = pseudorandom_element(G.playing_cards, pseudoseed("shape_card"))

      if conv_card:is_suit(suit, nil, true) then
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.1,
          func = function()
            SMODS.destroy_cards({conv_card})
            return true end }))
      else
        if conv_card.area ~= G.discard and conv_card.area.config.type ~= 'deck' then
          G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() conv_card:flip();play_sound('card1', 1);conv_card:juice_up(0.3, 0.3);return true end }))
          G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function() conv_card:flip();play_sound('tarot2', percent);conv_card:change_suit(suit);return true end }))
        else
          conv_card:change_suit(suit)
        end
      end
    end
  end

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Spade",
    key = "spade",
    pos = { x = 1, y = 1 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 1,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      full_deck_suit_stuff(card, copier, "Spades")
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Omega",
    key = "omega",
    pos = { x = 2, y = 1 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 2,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      local tag_type = "tag_mf_absolute"
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({
          func = (function()
            add_tag(Tag(tag_type))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
          end)
        }))
        delay(0.2)
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Club",
    key = "club",
    pos = { x = 3, y = 1 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 1,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      full_deck_suit_stuff(card, copier, "Clubs")
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Rectangle",
    key = "rectangle",
    pos = { x = 0, y = 2 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 1,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({
          func = (function()
            local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, 2, true)
            local _seal = SMODS.poll_seal({mod = 10})
            local n_card = SMODS.create_card {set = (pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.4) and "Enhanced" or "Base", edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "sta"}
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            n_card.playing_card = G.playing_card
            n_card:add_to_deck()
            G.hand:emplace(n_card)
            card:juice_up(0.3, 0.5)
            table.insert(G.playing_cards, n_card)

            playing_card_joker_effects({n_card})
            play_sound('timpani')

            return true
          end)
        }))
        delay(0.2)
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Squircle",
    key = "squircle",
    pos = { x = 1, y = 2 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 2,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      for i = 1, card.ability.val do
      local tag_type = get_next_tag_key()
        G.E_MANAGER:add_event(Event({
          func = (function()
            add_tag(Tag(tag_type))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
          end)
        }))
        delay(0.2)
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_arrow",
    key = "arrow",
    pos = { x = 2, y = 2 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 5,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      local tag_type = "tag_entr_solar"
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({
          func = (function()
            add_tag(Tag(tag_type))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
          end)
        }))
        delay(0.2)
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })
  
  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Circle",
    key = "circle",
    pos = { x = 3, y = 2 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 3,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      local card_type = "Shape"
      local rng_seed = "circle"
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local n_card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, rng_seed)
          n_card:add_to_deck()
          n_card:set_edition({negative = true}, true)
          G.consumeables:emplace(n_card)
          card:juice_up(0.3, 0.5)
          return true end }))
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Heart",
    key = "heart",
    pos = { x = 0, y = 3 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 1,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      full_deck_suit_stuff(card, copier, "Hearts")
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Diamond",
    key = "diamond",
    pos = { x = 1, y = 3 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 1,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      full_deck_suit_stuff(card, copier, "Diamonds")
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })


  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Dollar",
    key = "dollar",
    pos = { x = 2, y = 3 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 1,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      local sell_pool = {}
      for _, c in pairs(G.jokers.cards) do
        if not c.cry_absolute then sell_pool[#sell_pool + 1] = c end
      end
      for _, c in pairs(G.consumeables.cards) do
        if not c.cry_absolute then sell_pool[#sell_pool + 1] = c end
      end

      if #sell_pool == 0 then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          attention_text({
            text = localize('k_nope_ex'),
            scale = 1.3, 
            hold = 1.4,
            major = card,
            backdrop_colour = G.C.SECONDARY_SET.Tarot,
            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
            offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
            silent = true
            })
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
              play_sound('tarot2', 0.76, 0.4);return true end}))
            play_sound('tarot2', 1, 0.4)
            card:juice_up(0.3, 0.5)
        return true end }))
      else
        local sell_card = pseudorandom_element(sell_pool, pseudoseed("dollar"))
        
        sell_card.ability.eternal = false
        
        sell_card.bonus_cost = (sell_card.cost) * (card.ability.val - 1)
        sell_card:set_cost()
        
        G.FUNCS.sell_card (
          {
            config = {
              ref_table = sell_card -- love that janker
            }
          }
        )
      end
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  -- cog goes here
  
  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Star",
    key = "star",
    pos = { x = 0, y = 4 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 2,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      local card_type = "Star"
      local rng_seed = "star"
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local n_card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, rng_seed)
          n_card:add_to_deck()
          n_card:set_edition({negative = true}, true)
          G.consumeables:emplace(n_card)
          card:juice_up(0.3, 0.5)
          return true end }))
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end
  })

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Pentagon",
    key = "pentagon",
    pos = { x = 1, y = 4 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 2,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      local card_type = "Fraud"
      local rng_seed = "fraud"
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local n_card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, rng_seed)
          n_card:add_to_deck()
          n_card:set_edition({negative = true}, true)
          G.consumeables:emplace(n_card)
          card:juice_up(0.3, 0.5)
          return true end }))
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end
  })
  
  SMODS.Sticker {
    key = "halted",
    atlas = "mf_stickers",
    pos = { x = 0, y = 0 },
    badge_colour = HEX("1b4484"),
    no_sticker_sheet = true,
    should_apply = function(self, card, center, area, bypass_roll)
      return false
    end,
    draw = function(self, card) --don't draw shine
      local notilt = nil
      if card.area and card.area.config.type == "deck" then
        notilt = true
      end

      G.shared_stickers[self.key].role.draw_major = card

      G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
    end,
  }
  
  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_Pause",
    key = "pause",
    pos = { x = 2, y = 4 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 2,
    },
    cost = 4,
    atlas = "mf_shapes",
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      for i = 1, card.ability.val do
        colour_end_of_round_effects()
      end
      for _, v in pairs(G.consumeables.cards) do
        if v.ability.set == "Shape" or v.ability.set == "Colour" then
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            v.ability["mf_halted"] = true
            v:juice_up(0.5, 0.5)
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true end }))
        end
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = {key = "mf_halted", set="Other"}
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end
  })
  
  -- curved arrow goes here

  SMODS.Consumable({
    object_type = "Consumable",
    set = "Shape",
    name = "shape_gem",
    key = "gem",
    pos = { x = 0, y = 6 },
    soul_pos = { x = 1, y = 6 },
    config = {
      val = 0,
      partial_rounds = 0,
      upgrade_rounds = 4,
    },
    cost = 4,
    atlas = "mf_shapes",
    hidden = true,
    unlocked = true,
    discovered = true,
    display_size = { w = 71, h = 87 },
    pixel_size = { w = 71, h = 87 },
    can_use = function(self, card)
      return true
    end,
    use = function(self, card, area, copier)
      for i = 1, card.ability.val do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_entr_fervour', 'sup')
          n_card.no_omega = true
          n_card:add_to_deck()
          n_card:set_edition({negative = true}, true)
          G.consumeables:emplace(n_card)
          card:juice_up(0.3, 0.5)
          return true end }))
      end
      delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
      local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
      return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
    end,
    set_badges = function (self, card, badges)
      SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
    end,
  })

  -- SMODS.Consumable({
  --   object_type = "Consumable",
  --   set = "Shape",
  --   name = "shape_house",
  --   key = "house",
  --   pos = { x = 0, y = 5 },
  --   config = {
  --     val = 0,
  --     partial_rounds = 0,
  --     upgrade_rounds = 4,
  --   },
  --   cost = 4,
  --   atlas = "mf_shapes",
  --   unlocked = true,
  --   discovered = true,
  --   display_size = { w = 71, h = 87 },
  --   pixel_size = { w = 71, h = 87 },
  --   can_use = function(self, card)
  --     return true
  --   end,
  --   use = function(self, card, area, copier)
  --     local tag_type = "tag_entr_ascendant_reference"
  --     for i = 1, card.ability.val do
  --       G.E_MANAGER:add_event(Event({
  --         func = (function()
  --           add_tag(Tag(tag_type))
  --           play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
  --           play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
  --           return true
  --         end)
  --       }))
  --       delay(0.2)
  --     end
  --     delay(0.6)
  --   end,
  --   loc_vars = function(self, info_queue, card)
  --     local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
  --     return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
  --   end,
  --   set_badges = function (self, card, badges)
  --     SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
  --   end,
  -- })

  -- SMODS.Consumable({
  --   object_type = "Consumable",
  --   set = "Shape",
  --   name = "shape_loss",
  --   key = "loss",
  --   pos = { x = 1, y = 5 },
  --   config = {
  --     val = 0,
  --     partial_rounds = 0,
  --     upgrade_rounds = 4,
  --   },
  --   cost = 4,
  --   atlas = "mf_shapes",
  --   unlocked = true,
  --   discovered = true,
  --   display_size = { w = 71, h = 87 },
  --   pixel_size = { w = 71, h = 87 },
  --   can_use = function(self, card)
  --     return true
  --   end,
  --   use = function(self, card, area, copier)
  --     local tag_type = "tag_cry_loss"
  --     for i = 1, card.ability.val do
  --       G.E_MANAGER:add_event(Event({
  --         func = (function()
  --           add_tag(Tag(tag_type))
  --           play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
  --           play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
  --           return true
  --         end)
  --       }))
  --       delay(0.2)
  --     end
  --     delay(0.6)
  --   end,
  --   loc_vars = function(self, info_queue, card)
  --     local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
  --     return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
  --   end,
  --   set_badges = function (self, card, badges)
  --     SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
  --   end,
  -- })

  -- SMODS.Consumable({
  --   object_type = "Consumable",
  --   set = "Shape",
  --   name = "shape_prism",
  --   key = "prism",
  --   pos = { x = 2, y = 5 },
  --   soul_pos = { x = 2, y = 6 },
  --   config = {
  --     val = 0,
  --     partial_rounds = 0,
  --     upgrade_rounds = 12,
  --   },
  --   cost = 4,
  --   atlas = "mf_shapes",
  --   hidden = true,
  --   unlocked = true,
  --   discovered = true,
  --   display_size = { w = 71, h = 87 },
  --   pixel_size = { w = 71, h = 87 },
  --   can_use = function(self, card)
  --     return true
  --   end,
  --   use = function(self, card, area, copier)
  --     for i = 1, card.ability.val do
  --       G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
  --         play_sound('timpani')
  --         local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_entr_beyond', 'sup')
  --         n_card.no_omega = true
  --         n_card:add_to_deck()
  --         n_card:set_edition({negative = true}, true)
  --         G.consumeables:emplace(n_card)
  --         card:juice_up(0.3, 0.5)
  --         return true end }))
  --     end
  --     delay(0.6)
  --   end,
  --   loc_vars = function(self, info_queue, card)
  --     local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
  --     return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
  --   end,
  --   set_badges = function (self, card, badges)
  --     SMODS.create_mod_badges({ mod = SMODS.find_mod("entr")[1] }, badges)
  --   end,
  -- })
  
  -- SMODS.Consumable({
  --   object_type = "Consumable",
  --   set = "Shape",
  --   name = "shape_Brackets",
  --   key = "brackets",
  --   pos = { x = 3, y = 5 },
  --   config = {
  --     val = 0,
  --     partial_rounds = 0,
  --     upgrade_rounds = 4,
  --   },
  --   cost = 4,
  --   atlas = "mf_shapes",
  --   unlocked = true,
  --   discovered = true,
  --   display_size = { w = 71, h = 87 },
  --   pixel_size = { w = 71, h = 87 },
  --   can_use = function(self, card)
  --     return true
  --   end,
  --   use = function(self, card, area, copier)
  --     local card_type = "RCode"
  --     local rng_seed = "brackets"
  --     for i = 1, card.ability.val do
  --       G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
  --         play_sound('timpani')
  --         local n_card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, rng_seed)
  --         n_card:add_to_deck()
  --         n_card:set_edition({negative = true}, true)
  --         G.consumeables:emplace(n_card)
  --         card:juice_up(0.3, 0.5)
  --         return true end }))
  --     end
  --     delay(0.6)
  --   end,
  --   loc_vars = function(self, info_queue, card)
  --     local val, max = progressbar(card.ability.partial_rounds, card.ability.upgrade_rounds)
  --     return { vars = {card.ability.val, val, max, card.ability.upgrade_rounds} }
  --   end
  -- })

  -- Joker Display

  if JokerDisplay then
    local cols = {
      "c_mf_cloud",
      "c_mf_spade",
      "c_mf_omega",
      "c_mf_club",
      "c_mf_rectangle",
      "c_mf_squircle",
      "c_mf_arrow",
      "c_mf_circle",
      "c_mf_heart",
      "c_mf_diamond",
      "c_mf_dollar",
      "c_mf_cog",
      "c_mf_star",
      "c_mf_pentagon",
      "c_mf_pause",
      "c_mf_curvedarrow",
      "c_mf_gem",
      "c_mf_house",
      "c_mf_loss",
      "c_mf_prism",
      "c_mf_brackets",
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

  local inversions = {
    ["c_mf_black"] = "c_mf_cloud",
    ["c_mf_deepblue"] = "c_mf_spade",
    ["c_mf_crimson"] = "c_mf_omega",
    ["c_mf_seaweed"] = "c_mf_club",
    ["c_mf_brown"] = "c_mf_rectangle",
    ["c_mf_grey"] = "c_mf_squircle",
    ["c_mf_silver"] = "c_mf_arrow",
    ["c_mf_white"] = "c_mf_circle",
    ["c_mf_red"] = "c_mf_heart",
    ["c_mf_orange"] = "c_mf_diamond",
    ["c_mf_yellow"] = "c_mf_dollar",
    -- ["c_mf_green"] = "c_mf_cog",
    ["c_mf_blue"] = "c_mf_star",
    -- ["c_mf_lilac"] = "c_mf_pentagon",
    ["c_mf_pink"] = "c_mf_pause",
    -- ["c_mf_peach"] = "c_mf_curved_arrow",
    ["c_mf_new_gold"] = "c_mf_gem",
    ["c_mf_purple"] = "c_mf_house",
    ["c_mf_moonstone"] = "c_mf_loss",
    ["c_mf_gold"] = "c_mf_prism",
    ["c_mf_ooffoo"] = "c_mf_brackets",
  }

  for k, v in pairs(inversions) do
    if Entropy.FlipsideInversions then
      Entropy.FlipsideInversions[k] = v
    end

    if Entropy.FlipsidePureInversions then
      Entropy.FlipsidePureInversions[k] = v
      Entropy.FlipsideInversions[v] = k
    end
  end
end

return init
