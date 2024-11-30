--- STEAMODDED HEADER
--- MOD_NAME: More Fluff
--- MOD_ID: MoreFluff
--- PREFIX: mf
--- MOD_AUTHOR: [notmario]
--- MOD_DESCRIPTION: Back, despite popular demand
--- BADGE_COLOR: 814BA8
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0909a]
--- VERSION: 1.0.1e

local current_mod = SMODS.current_mod
local mod_path = SMODS.current_mod.path
mf_config = SMODS.current_mod.config
local folder = string.match(mod_path, "[Mm]ods.*")

if mf_config["Jokers"] == nil then
  mf_config["Jokers"] = true
end
if mf_config["Colour Cards"] == nil then
  mf_config["Colour Cards"] = true
end
if mf_config["Colour Pack Music"] == nil then
  mf_config["Colour Pack Music"] = true
end
if mf_config["Achievements"] == nil then
  mf_config["Achievements"] = true
end

if Cryptid then
  SMODS.load_mod_config(SMODS.Mods.Cryptid)
end

SMODS.Sound({
	key = "music_colourpack",
	path = "music_colourpack.ogg",
	select_music_track = function()
		return (
      mf_config["Colour Pack Music"] and 
      (
        G.pack_cards
        and G.pack_cards.cards
        and G.pack_cards.cards[1]
        and G.pack_cards.cards[1].ability.set == "Colour"
      )
    )
	end,
})

-- comment out the shit you dont want
local joker_list = {
  -- common
  "basepaul_card",
  "clownfish",
  "expansion_pack",
  "hollow",
  "jester",
  "lollipop",
  "luckycharm",
  "monochrome",
  "mspaint",
  "simplified",
  "spiral",
  "treasuremap",
  "philosophical",

  -- uncommon
  "badlegaldefence",
  "clipart",

  -- uncommon (spire) - these should be together in the collection and in class order
  "dropkick",
  "bladedance",
  "hyperbeam",
  "blasphemy",
  "dramaticentrance",

  -- other uncommons
  "coupon_catalogue",
  "css",
  "globe",
  "goldencarrot",
  "hallofmirrors",
  "impostor",
  "tonersoup",
  "loadeddisk",
  "stylemeter",
  "teacup",
  "recycling",
  "virtual",

  -- rare
  "bloodpact",
  "bowlingball",
  "cba",
  "fleshprison",
  "hugejoker",
  "jankman",
  "mashupalbum",
  "pixeljoker",
  "rainbowjoker",
  "rosetinted",
  "the_solo",

  -- legendary!!
  "triangle",

  -- epic?????
  -- "fleshpanopticon", -- IT'S IN CRYPTID NOW

  -- exotic?!?!
  "colorem",
}

if not mf_config["Jokers"] then
  joker_list = {}
end

function has(table, elem)
  for i = 1,#table do
    if table[i] == elem then
      return true
    end
  end
  return false
end

local to_big = to_big or function(num)
  return num
end

for _, v in ipairs(joker_list) do
  print(v)
  local joker = SMODS.load_file("jokers/"..v..".lua")()
  if not joker then
    goto continue
  end
  joker.key = v
  joker.atlas = "mf_jokers"
  if not joker.pos then
    joker.pos = { x = 0, y = 0 }
  end

  local joker_obj = SMODS.Joker(joker)
  for k_, v_ in pairs(joker) do
    if type(v_) == 'function' then
      joker_obj[k_] = joker[k_]
    end
  end

  ::continue::
end

SMODS.Atlas({ 
  key = "mf_jokers", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_jokers.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_colours", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_colours.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_packs", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_packs.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_vouchers", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_vouchers.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_enhancers", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_enhancers.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({
  key = "modicon",
  path = "mf_icon.png",
  px = 32,
  py = 32
})
if CardSleeves then
  SMODS.Atlas({
    key = "mf_sleeves", 
    atlas_table = "ASSET_ATLAS", 
    path = "mf_sleeves.png", 
    px = 71, 
    py = 95 
  })
end

-- add a way for these to be disabled
if mf_config["Colour Cards"] then
  init_cols = SMODS.load_file("other/colours.lua")()
  init_cols()
else
  function colour_end_of_round_effects()

  end
end

SMODS.Back({
	name = "Gros Michel Deck",
	key = "grosmichel",
	config = { mf_grosmichel = true },
	pos = { x = 0, y = 0 },
	atlas = "mf_enhancers",
  unlocked = true,
})

if CardSleeves then
  CardSleeves.Sleeve({
    name = "Gros Michel Sleeve",
    key="grosmichel",
    atlas="mf_sleeves",
    pos = { x = 0, y = 0 },
    unlocked = true,
    loc_vars = function(self)
      local key
      if self.get_current_deck_name() ~= "Gros Michel Deck" then
        key = self.key
      else
        key = self.key .. "_alt"
      end
      return { key = key }
    end,
    apply = function(self)
      if self.get_current_deck_name() ~= "Gros Michel Deck" then
        G.E_MANAGER:add_event(Event({
          func = function()
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_gros_michel', nil)
            card:add_to_deck()
            G.jokers:emplace(card)
            return true
          end
        }))
      else
        G.E_MANAGER:add_event(Event({
          func = function()
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_cavendish', nil)
            card:add_to_deck()
            G.jokers:emplace(card)
            return true
          end
        }))
      end
    end
  })
end

if has(joker_list, "philosophical") then
  SMODS.Back({
    name = "Philosophical Deck",
    key = "philosophical",
    config = { mf_philosophical = true },
    pos = { x = 1, y = 0 },
    atlas = "mf_enhancers",
    unlocked = true,
  })

  if CardSleeves then
    CardSleeves.Sleeve({
      name = "Philosophical Sleeve",
      key="philosophical",
      atlas="mf_sleeves",
      pos = { x = 1, y = 0 },
      unlocked = true,
      loc_vars = function(self)
        local key
        if self.get_current_deck_name() ~= "Philosophical Deck" then
          key = self.key
        else
          key = self.key .. "_alt"
        end
        return { key = key }
      end,
      apply = function(self)
        G.E_MANAGER:add_event(Event({
          func = function()
            for i = 1,5 do
              local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mf_philosophical', nil)
              card:add_to_deck()
              G.jokers:emplace(card)
            end
            return true
          end
        }))
      end
    })
  end
end

if mf_config["Colour Cards"] then
  SMODS.Back({
    name = "Rainbow Deck",
    key = "rainbow",
    config = { voucher = 'v_mf_paintroller', consumables = {'c_mf_white'} },
    pos = { x = 2, y = 0 },
    atlas = "mf_enhancers",
    unlocked = true,
  })

  if CardSleeves then
    CardSleeves.Sleeve({
      key = "rainbow",
      name = "Rainbow Sleeve",
      atlas = "mf_sleeves",
      pos = { x = 2, y = 0 },
      unlocked = true,
      loc_vars = function(self)
        local key
        if self.get_current_deck_name() ~= "Rainbow Deck" then
          key = self.key
          self.config = { voucher = 'v_mf_paintroller', consumables = { 'c_mf_white' } }
        else
          key = self.key .. "_alt"
          self.config = { voucher = "v_mf_colourtheory" }
        end
        return { key = key }
      end
    })
  end
end

if has(joker_list, "blasphemy") then
  SMODS.Back({
    name = "Blasphemous Deck",
    key = "blasphemy",
    config = { mf_blasphemy = true },
    pos = { x = 3, y = 0 },
    atlas = "mf_enhancers",
    unlocked = true,
  })
  if CardSleeves then
    CardSleeves.Sleeve({
      name = "Blasphemous Sleeve",
      key="blasphemy",
      atlas="mf_sleeves",
      pos = { x = 3, y = 0 },
      unlocked = true,
      loc_vars = function(self)
        local key
        if self.get_current_deck_name() ~= "Blasphemous Deck" then
          key = self.key
        else
          key = self.key .. "_alt"
        end
        return { key = key }
      end,
      apply = function(self)
        if self.get_current_deck_name() ~= "Blasphemous Deck" then
          G.E_MANAGER:add_event(Event({
            func = function()
              local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mf_blasphemy', nil)
              card:add_to_deck()
              card:set_edition({negative = true})
              card:set_eternal(true)
              G.jokers:emplace(card)
              return true
            end
          }))
        else
          G.E_MANAGER:add_event(Event({
            func = function()
              local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mf_blasphemy', nil)
              card:add_to_deck()
              card:set_edition({negative = true})
              G.jokers:emplace(card)
              return true
            end
          }))
        end
      end
    })
  end
end

local old_back_apply_to_run = Back.apply_to_run
function Back.apply_to_run(self)
  old_back_apply_to_run(self)
  if self.effect.config.mf_grosmichel then
    sendDebugMessage(G.GAME.selected_sleeve)
    if not (CardSleeves and (G.GAME.selected_sleeve or "sleeve_casl_none") == "sleeve_mf_grosmichel") then
      G.E_MANAGER:add_event(Event({
        func = function()
          local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_gros_michel', nil)
          card:add_to_deck()
          G.jokers:emplace(card)
          return true
        end
      }))
    end
  end
  if self.effect.config.mf_philosophical then
    G.E_MANAGER:add_event(Event({
      func = function()
        for i = 1,5 do
          local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mf_philosophical', nil)
          card:add_to_deck()
          G.jokers:emplace(card)
        end
        return true
      end
    }))
  end
  if self.effect.config.mf_blasphemy then
    if not (CardSleeves and (G.GAME.selected_sleeve or "sleeve_casl_none") == "sleeve_mf_blasphemy") then
      G.E_MANAGER:add_event(Event({
        func = function()
          local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mf_blasphemy', nil)
          card:add_to_deck()
          card:set_edition({negative = true})
          card:set_eternal(true)
          G.jokers:emplace(card)
          return true
        end
      }))
    end
  end
end

if mf_config["Achievements"] then
  SMODS.Atlas({
    key = "mf_achievements",
    path = "mf_achievements.png",
    px = 66,
    py = 66,
  })

  SMODS.Achievement({
    key = "mf_ten_colour_rounds",
    order = 1,
    bypass_all_unlocked = true,
    atlas = "mf_achievements",
    --reset_on_startup = true,
    unlock_condition = function(self, args)
      if
        args.type == "mf_ten_colour_rounds"
      then
        return true
      end
    end,
  })
  SMODS.Achievement({
    key = "mf_whos_paul",
    order = 2,
    bypass_all_unlocked = true,
    atlas = "mf_achievements",
    --reset_on_startup = true,
    unlock_condition = function(self, args)
      if
        args.type == "mf_trigger_paul"
      then
        return true
      end
    end,
  })
  SMODS.Achievement({
    key = "mf_jank_it_up",
    order = 3,
    bypass_all_unlocked = true,
    atlas = "mf_achievements",
    --reset_on_startup = true,
    unlock_condition = function(self, args)
      if args.type == "modify_jokers" then
        local jankman_count = 0
  
        if G.jokers then
          for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_mf_jankman" then
              jankman_count = jankman_count + 1
            end
          end
        end
  
        if jankman_count >= 3 then
          return true
        end
      end
    end,
  })
  SMODS.Achievement({
    key = "mf_dropkick_ten_hands",
    order = 4,
    bypass_all_unlocked = true,
    atlas = "mf_achievements",
    --reset_on_startup = true,
    unlock_condition = function(self, args)
      if
        args.type == "mf_dropkick_ten_hands"
      then
        return true
      end
    end,
  })
  SMODS.Achievement({
    key = "mf_negative_philosophical",
    order = 5,
    bypass_all_unlocked = true,
    atlas = "mf_achievements",
    --reset_on_startup = true,
    unlock_condition = function(self, args)
      if args.type == "modify_jokers" then
        if G.jokers then
          for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_mf_philosophical" and 
              (G.jokers.cards[i].edition and G.jokers.cards[i].edition.negative) then
              return true
            end
          end
        end
  
        return false
      end
    end,
  })
  SMODS.Achievement({
    key = "mf_huge_and_pixel",
    order = 6,
    bypass_all_unlocked = true,
    atlas = "mf_achievements",
    --reset_on_startup = true,
    unlock_condition = function(self, args)
      if args.type == "modify_jokers" then
        local has_huge = false
        local has_pixel = false
        if G.jokers then
          for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_mf_hugejoker" then
              has_huge = true
            end
            if G.jokers.cards[i].config.center.key == "j_mf_pixeljoker" then
              has_pixel = true
            end
          end
        end
  
        return has_huge and has_pixel
      end
    end,
  })
end

-- cryptid pool additions
if Cryptid then
  -- check if we are running against an older version of cryptid
  if Cryptid.food then
    local food_jokers = {
      "j_mf_lollipop",
      "j_mf_goldencarrot",
      "j_mf_teacup",
    }
    for i = 1, #food_jokers do
      Cryptid.food[#Cryptid.food+1] = food_jokers[i]
    end
  end
  if Cryptid.memepack then
    local meme_jokers = {
      "j_mf_basepaulcard", -- Paul
      "j_mf_blasphemy", -- it can instakill you that's funny right
      "j_mf_cba", -- Chess Battle Advanced
      "j_mf_hugejoker", -- it's huge
      "j_mf_jankman", -- Love That Janker
      "j_mf_impostor", -- Sus
    }
    for i = 1, #meme_jokers do
      Cryptid.memepack[#Cryptid.memepack+1] = meme_jokers[i]
    end
  end
  if Cryptid.aliases then
    local aliases = {
      paul = "basepaul card",
      basepaul = "basepaul card",
      bowling = "bowling ball",
      cba = "card buffer advanced",
      clipart = "clipart joker",
      coupon = "coupon catalogue",
      dramatic = "dramatic entrance",
      expansion = "expansion pack",
      carrot = "golden carrot",
      hollow = "hollow joker",
      huge = "huge joker",
      beam = "hyper beam",
      jank = "jankman",
      loaded = "loaded disk",
      mashup = "mashup album",
      mspaint = "ms paint joker",
      philosophical = "philosophical joker",
      rainbow = "rainbow joker",
      rose = "rose-tinted glasses",
      rosetinted = "rose-tinted glasses",
      ["rose-tinted"] = "rose-tinted glasses",
      rosetintedglasses = "rose-tinted glasses",
      simplified = "simplified joker",
      simplifiedjoker = "simplified joker",
      style = "stylemeter",
      solo = "the solo",
      treasure = "treasure map",
      virtual = "virtual joker",
      ooffoo = "00FF00",
      lime = "00FF00",
      toner = "i sip toner soup",
      tonersoup = "i sip toner soup",
      isiptonersoup = "i sip toner soup",
    }
    for k, v in pairs(aliases) do
      Cryptid.aliases[k] = v
    end
  end
end

--- hooks

local update_round_evalref = Game.update_round_eval
function Game:update_round_eval(dt)
  update_round_evalref(self, dt)

  -- thanks feder
  -- does CA even have a 1.0.0 port?
  if G.bladedance_temp_ids then
    for _, remove_id in ipairs(G.bladedance_temp_ids) do
      for k, card in ipairs(G.playing_cards) do
        if card.unique_val == remove_id then
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
            func = function()
            G.deck:remove_card(card)
            G.hand:remove_card(card)
            G.discard:remove_card(card)
            card:start_dissolve(nil, false)
            card = nil
          return true; end})) 
        end
      end
      -- for k, card in ipairs(G.hand.cards) do
      --     if card.unique_val == remove_id then
      --         G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
      --             func = function()
      --             G.hand:remove_card(card)
      --             hand:remove()
      --             card = nil
      --         return true; end})) 
      --     end
      -- end
    end
    G.bladedance_temp_ids = {}
  end
  if G.do_colour_end_of_round_stuff then
    colour_end_of_round_effects()

    G.do_colour_end_of_round_stuff = false
  end
end

local old_g_funcs_check_for_buy_space = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
  if card.ability.name == "Philosophical Joker" and card.ability.extra >= 1 then
    return true
  end
  return old_g_funcs_check_for_buy_space(card)
end

local old_g_funcs_can_select_card = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
  if e.config.ref_table.ability.name == "Philosophical Joker" and e.config.ref_table.ability.extra >= 1 then 
    e.config.colour = G.C.GREEN
    e.config.button = 'use_card'
  else
    old_g_funcs_can_select_card(e)
  end
end

local update_blind_selectref = Game.update_blind_select
function Game:update_blind_select(dt)
  update_blind_selectref(self, dt)
  G.do_colour_end_of_round_stuff = true
end

-- config menu

local morefluffTabs = function() return {
	{
		label = localize("mf_config_features"),
		chosen = true,
		tab_definition_function = function()
			mf_nodes = {}
			settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("mf_config_jokers"), ref_table = mf_config, ref_value = "Jokers" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("mf_config_colour_cards"), ref_table = mf_config, ref_value = "Colour Cards" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("mf_config_colour_music"), ref_table = mf_config, ref_value = "Colour Pack Music" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("mf_config_achievements"), ref_table = mf_config, ref_value = "Achievements" })
			config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
			mf_nodes[#mf_nodes + 1] = config
			return {
				n = G.UIT.ROOT,
				config = {
					emboss = 0.05,
					minh = 6,
					r = 0.1,
					minw = 10,
					align = "cm",
					padding = 0.2,
					colour = G.C.BLACK,
				},
				nodes = mf_nodes,
			}
		end,
	},
} end
SMODS.current_mod.extra_tabs = morefluffTabs
