function init()

  SMODS.Booster({
    key = "modded_normal_1",
    kind = "Modded",
    atlas = "mf_packs",
    pos = { x = 0, y = 1 },
    config = { extra = 2, choose = 1, modded_pack = true },
    cost = 6,
    weight = 0.96,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      -- ah shit.
      function temp_ban_joker(key)
        if G.GAME.banned_keys[key] == true then
          G.GAME.banned_keys[key] = 214389
        end
        if not G.GAME.banned_keys[key] then 
          G.GAME.banned_keys[key] = 214389
        elseif G.GAME.banned_keys[key] % 214389 == 0 then
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] + 214389
        end
      end
      function temp_unban_joker(key)
        if G.GAME.banned_keys[key] == 214389 then
          G.GAME.banned_keys[key] = nil
        elseif G.GAME.banned_keys[key] % 214389 == 0 then 
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] - 214389
        end
      end
      local vanilla_jokers = {"j_joker", "j_greedy_joker", "j_lusty_joker", "j_wrathful_joker", "j_gluttenous_joker", "j_jolly", "j_zany", "j_mad", "j_crazy", "j_droll", "j_sly", "j_wily", "j_clever", "j_devious", "j_crafty", "j_half", "j_stencil", "j_four_fingers", "j_mime", "j_credit_card", "j_ceremonial", "j_banner", "j_mystic_summit", "j_marble", "j_loyalty_card", "j_8_ball", "j_misprint", "j_dusk", "j_raised_fist", "j_chaos", "j_fibonacci", "j_steel_joker", "j_scary_face", "j_abstract", "j_delayed_grat", "j_hack", "j_pareidolia", "j_gros_michel", "j_even_steven", "j_odd_todd", "j_scholar", "j_business", "j_supernova", "j_ride_the_bus", "j_space", "j_egg", "j_burglar", "j_blackboard", "j_runner", "j_ice_cream", "j_dna", "j_splash", "j_blue_joker", "j_sixth_sense", "j_constellation", "j_hiker", "j_faceless", "j_green_joker", "j_superposition", "j_todo_list", "j_cavendish", "j_card_sharp", "j_red_card", "j_madness", "j_square", "j_seance", "j_riff_raff", "j_vampire", "j_shortcut", "j_hologram", "j_vagabond", "j_baron", "j_cloud_9", "j_rocket", "j_obelisk", "j_midas_mask", "j_luchador", "j_photograph", "j_gift", "j_turtle_bean", "j_erosion", "j_reserved_parking", "j_mail", "j_to_the_moon", "j_hallucination", "j_fortune_teller", "j_juggler", "j_drunkard", "j_stone", "j_golden", "j_lucky_cat", "j_baseball", "j_bull", "j_diet_cola", "j_trading", "j_flash", "j_popcorn", "j_trousers", "j_ancient", "j_ramen", "j_walkie_talkie", "j_selzer", "j_castle", "j_smiley", "j_campfire", "j_ticket", "j_mr_bones", "j_acrobat", "j_sock_and_buskin", "j_swashbuckler", "j_troubadour", "j_certificate", "j_smeared", "j_throwback", "j_hanging_chad", "j_rough_gem", "j_bloodstone", "j_arrowhead", "j_onyx_agate", "j_glass", "j_ring_master", "j_flower_pot", "j_blueprint", "j_wee", "j_merry_andy", "j_oops", "j_idol", "j_seeing_double", "j_matador", "j_hit_the_road", "j_duo", "j_trio", "j_family", "j_order", "j_tribe", "j_stuntman", "j_invisible", "j_brainstorm", "j_satellite", "j_shoot_the_moon", "j_drivers_license", "j_cartomancer", "j_astronomer", "j_burnt", "j_bootstraps", "j_caino", "j_triboulet", "j_yorick", "j_chicot", "j_perkeo"}
      for i = 1, #vanilla_jokers do
        temp_ban_joker(vanilla_jokers[i])
      end
      local n_card = create_card("Joker", G.pack_cards, nil, nil, true, true, nil, "mf_modded")
      -- local ed = poll_edition("mod_pack", 4, false, false)
      -- n_card:set_edition(ed)
      for i = 1, #vanilla_jokers do
        temp_unban_joker(vanilla_jokers[i])
      end
      return n_card
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_modded_pack",
  })

  SMODS.Booster({
    key = "modded_normal_2",
    kind = "Modded",
    atlas = "mf_packs",
    pos = { x = 1, y = 1 },
    config = { extra = 2, choose = 1, modded_pack = true },
    cost = 6,
    weight = 0.96,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      -- ah shit.
      function temp_ban_joker(key)
        if G.GAME.banned_keys[key] == true then
          G.GAME.banned_keys[key] = 214389
        end
        if not G.GAME.banned_keys[key] then 
          G.GAME.banned_keys[key] = 214389
        elseif G.GAME.banned_keys[key] % 214389 == 0 then
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] + 214389
        end
      end
      function temp_unban_joker(key)
        if G.GAME.banned_keys[key] == 214389 then
          G.GAME.banned_keys[key] = nil
        elseif G.GAME.banned_keys[key] % 214389 == 0 then 
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] - 214389
        end
      end
      local vanilla_jokers = {"j_joker", "j_greedy_joker", "j_lusty_joker", "j_wrathful_joker", "j_gluttenous_joker", "j_zany", "j_mad", "j_crazy", "j_droll", "j_sly", "j_wily", "j_clever", "j_devious", "j_crafty", "j_half", "j_stencil", "j_four_fingers", "j_mime", "j_credit_card", "j_ceremonial", "j_banner", "j_mystic_summit", "j_marble", "j_loyalty_card", "j_8_ball", "j_misprint", "j_dusk", "j_raised_fist", "j_chaos", "j_fibonacci", "j_steel_joker", "j_scary_face", "j_abstract", "j_delayed_grat", "j_hack", "j_pareidolia", "j_gros_michel", "j_even_steven", "j_odd_todd", "j_scholar", "j_business", "j_supernova", "j_ride_the_bus", "j_space", "j_egg", "j_burglar", "j_blackboard", "j_runner", "j_ice_cream", "j_dna", "j_splash", "j_blue_joker", "j_sixth_sense", "j_constellation", "j_hiker", "j_faceless", "j_green_joker", "j_superposition", "j_todo_list", "j_cavendish", "j_card_sharp", "j_red_card", "j_madness", "j_square", "j_seance", "j_riff_raff", "j_vampire", "j_shortcut", "j_hologram", "j_vagabond", "j_baron", "j_cloud_9", "j_rocket", "j_obelisk", "j_midas_mask", "j_luchador", "j_photograph", "j_gift", "j_turtle_bean", "j_erosion", "j_reserved_parking", "j_mail", "j_to_the_moon", "j_hallucination", "j_fortune_teller", "j_juggler", "j_drunkard", "j_stone", "j_golden", "j_lucky_cat", "j_baseball", "j_bull", "j_diet_cola", "j_trading", "j_flash", "j_popcorn", "j_trousers", "j_ancient", "j_ramen", "j_walkie_talkie", "j_selzer", "j_castle", "j_smiley", "j_campfire", "j_ticket", "j_mr_bones", "j_acrobat", "j_sock_and_buskin", "j_swashbuckler", "j_troubadour", "j_certificate", "j_smeared", "j_throwback", "j_hanging_chad", "j_rough_gem", "j_bloodstone", "j_arrowhead", "j_onyx_agate", "j_glass", "j_ring_master", "j_flower_pot", "j_blueprint", "j_wee", "j_merry_andy", "j_oops", "j_idol", "j_seeing_double", "j_matador", "j_hit_the_road", "j_duo", "j_trio", "j_family", "j_order", "j_tribe", "j_stuntman", "j_invisible", "j_brainstorm", "j_satellite", "j_shoot_the_moon", "j_drivers_license", "j_cartomancer", "j_astronomer", "j_burnt", "j_bootstraps", "j_caino", "j_triboulet", "j_yorick", "j_chicot", "j_perkeo"}
      for i = 1, #vanilla_jokers do
        temp_ban_joker(vanilla_jokers[i])
      end
      local n_card = create_card("Joker", G.pack_cards, nil, nil, true, true, nil, "mf_modded")
      -- local ed = poll_edition("mod_pack", 4, false, false)
      -- n_card:set_edition(ed)
      for i = 1, #vanilla_jokers do
        temp_unban_joker(vanilla_jokers[i])
      end
      return n_card
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_modded_pack",
  })

  SMODS.Booster({
    key = "modded_jumbo_1",
    kind = "Modded",
    atlas = "mf_packs",
    pos = { x = 2, y = 1 },
    config = { extra = 4, choose = 1, modded_pack = true },
    cost = 10,
    weight = 0.96,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      -- ah shit.
      function temp_ban_joker(key)
        if G.GAME.banned_keys[key] == true then
          G.GAME.banned_keys[key] = 214389
        end
        if not G.GAME.banned_keys[key] then 
          G.GAME.banned_keys[key] = 214389
        elseif G.GAME.banned_keys[key] % 214389 == 0 then
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] + 214389
        end
      end
      function temp_unban_joker(key)
        if G.GAME.banned_keys[key] == 214389 then
          G.GAME.banned_keys[key] = nil
        elseif G.GAME.banned_keys[key] % 214389 == 0 then 
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] - 214389
        end
      end
      local vanilla_jokers = {"j_joker", "j_greedy_joker", "j_lusty_joker", "j_wrathful_joker", "j_gluttenous_joker", "j_zany", "j_mad", "j_crazy", "j_droll", "j_sly", "j_wily", "j_clever", "j_devious", "j_crafty", "j_half", "j_stencil", "j_four_fingers", "j_mime", "j_credit_card", "j_ceremonial", "j_banner", "j_mystic_summit", "j_marble", "j_loyalty_card", "j_8_ball", "j_misprint", "j_dusk", "j_raised_fist", "j_chaos", "j_fibonacci", "j_steel_joker", "j_scary_face", "j_abstract", "j_delayed_grat", "j_hack", "j_pareidolia", "j_gros_michel", "j_even_steven", "j_odd_todd", "j_scholar", "j_business", "j_supernova", "j_ride_the_bus", "j_space", "j_egg", "j_burglar", "j_blackboard", "j_runner", "j_ice_cream", "j_dna", "j_splash", "j_blue_joker", "j_sixth_sense", "j_constellation", "j_hiker", "j_faceless", "j_green_joker", "j_superposition", "j_todo_list", "j_cavendish", "j_card_sharp", "j_red_card", "j_madness", "j_square", "j_seance", "j_riff_raff", "j_vampire", "j_shortcut", "j_hologram", "j_vagabond", "j_baron", "j_cloud_9", "j_rocket", "j_obelisk", "j_midas_mask", "j_luchador", "j_photograph", "j_gift", "j_turtle_bean", "j_erosion", "j_reserved_parking", "j_mail", "j_to_the_moon", "j_hallucination", "j_fortune_teller", "j_juggler", "j_drunkard", "j_stone", "j_golden", "j_lucky_cat", "j_baseball", "j_bull", "j_diet_cola", "j_trading", "j_flash", "j_popcorn", "j_trousers", "j_ancient", "j_ramen", "j_walkie_talkie", "j_selzer", "j_castle", "j_smiley", "j_campfire", "j_ticket", "j_mr_bones", "j_acrobat", "j_sock_and_buskin", "j_swashbuckler", "j_troubadour", "j_certificate", "j_smeared", "j_throwback", "j_hanging_chad", "j_rough_gem", "j_bloodstone", "j_arrowhead", "j_onyx_agate", "j_glass", "j_ring_master", "j_flower_pot", "j_blueprint", "j_wee", "j_merry_andy", "j_oops", "j_idol", "j_seeing_double", "j_matador", "j_hit_the_road", "j_duo", "j_trio", "j_family", "j_order", "j_tribe", "j_stuntman", "j_invisible", "j_brainstorm", "j_satellite", "j_shoot_the_moon", "j_drivers_license", "j_cartomancer", "j_astronomer", "j_burnt", "j_bootstraps", "j_caino", "j_triboulet", "j_yorick", "j_chicot", "j_perkeo"}
      for i = 1, #vanilla_jokers do
        temp_ban_joker(vanilla_jokers[i])
      end
      local n_card = create_card("Joker", G.pack_cards, nil, nil, true, true, nil, "mf_colour")
      -- local ed = poll_edition("mod_pack", 4, false, false)
      -- n_card:set_edition(ed)
      for i = 1, #vanilla_jokers do
        temp_unban_joker(vanilla_jokers[i])
      end
      return n_card
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_modded_pack",
  })

  SMODS.Booster({
    key = "modded_mega_1",
    kind = "Modded",
    atlas = "mf_packs",
    pos = { x = 3, y = 1 },
    config = { extra = 4, choose = 2, modded_pack = true },
    cost = 14,
    weight = 0.96,
    unlocked = true,
    discovered = true,
    create_card = function(self, card)
      -- ah shit.
      function temp_ban_joker(key)
        if G.GAME.banned_keys[key] == true then
          G.GAME.banned_keys[key] = 214389
        end
        if not G.GAME.banned_keys[key] then 
          G.GAME.banned_keys[key] = 214389
        elseif G.GAME.banned_keys[key] % 214389 == 0 then
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] + 214389
        end
      end
      function temp_unban_joker(key)
        if G.GAME.banned_keys[key] == 214389 then
          G.GAME.banned_keys[key] = nil
        elseif G.GAME.banned_keys[key] % 214389 == 0 then 
          G.GAME.banned_keys[key] = G.GAME.banned_keys[key] - 214389
        end
      end
      local vanilla_jokers = {"j_joker", "j_greedy_joker", "j_lusty_joker", "j_wrathful_joker", "j_gluttenous_joker", "j_zany", "j_mad", "j_crazy", "j_droll", "j_sly", "j_wily", "j_clever", "j_devious", "j_crafty", "j_half", "j_stencil", "j_four_fingers", "j_mime", "j_credit_card", "j_ceremonial", "j_banner", "j_mystic_summit", "j_marble", "j_loyalty_card", "j_8_ball", "j_misprint", "j_dusk", "j_raised_fist", "j_chaos", "j_fibonacci", "j_steel_joker", "j_scary_face", "j_abstract", "j_delayed_grat", "j_hack", "j_pareidolia", "j_gros_michel", "j_even_steven", "j_odd_todd", "j_scholar", "j_business", "j_supernova", "j_ride_the_bus", "j_space", "j_egg", "j_burglar", "j_blackboard", "j_runner", "j_ice_cream", "j_dna", "j_splash", "j_blue_joker", "j_sixth_sense", "j_constellation", "j_hiker", "j_faceless", "j_green_joker", "j_superposition", "j_todo_list", "j_cavendish", "j_card_sharp", "j_red_card", "j_madness", "j_square", "j_seance", "j_riff_raff", "j_vampire", "j_shortcut", "j_hologram", "j_vagabond", "j_baron", "j_cloud_9", "j_rocket", "j_obelisk", "j_midas_mask", "j_luchador", "j_photograph", "j_gift", "j_turtle_bean", "j_erosion", "j_reserved_parking", "j_mail", "j_to_the_moon", "j_hallucination", "j_fortune_teller", "j_juggler", "j_drunkard", "j_stone", "j_golden", "j_lucky_cat", "j_baseball", "j_bull", "j_diet_cola", "j_trading", "j_flash", "j_popcorn", "j_trousers", "j_ancient", "j_ramen", "j_walkie_talkie", "j_selzer", "j_castle", "j_smiley", "j_campfire", "j_ticket", "j_mr_bones", "j_acrobat", "j_sock_and_buskin", "j_swashbuckler", "j_troubadour", "j_certificate", "j_smeared", "j_throwback", "j_hanging_chad", "j_rough_gem", "j_bloodstone", "j_arrowhead", "j_onyx_agate", "j_glass", "j_ring_master", "j_flower_pot", "j_blueprint", "j_wee", "j_merry_andy", "j_oops", "j_idol", "j_seeing_double", "j_matador", "j_hit_the_road", "j_duo", "j_trio", "j_family", "j_order", "j_tribe", "j_stuntman", "j_invisible", "j_brainstorm", "j_satellite", "j_shoot_the_moon", "j_drivers_license", "j_cartomancer", "j_astronomer", "j_burnt", "j_bootstraps", "j_caino", "j_triboulet", "j_yorick", "j_chicot", "j_perkeo"}
      for i = 1, #vanilla_jokers do
        temp_ban_joker(vanilla_jokers[i])
      end
      local n_card = create_card("Joker", G.pack_cards, nil, nil, true, true, nil, "mf_colour")
      -- local ed = poll_edition("mod_pack", 4, false, false)
      -- n_card:set_edition(ed, true, false)
      for i = 1, #vanilla_jokers do
        temp_unban_joker(vanilla_jokers[i])
      end
      return n_card
    end,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_modded_pack",
  })

  SMODS.Tag({
    key = "moddedpack",
    atlas = "mf_tags",
    pos = { x = 0, y = 1 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue)
      info_queue[#info_queue + 1] = { set = "Other", key = "p_mf_modded_jumbo_1", specific_vars = { 1, 4 } }
      return { vars = {} }
    end,
    apply = function(self, tag, context)
      if context.type == "new_blind_choice" then
        tag:yep("+", G.C.SECONDARY_SET.Code, function()
          local key = "p_mf_modded_jumbo_1"
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
    SMODS.Tag({
      key = "emoddedpack",
      atlas = "mf_ascendant_tags",
      pos = { x = 0, y = 1 },
      unlocked = true,
      discovered = true,
      loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { set = "Other", key = "p_mf_modded_jumbo_1", specific_vars = { 1, 4 } }
        return { vars = {} }
      end,
	    in_pool = function() return false end or nil,
      apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
          tag:yep("+", G.C.SECONDARY_SET.Code, function()
            local key = "p_mf_modded_jumbo_1"
            local card = Card(
              G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
              G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
              G.CARD_W * 1.27,
              G.CARD_H * 1.27,
              G.P_CARDS.empty,
              G.P_CENTERS[key],
              { bypass_discovery_center = true, bypass_discovery_ui = true }
            )
            card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entr_saint")).key)
            card.cost = 0
            card.from_tag = true
            G.FUNCS.use_card({ config = { ref_table = card } })
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

    Entropy.AscendedTags["tag_mf_moddedpack"] = "tag_mf_emoddedpack"
  end
end
return init