FLUFF = {}
local current_mod = SMODS.current_mod
MoreFluff = SMODS.current_mod

current_mod.optional_features = {
  retrigger_joker = true,
}

SMODS.Rarity {
  key = "token",
  badge_colour = HEX("474747"),
  loc_txt = {
    name = "Token"
  }
}

local mod_path = SMODS.current_mod.path
mf_config = SMODS.current_mod.config
local folder = string.match(mod_path, "[Mm]ods.*")

if mf_config["Jokers"] == nil then
  mf_config["Jokers"] = true
end
if mf_config["Colour Cards"] == nil then
  mf_config["Colour Cards"] = true
end
if mf_config["Music"] == nil then
  mf_config["Music"] = true
end
if mf_config["45 Degree Rotated Tarot Cards"] == nil then
  mf_config["45 Degree Rotated Tarot Cards"] = true
end
if mf_config["Achievements"] == nil then
  mf_config["Achievements"] = true
end
if mf_config["Huger Joker"] == nil then
  mf_config["Huger Joker"] = false
end
if mf_config["Programmer Art"] == nil then
  mf_config["Programmer Art"] = false
end
if mf_config["Disable Art Credits"] == nil then
  mf_config["Disable Art Credits"] = false
end
if mf_config["Superboss"] == nil then
  mf_config["Superboss"] = true
end
if mf_config["Other Tags"] == nil then
  mf_config["Other Tags"] = true
end
if mf_config["Other Packs"] == nil then
  mf_config["Other Packs"] = true
end
if mf_config["Horse Sound"] == nil then
  mf_config["Horse Sound"] = true
end
-- if mf_config["Unfinished"] == nil then
--   mf_config["Unfinished"] = false
-- end

if next(SMODS.find_mod("Cryptid")) then
  SMODS.load_mod_config(SMODS.Mods.Cryptid)
end

SMODS.Sound({
	key = "music_colourpack",
	path = "music_colourpack.ogg",
	select_music_track = function()
		return (
      mf_config["Music"] and 
      (
        G.pack_cards
        and G.pack_cards.cards
        and G.pack_cards.cards[1]
        and G.pack_cards.cards[1].ability.set == "Colour"
      )
    )
	end,
})

SMODS.Sound({
	key = "music_rotarot",
	path = "music_rotarot.ogg",
	select_music_track = function()
		return (
      mf_config["Music"] and 
      (
        G.pack_cards
        and G.pack_cards.cards
        and G.pack_cards.cards[1]
        and G.pack_cards.cards[1].ability.set == "Rotarot"
      )
    )
	end,
})

SMODS.Sound({
  key = "music_modded",
  path = "music_modded.ogg",
  select_music_track = function()
    return (
      mf_config["Music"] and
      (
        (SMODS.OPENED_BOOSTER or {}).ability or {}).modded_pack 
        and G.booster_pack and not G.booster_pack.REMOVED
      )
      and 2
  end,
})

SMODS.Sound({
  key = "music_duelzone",
  path = "music_duelzone.ogg",
  sync = false,
  pitch = 1,
  select_music_track = function()
    return
      mf_config["Music"] and G.GAME.superboss_active
      and 6 -- notably lower than jimball (Funny)
  end,
})

SMODS.Sound({key = "gun", path = "gun.ogg"})
SMODS.Sound({key = "treethree", path = "treethree.ogg"})
SMODS.Sound({key = "buzzer", path = "buzzer.ogg"})
SMODS.Sound({key = "lightningstrikesthrice", path = "lightningstrikesthrice.ogg"})
SMODS.Sound({key = "horsebounce", path = "horsebounce.ogg"})

-- comment out the shit you dont want
local joker_list = {
  -- common
  "basepaul_card",
  "blahaj",
  "clownfish",
  "expansion_pack",
  "hollow",
  "jackofalltrades",
  "jester",
  "lollipop",
  "luckycharm",
  -- "monochrome", -- Cut.
  "mspaint",
  "philosophical",
  "simplified",
  "spiral",
  "treasuremap",
  "unregisteredhypercam",

  -- uncommon (spire) - these should be together in the collection and in class order
  "dropkick",
  "bladedance",
  "hyperbeam",
  "blasphemy",
  "dramaticentrance",

  -- other uncommons
  "badlegaldefence",
  "blunder",
  "brilliant",
  "broomcloset",
  "rot_cartomancer",
  "clipart",
  "coupon_catalogue",
  "css",
  "cueball",
  "dinner",
  "forge",
  "flintandsteel",
  "gemstonejoker",
  "globe",
  "goldencarrot",
  "hallofmirrors",
  "impostor",
  "farmmerge",
  "friendinsideme",
  "junkmail",
  "onesliptoolate",
  "tonersoup",
  "unpleasantcard",
  "lightningstrikesthrice",
  "loadeddisk",
  "missingjoker",
  "paintcan",
  "passando",
  "rosetinted",
  "sapling",
  "snake",
  "slotmachine",
  "stylemeter",
  "stonejokerjoker",
  "sudoku",
  "talljoker",
  "teacup",
  "tealjoker",
  "thewayhome",
  "recycling",
  "virtual",
  -- "wilddrawfour",
  "yuckyrat",

  -- rare
  "allicantdo",
  "bloodpact",
  "bookmove",
  "brass",
  "bowlingball",
  "cba",
  "complexitycreep",
  "doubledscale",
  "fleshprison",
  "grep",
  "hugejoker",
  "hyperjimbo",
  "jankman",
  "mashupalbum",
  "pixeljoker",
  "rainbowjoker",
  "the_solo",
  "top10",
  "widejoker",
  
  -- legendary!!
  "triangle",
  "marigold",

  -- walkers
  "mindsculptor",
  "johnbalatro",
  "trianglewalker",
  
  -- rare, but it goes last (Unless Cryptid...)
  "lessfluff",

  "johnbalatrotrue",

  -- 1.3
  -- "selfinsert", -- cut this one for now (its not happening)

  -- busted shit
  -- "colorem", -- pulled out into cryptid world
  -- "farmmergecivilisation", -- likewise

  -- tokens
  "forgeslop",
  "oopsallfives",
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

-- I don't think these are needed anymore since Talisman is a dependency but idk lol -- Jevonn
to_big = to_big or function(num)
  return num
end
to_number = to_number or function(jevonn_was_here)
  return jevonn_was_here
end

for _, v in ipairs(joker_list) do
  print(v)
  local joker = SMODS.load_file("jokers/"..v..".lua")()
  if not joker then
    goto continue
  end
  if not joker.key then
    joker.key = v
  end
  joker.atlas = "mf_jokers"
  if v == "hyperjimbo" then
    joker.atlas = "mf_hyperjimbo"
  end
  if v == "rot_cartomancer" then
    joker.atlas = "mf_rot_cartomancer"
  end
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

-- if mf_config["Unfinished"] then

--   local ortalab_jokers = {
--     -- common
--     "clintcondition",
--     "sheetsuggestion",

--     -- uncommon
--     "devilsknife",

--     -- rare
--     "twotrucks"
--   }

--   local familiar_jokers = {
--     -- common
--     "jimbojjoker"
--   }

--   if not mf_config["Jokers"] then
--     ortalab_jokers = {}
--     familiar_jokers = {}
--   end

--   for _, v in ipairs(ortalab_jokers) do
--     print(v)
--     local joker = SMODS.load_file("jokers/ortalab/"..v..".lua")()
--     if not joker then
--       goto eunitnoc
--     end
--     joker.key = v
--     joker.atlas = "mf_srekoj"
--     if not joker.pos then
--       joker.pos = { x = 0, y = 0 }
--     end

--     local joker_obj = SMODS.Joker(joker)
--     for k_, v_ in pairs(joker) do
--       if type(v_) == 'function' then
--         joker_obj[k_] = joker[k_]
--       end
--     end
--     joker_obj.jank_force_badge = {
--       name = "ffulF eroM",
--       col = G.C.GREEN
--     }

--     ::eunitnoc::
--   end

--   for _, v in ipairs(familiar_jokers) do
--     print(v)
--     local joker = SMODS.load_file("jokers/familiar/"..v..".lua")()
--     if not joker then
--       goto continue_fam
--     end
--     joker.key = v
--     joker.atlas = "mf_srekoj"
--     if not joker.pos then
--       joker.pos = { x = 0, y = 0 }
--     end
--     joker.pos.x = joker.pos.x + 10

--     local joker_obj = SMODS.Joker(joker)
--     for k_, v_ in pairs(joker) do
--       if type(v_) == 'function' then
--         joker_obj[k_] = joker[k_]
--       end
--     end
--     joker_obj.jank_force_badge = {
--       name = "Ectoplasm",
--       col = G.C.DARK_EDITION
--     }

--     ::continue_fam::
--   end
-- end

local smods_cmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
  if not SMODS.config.no_mod_badges and obj and obj.jank_force_badge then
    local mod_name = obj.jank_force_badge.name
    local size = 0.9
    local font = G.LANG.font
    local max_text_width = 2 - 2*0.05 - 4*0.03*size - 2*0.03
    local calced_text_width = 0
    -- Math reproduced from DynaText:update_text
    for _, c in utf8.chars(mod_name) do
        local tx = font.FONT:getWidth(c)*(0.33*size)*G.TILESCALE*font.FONTSCALE + 2.7*1*G.TILESCALE*font.FONTSCALE
        calced_text_width = calced_text_width + tx/(G.TILESIZE*G.TILESCALE)
    end
    local scale_fac =
        calced_text_width > max_text_width and max_text_width/calced_text_width
        or 1
    badges[#badges + 1] = {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.R, config={align = "cm", colour = obj.jank_force_badge.col, r = 0.1, minw = 2, minh = 0.36, emboss = 0.05, padding = 0.03*size}, nodes={
          {n=G.UIT.B, config={h=0.1,w=0.03}},
          {n=G.UIT.O, config={object = DynaText({string = mod_name or 'ERROR', colours = {G.C.WHITE},float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1*scale_fac, scale = 0.33*size*scale_fac})}},
          {n=G.UIT.B, config={h=0.1,w=0.03}},
        }}
      }}
  else
    smods_cmb(obj, badges)
  end
end

local artpack_suffix = "_refresh.png"
if mf_config["Programmer Art"] then artpack_suffix = ".png" end

SMODS.Atlas({ 
  key = "mf_jokers", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_jokers" .. artpack_suffix, 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_mv", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_mv.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_loyalty", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_loyalty.png", 
  px = 71, 
  py = 95 
})
SMODS.Shader({
  key="dissolvegreen",
  path="dissolvegreen.fs"
})
SMODS.Atlas({ 
  key = "mf_hyperjimbo", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_hyperjimbo.png", 
  px = 95, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_srekoj", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_srekoj.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_rot_cartomancer", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_rot_cartomancer.png", 
  px = 112, 
  py = 112
})
SMODS.Atlas({ 
  key = "mf_colours", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_colours" .. artpack_suffix, 
  px = 71, 
  py = 95 
})
if Entropy then
  SMODS.Atlas({ 
    key = "mf_shapes", 
    atlas_table = "ASSET_ATLAS", 
    path = "mf_shapes.png", 
    px = 71, 
    py = 95 
  })
  SMODS.Atlas({ 
    key = "mf_ascendant_tags", 
    atlas_table = "ASSET_ATLAS", 
    path = "mf_ascendant_tags.png", 
    px = 34, 
    py = 34 
  })
end
if next(SMODS.find_mod("finity")) then
  SMODS.Atlas({ 
    key = "mf_finity_crossmod", 
    atlas_table = "ASSET_ATLAS", 
    path = "mf_finity_crossmod.png", 
    px = 71, 
    py = 95 
  })
end
SMODS.Atlas({ 
  key = "mf_stickers", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_stickers.png", 
  px = 71, 
  py = 95 
})
SMODS.Atlas({ 
  key = "mf_rotarots", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_rotarots.png", 
  px = 107, 
  py = 107
})
SMODS.Atlas({ 
  key = "mf_rotarotpacks", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_rotarotpacks.png", 
  px = 106, 
  py = 106
})
SMODS.Atlas({ 
  key = "mf_oddities", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_oddities.png", 
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
    px = 73, 
    py = 95 
  })
end
SMODS.Atlas({
  key = "tags",
  path = "mf_tags.png",
  px = 34,
  py = 34
})
SMODS.Atlas({
	key = "mf_blinds",
	atlas_table = "ANIMATION_ATLAS",
	path = "mf_blinds.png",
	px = 34,
	py = 34,
	frames = 21,
})
SMODS.Atlas({ 
  key = "mf_watermark", 
  atlas_table = "ASSET_ATLAS", 
  path = "watermark.png", 
  px = 336, 
  py = 32 
})
SMODS.Atlas({ 
  key = "mf_ee_nuhuh", 
  atlas_table = "ASSET_ATLAS", 
  path = "mf_ee_nuhuh.png", 
  px = 1920, 
  py = 1080 
})

-- add a way for these to be disabled
if mf_config["Colour Cards"] then
  init_cols = SMODS.load_file("other/colours.lua")()
  init_cols()

  if next(SMODS.find_mod("Entropy")) then
    init_shapes = SMODS.load_file("other/shapes.lua")()
    init_shapes()
  end
else
  function colour_end_of_round_effects()

  end
end

if mf_config["Other Packs"] then
  -- modded pack
  init_moddedpack = SMODS.load_file("other/moddedpack.lua")()
  init_moddedpack()
end

if not RudeBuster then
  assert(SMODS.load_file("other/planeswalker.lua"))()
end

assert(SMODS.load_file("other/stakes.lua"))()

-- add a way for these to be disabled
if mf_config["45 Degree Rotated Tarot Cards"] then
  init_enhancers = SMODS.load_file("other/enhancers.lua")()
  init_enhancers()
  init_rotarots = SMODS.load_file("other/rotarots.lua")()
  init_rotarots()
end

if mf_config["Superboss"] then
  init_superboss = SMODS.load_file("other/superboss.lua")()
  init_superboss()
  if next(SMODS.find_mod("finity")) then
    init_finity = SMODS.load_file("other/finity.lua")()
    init_finity()
  end
end

if mf_config["Other Tags"] then
  -- clutch tag
  SMODS.Tag({
    key = "clutch",
    atlas = "mf_tags",
    config = {
      extra = 4
    },
    pos = { x = 1, y = 1 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue)
      return { vars = { self.config.extra } }
    end,
    apply = function(self, tag, context)
      if context.type == "final_scoring_step" then
        SMODS.calculate_effect({xmult=4}, tag)
      end
      if context.type == "eval" then
        tag:yep("X", G.C.RED, function()
          return true
        end)
        tag.triggered = true
      end
    end,
  })
  if Entropy and Entropy.AscendedTags then
    SMODS.Tag({
      key = "eclutch",
      atlas = "mf_ascendant_tags",
      config = {
        extra = 4
      },
      pos = { x = 1, y = 1 },
      unlocked = true,
      discovered = true,
	    in_pool = function() return false end or nil,
      loc_vars = function(self, info_queue)
        return { vars = { self.config.extra } }
      end,
      apply = function(self, tag, context)
        if context.type == "final_scoring_step" then
          SMODS.calculate_effect({emult=4}, tag)
        end
        if context.type == "eval" then
          tag:yep("X", G.C.RED, function()
            return true
          end)
          tag.triggered = true
        end
      end,
    })

    Entropy.AscendedTags["tag_mf_clutch"] = "tag_mf_eclutch"
  end
end


-- maybe another day

-- if OddityAPI then
--   init_odds = SMODS.load_file("other/oddities.lua")()
--   init_odds()
-- end

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
      if self.get_current_deck_key() ~= "b_mf_grosmichel" then
        key = self.key
      else
        key = self.key .. "_alt"
      end
      return { key = key }
    end,
    apply = function(self)
      if self.get_current_deck_key() ~= "b_mf_grosmichel" then
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
        if self.get_current_deck_key() ~= "b_mf_philosophical" then
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
        if self.get_current_deck_key() ~= "b_mf_rainbow" then
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
        if self.get_current_deck_key() ~= "b_mf_blasphemy" then
          key = self.key
        else
          key = self.key .. "_alt"
        end
        return { key = key }
      end,
      apply = function(self)
        if self.get_current_deck_key() ~= "b_mf_blasphemy" then
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
          SMODS.add_card{key="j_mf_philosophical", area=G.jokers}
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
if next(SMODS.find_mod("Cryptid")) then
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
      junkmail = "junk mail",
      flintandsteel = "flint and steel",
      firestarter = "flint and steel",
      peakcinema = "flint and steel",
      gemstone = "gemstone joker",
      missingtexture = "missing texture",
      rot_cartomancer = "cartomancer!",
      stonejokerjoker = "stonejoker joker",
      sjj = "stonejoker joker",
      tall = "tall joker",
      teal = "teal joker",
      yucky = "yucky rat", 
      judas = "all i can't do",
      brass = "brass joker",
      complexitycreep = "complexity creep",
      averagebalatromod = "complexity creep",
      topten = "top 10 jokers from one through ten",
      clickbait = "top 10 jokers from one through ten",
      wide = "wide joker",
    }
    for k, v in pairs(aliases) do
      Cryptid.aliases[k] = v
    end
  end
end

--- hooks

SMODS.DrawStep({
	key = "spire_mv",
	order = 25,
	func = function(self)
    if not G.mf_mv_spr then return nil end
    if mf_config["Programmer Art"] then return nil end
    local my_key = self.config.center.key

    if 
      my_key ~= "j_mf_dramaticentrance" and
      my_key ~= "j_mf_dropkick" and
      my_key ~= "j_mf_bladedance" and
      my_key ~= "j_mf_hyperbeam" and
      my_key ~= "j_mf_blasphemy"
    then
      return nil
    end

    G.mf_mv_spr.role.draw_major = self

    local cost = math.floor(
      self.cost +
      (self.ability.extra_value or 0) * 2 +
      0.5
    )

    local base_cost = ({
      j_mf_dramaticentrance = 6,
      j_mf_dropkick = 8,
      j_mf_bladedance = 8,
      j_mf_hyperbeam = 8,
      j_mf_blasphemy = 5,
    })[my_key]

    local shader = "dissolve"
    if cost ~= base_cost then shader = "mf_dissolvegreen" end

    if cost > 99 then
      G.mf_mv_spr:set_sprite_pos({x=0, y=3})
      G.mf_mv_spr:draw_shader(shader, nil, nil, nil, self.children.center)
    elseif cost <= 9 then
      G.mf_mv_spr:set_sprite_pos({x=cost, y=0})
      G.mf_mv_spr:draw_shader(shader, nil, nil, nil, self.children.center)
    else
      G.mf_mv_spr:set_sprite_pos({x=math.floor(cost/10), y=1})
      G.mf_mv_spr:draw_shader(shader, nil, nil, nil, self.children.center)
      G.mf_mv_spr:set_sprite_pos({x=cost%10, y=2})
      G.mf_mv_spr:draw_shader(shader, nil, nil, nil, self.children.center)
    end
	end,
	conditions = { vortex = false, facing = "front" },
})

mf_hyperjimbo_dt = 0

local game_updateref = Game.update
function Game:update(dt)
  game_updateref(self, dt)

  mf_hyperjimbo_dt = mf_hyperjimbo_dt + dt
	if G.P_CENTERS and G.P_CENTERS.j_mf_hyperjimbo and mf_hyperjimbo_dt > 0.07 then
		mf_hyperjimbo_dt = mf_hyperjimbo_dt - 0.07
		local jimballobj = G.P_CENTERS.j_mf_hyperjimbo
		if jimballobj.pos.x == 5 and jimballobj.pos.y == 9 then
			jimballobj.pos.x = 0
			jimballobj.pos.y = 0
		elseif jimballobj.pos.x < 5 then
			jimballobj.pos.x = jimballobj.pos.x + 1
		elseif jimballobj.pos.y < 9 then
			jimballobj.pos.x = 0
			jimballobj.pos.y = jimballobj.pos.y + 1
		end
	end
  if G.ee_nuhuh then
    G.ee_nuhuh[1] = G.ee_nuhuh[1] - dt
  end
end

local game_drawref = Game.draw
function Game:draw()
  game_drawref(self)

  love.graphics.setColor(1,1,1,1)

  if next(SMODS.find_card("j_mf_unregisteredhypercam")) then
    love.graphics.draw(G.ASSET_ATLAS["mf_watermark"].image, 0, 0)
  end

  if G.ee_nuhuh and G.ee_nuhuh[1] > 0 then
    alpha = G.ee_nuhuh[1]
    love.graphics.setColor(1,1,1,alpha)
    local _xscale = love.graphics.getWidth()/1920
    local _yscale = love.graphics.getHeight()/1080
    love.graphics.draw(G.ASSET_ATLAS["mf_ee_nuhuh"].image, 0, 0, 0, _xscale, _yscale)
  end
end

-- pulled from Entropy. thanks ruby!
local e_round = end_round
function end_round()
  e_round()
  local remove_temp = {}
  for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
    for ind, card in pairs(v.cards) do
      if card.ability then
        if card.ability.mf_temporary then
          if card.area ~= G.hand and card.area ~= G.play and card.area ~= G.jokers and card.area ~= G.consumeables then card.states.visible = false end
          card:remove_from_deck()
          card:start_dissolve()
          if card.ability.mf_temporary then remove_temp[#remove_temp+1]=card end
        end
      end
    end
  end
  if #remove_temp > 0 then
    SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
  end
end

local update_round_evalref = Game.update_round_eval
function Game:update_round_eval(dt)
  update_round_evalref(self, dt)
  
  if G.allicantdoundebuff then
    for _, other_card in pairs(G.deck.cards) do
      SMODS.debuff_card(other_card, false, "allicantdo")
    end
    G.allicantdoundebuff = nil
  end

  if G.missingjoker_revert then
    for _, joker in pairs(G.missingjoker_revert) do
      joker:set_ability(G.P_CENTERS["j_mf_missingjoker"])
      joker:juice_up()
    end
    G.missingjoker_revert = {}
  end
  if G.do_colour_end_of_round_stuff then
    colour_end_of_round_effects()

    G.do_colour_end_of_round_stuff = false
  end
end

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

local update_blind_selectref = Game.update_blind_select
function Game:update_blind_select(dt)
  update_blind_selectref(self, dt)
  G.do_colour_end_of_round_stuff = true
  G.allicantdoundebuff = true
end

-- config menu

G.FUNCS.mf_change_artpack = function(args)
  mf_config["Programmer Art"] = (args.to_val == "Programmer")
end

G.FUNCS.duelzone_ver2_link = function(e)
  love.system.openURL( "https://www.youtube.com/watch?v=F-Dm3ayqwkI" )
end

local morefluffTabs = function() return {
	{
		label = localize("mf_config_features"),
		chosen = true,
		tab_definition_function = function()
			mf_nodes = {}
			settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }
      settings.nodes[#settings.nodes + 1] =
        create_option_cycle({label = localize('mf_config_progart'), scale = 0.8, options = {"Refreshed", "Programmer"}, opt_callback = 'mf_change_artpack', current_option = (mf_config["Programmer Art"] and 2 or 1)})
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("mf_config_disablecred"), ref_table = mf_config, ref_value = "Disable Art Credits" })

      local leftside_nodes = {}
      leftside_nodes[#leftside_nodes + 1] =
        create_toggle({ label = localize("mf_config_jokers"), ref_table = mf_config, ref_value = "Jokers" })
      leftside_nodes[#leftside_nodes + 1] =
        create_toggle({ label = localize("mf_config_colour_cards"), ref_table = mf_config, ref_value = "Colour Cards" })
      leftside_nodes[#leftside_nodes + 1] =
        create_toggle({ label = localize("mf_config_rotarot_cards"), ref_table = mf_config, ref_value = "45 Degree Rotated Tarot Cards" })
      leftside_nodes[#leftside_nodes + 1] =
        create_toggle({ label = localize("mf_config_superboss"), ref_table = mf_config, ref_value = "Superboss" })

      local rightside_nodes = {}
      rightside_nodes[#rightside_nodes + 1] =
        create_toggle({ label = localize("mf_config_music"), ref_table = mf_config, ref_value = "Music" })
      rightside_nodes[#rightside_nodes + 1] =
        create_toggle({ label = localize("mf_config_other_tags"), ref_table = mf_config, ref_value = "Other Tags" })
      rightside_nodes[#rightside_nodes + 1] =
        create_toggle({ label = localize("mf_config_other_packs"), ref_table = mf_config, ref_value = "Other Packs" })
      rightside_nodes[#rightside_nodes + 1] =
        create_toggle({ label = localize("mf_config_achievements"), ref_table = mf_config, ref_value = "Achievements" })
      -- settings.nodes[#settings.nodes + 1] =
      --   create_toggle({ label = localize("mf_config_unfinished"), ref_table = mf_config, ref_value = "Unfinished" })
      rightside_nodes[#rightside_nodes + 1] =
        create_toggle({ label = localize("mf_config_huger_joker"), ref_table = mf_config, ref_value = "Huger Joker" })
      rightside_nodes[#rightside_nodes + 1] =
        create_toggle({ label = localize("mf_config_horse_sound"), ref_table = mf_config, ref_value = "Horse Sound" })

      for _, n in pairs(leftside_nodes) do
        n.config.align = "cr"
      end
      for _, n in pairs(rightside_nodes) do
        n.config.align = "cl"
      end

      local t = {n=G.UIT.R, config={align = "cm",padding = 0.2, minw = 7}, nodes={
        {n=G.UIT.C, config={align = "cl", padding = 0.15}, nodes = leftside_nodes },
        {n=G.UIT.C, config={align = "cr", padding = 0.15}, nodes = rightside_nodes }
      }}

      settings.nodes[#settings.nodes + 1] = t

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
	{
		label = localize("mf_credits"),
		chosen = false,
		tab_definition_function = function()
      local text_scale = 0.85
      local mf_cred_nodes = {n=G.UIT.ROOT, config={align = "cm", padding = 0.2, colour = G.C.BLACK, minh = 6, minw = 6}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
              {n=G.UIT.T, config={text = "developer / music / programmer art: notmario", scale = text_scale*0.6, colour = G.C.SECONDARY_SET.Colour, shadow = true}},
            }},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
              {n=G.UIT.T, config={text = "Art Contributors (Refresh)", scale = text_scale*0.7, colour = G.C.UI.WHITE, shadow = true}},
            }},
            {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
              {n=G.UIT.C, config={align = "tl", padding = 0.05, minw = 2.5}, nodes={
                {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                  {n=G.UIT.T, config={text = 'Multi', scale = text_scale*0.5, colour = G.C.UI.WHITE, shadow = true}},
                }},
              }},
            }},
            {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
              {n=G.UIT.C, config={align = "tl", padding = 0.05, minw = 2.5}, nodes={
                {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                  {n=G.UIT.T, config={text = 'LFMoth', scale = text_scale*0.5, colour = G.C.UI.WHITE, shadow = true}},
                }},
              }},
            }},
            {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
              {n=G.UIT.C, config={align = "tl", padding = 0.05, minw = 2.5}, nodes={
                {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                  {n=G.UIT.T, config={text = 'footlongdingledong', scale = text_scale*0.5, colour = G.C.UI.WHITE, shadow = true}},
                }},
              }},
            }},
            {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
              {n=G.UIT.C, config={align = "tl", padding = 0.05, minw = 2.5}, nodes={
                {n=G.UIT.R, config={align = "cl", padding = 0}, nodes={
                  {n=G.UIT.T, config={text = 'Ice', scale = text_scale*0.5, colour = G.C.UI.WHITE, shadow = true}},
                }},
              }},
            }},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
              {n=G.UIT.T, config={text = "Superboss Music: DUEL ZONE (VER. 2) - dante, Geshtro", scale = text_scale*0.6, colour = G.C.UI.WHITE, shadow = true}},
              G.F_EXTERNAL_LINKS and {n=G.UIT.C, config={padding = 0.1}, nodes={
                UIBox_button({label = {'Youtube'}, button = 'duelzone_ver2_link'})
              }} or nil,
            }},
          }},
        }}
			return {
				n = G.UIT.ROOT,
				config = {
					emboss = 0.05,
					minh = 6,
					r = 0.1,
					minw = 10,
					align = "cm",
					-- padding = 0.2,
					colour = G.C.BLACK,
				},
				nodes = { mf_cred_nodes },
			}
		end,
	},
  -- {
  --   label = localize("mf_config_maj"),
  --   chosen = true,
	-- 	tab_definition_function = function()
	-- 		local mynodes = {}
	-- 		return {
	-- 			n = G.UIT.ROOT,
	-- 			config = {
	-- 				emboss = 0.05,
	-- 				minh = 6,
	-- 				r = 0.1,
	-- 				minw = 10,
	-- 				align = "cm",
	-- 				padding = 0.2,
	-- 				colour = G.C.BLACK,
	-- 			},
	-- 			nodes = mynodes,
	-- 		}
	-- 	end,
  -- },
} end
SMODS.current_mod.extra_tabs = morefluffTabs

local mainmenuref2 = Game.main_menu
Game.main_menu = function(change_context)
  G.mf_mv_spr = Sprite(
    0, 0, 71, 95, G.ASSET_ATLAS["mf_mv"], {x = 0, y = 0}
  ) -- im dumb and stupide
  
  G.mf_loyalty_spr = Sprite(
    0, 0, 71, 95, G.ASSET_ATLAS["mf_loyalty"], {x = 0, y = 0}
  ) -- im dumb and stupide

  if next(SMODS.find_mod("finity")) then
    local bossblinds = {
      ["bl_mf_violet_vessel_dx"] = {"j_finity_violetvessel","Violet Vessel"},
      ["bl_mf_cerulean_bell_dx"] = {"j_finity_ceruleanbell","Cerulean Bell"},
      ["bl_mf_needle_dx"] = {"j_mf_theneedle","The Needle"},
    }

    for k, v in pairs(bossblinds) do
      FinisherBossBlindStringMap[k] = v
    end
  end
  local ret = mainmenuref2(change_context)
  return ret
end

--debugplus stuff
local success, dpAPI = pcall(require, "debugplus-api")

local logger = { -- Placeholder logger, for when DebugPlus isn't available
  log = print,
  debug = print,
  info = print,
  warn = print,
  error = print
}

if success and dpAPI.isVersionCompatible(1) then
  local debugplus = dpAPI.registerID("morefluff")
  logger = debugplus.logger -- Provides the logger object

  debugplus.addCommand({ -- register a command
    name = "add_colour_rounds",
    shortDesc = "Add rounds to Colour Cards",
    desc = "Adds <arg1> rounds to all held Colour Cards when run. Only works in game. Defaults to 1 round.",
    exec = function (args, rawArgs, dp)
      local rounds = nil
      if #args == 0 then
        rounds = 1
      else
        rounds = args[1]
      end
      if G.consumeables and G.consumeables.cards then
        for i = 1, rounds do
          colour_end_of_round_effects()
        end

        return "Added to event queue!"
      else
        return "add_colour_rounds only works in game!", "ERROR"
      end
    end
  })
end

local title_screen_list = {
  "j_mf_triangle",
  "j_mf_philosophical",
  "j_mf_basepaul_card",
  "j_mf_blunder",
  "j_mf_cba",
  "j_mf_blahaj",
  "j_mf_farmmerge",
  "j_mf_hugejoker",
  "j_mf_jankman",
  "j_mf_lessfluff",
  "j_mf_mspaint",
  "j_mf_talljoker",
  "j_mf_unregisteredhypercam",
  "c_mf_rot_hermit",
  "c_mf_rot_wheel",
  "c_mf_pink", -- what if the title screen was pink and yellow
  "c_mf_yellow",
}

-- ugh okay so Whatever i guess this can be like this
-- ts pmo
local g_main_menu = Game.main_menu
function Game:main_menu(change_context)
  local ret = g_main_menu(self, change_context)
  math.randomseed(os.time()) -- Hm... does this break anything?
  local card_key = title_screen_list[math.random(#title_screen_list)]
  local newcard = Card(
    G.title_top.T.x,
    G.title_top.T.y,
    G.CARD_W,
    G.CARD_H,
    G.P_CARDS.empty,
    G.P_CENTERS[card_key],
    { bypass_discovery_center = true }
  )
  -- recenter the title
  G.title_top.T.w = G.title_top.T.w + 1.7675 -- uh if i do this again then it gets really big so uh. Manually it is then
  G.title_top.T.x = G.title_top.T.x - 0.8
  G.title_top:emplace(newcard)
  -- make the card look the same way as the title screen Ace of Spades
  newcard.T.w = newcard.T.w * 1.1 * 1.2
  newcard.T.h = newcard.T.h * 1.1 * 1.2
  newcard.no_ui = true
  newcard:set_sprites(newcard.config.center)
  newcard.states.visible = false

  G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0,
    blockable = false,
    blocking = false,
    func = function()
      if change_context == "splash" then
        newcard.states.visible = true
        newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
      else
        newcard.states.visible = true
        newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
      end
      return true
    end,
  }))

  return ret
end

if Balatest then
  assert(SMODS.load_file("other/tests/jokers.lua"))()
  assert(SMODS.load_file("other/tests/decks.lua"))()
  assert(SMODS.load_file("other/tests/colours.lua"))()
  assert(SMODS.load_file("other/tests/rotarots.lua"))()
  assert(SMODS.load_file("other/tests/superboss.lua"))()
end

-- Adding file loading to the end so it can be moved by Fluff
if Blockbuster and Blockbuster.ValueManipulation then
  -- Loads in the standards for Blockbuster Value Manipulation compatibility
  assert(SMODS.load_file("other/compat_standard/morefluff.lua"))()
  assert(SMODS.load_file("other/compat_standard/morefluff_scaling.lua"))()
end
