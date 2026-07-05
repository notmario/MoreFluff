-- we still use manual string loading for collection order.
-- theres probably a better way but Whatever!
FLUFF.joker_pool = {
	-- commons
	"basepaul_card",
	"blahaj",
	"clownfish",
	"expansion_pack",
	"hollow",

	"jackofalltrades",
	"jester",
	"lollipop",
	"luckycharm",
	"mspaint",

	"philosophical",
	"simplified",
	"spiral",
	"treasuremap",
	"unregisteredhypercam",

	-- uncommon page 1
	"dropkick",
	"bladedance",
	"hyperbeam",
	"blasphemy",
	"dramaticentrance",

	"badlegaldefence",
	"blunder",
	"brilliant",
	"broomcloset",
	"rot_cartomancer",

	"clipart",
	"css",
	"cueball",
	"dinner",
	"forge",

	-- uncommon page 2
	"gemstonejoker",
	"globe",
	"goldencarrot",
	"farmmerge",
	"friendinsideme",

	"junkmail",
	"onesliptoolate",
	"unpleasantcard",
	"loadeddisk",
	"missingjoker",
	
	"paintcan",
	"passando",
	"sapling",
	"snake",
	"slotmachine",

	-- uncommon page 3
	"stylemeter",
	"stonejokerjoker",
	"talljoker",
	"teacup",
	"tealjoker",

	"thewayhome",
	"recycling",
	"yuckyrat",
	-- rares
	"allicantdo",
	"bloodpact",

	"bookmove",
	"brass",
	"bowlingball",
	"cba",
	"doubledscale",

	-- rares page 2
	"grep",
	"hugejoker",
	"hyperjimbo",
	"jankman",
	"pixeljoker",

	"rainbowjoker",
	"the_solo",
	"top10",
	"widejoker",
	"lessfluff",

	-- walkers
	"mindsculptor",
	"johnbalatro",
	"trianglewalker",

	-- legendary
	"triangle",
	"marigold",

	-- new update jokers
	"lonewolf",
	"bouncer",
	"jokesforminecrafters",
	"nemesis",
	"repack",

	"stifle",
	"stasis_chamber",
	"applefriends",
	"bonussheet",
	"crypticmod",

	"diabolical",
	"emeritus_decay",
	"emeritus_lore",
	"emeritus_rebirth",
	"emeritus_variety",

	"gemalert",
	"gentlemelon",
	"ghostly_reflection",
	"hold_music",
	"icecube",

	"junkyard",
	"jokerreacts",
	"knuckleblaster",
	"ransom_note",
	"refrigerator",

	"intervention_pact",
	"pact_of_negation",
	"pact_of_the_titan",
	"slaughter_pact",
	"summoners_pact",

	"retrigger_joker",
	"saturnburger",
	"shopping_spree",
	"violent_outburst",
	"aheartofcold",

	"digital_exclusive",
	"apex_devastator",
	"crimsonglassdecomposition",
	"emeritus_eventuality",
	"mathemagics",

	"overlord",
	"space_elevator",
	"suspension",
	"three_steps_ahead",
	"whiplash",

	-- rot legendary
	"rot_canio",
	"rot_triboulet",

	"rot_yorick",
	"rot_chicot",
	"rot_perkeo",
	"rot_triangle",
	"rot_marigold",
}

if SMODS.Mods["aikoyorisshenanigans"] and SMODS.Mods["aikoyorisshenanigans"].can_load then
	FLUFF.joker_pool[#FLUFF.joker_pool + 1] = "crossmod/name_sticker_goblin"
end

for _, path in ipairs(FLUFF.joker_pool) do
	assert(SMODS.load_file("src/jokers/" .. path .. ".lua"))()
end

for i, jkr in ipairs(FLUFF.joker_pool) do
	FLUFF.joker_pool[i] = jkr:gsub("crossmod/", "")
end

FLUFF.hidden_joker_pool = {
	"johnbalatrotrue",
	"deadheatpulse",

	"halt",
	"theshatteringcircle",
	"eventhorizon",

	-- tokens
	"oopsallfives",
	"fish",
	"forgeslop",

	-- scrapped
	"brainrot",
	"triangular",
	"boxofhands",
	"rosetinted",
	"glitterbomb",

	"moneyprinter",
	"sealthedeal",
	"particleaccelerator",
	"balatromods",
	"fived",

	"whiteboard",
	"miner",
	"blackmarket",
	"thejester",
	"aceupthesleeve",

	"burnerphone",
	"bigshot",
	"mrloans",
	"monochrome",
	"wilddrawfour",

	"fleshprison",
	"mashupalbum",
	"flintandsteel",
	"sudoku",

	"tonersoup",
	"hallofmirrors",
	"virtual",
	"impostor",
	"coupon_catalogue",

	-- scrapped during rewrite
	"emeritus_growth",
	"emeritus_eternity",
	"stormscale",
	"steamflogger_boss",
	"marketable_plushie",

	"old_rot_triboulet",
	"old_rot_chicot",
	-- "rot_perkeo",
	"old_rot_triangle",
	"old_rot_marigold",

	-- ourple
	"aura_farm",
	"crad_shuffler",
	"purple_economy_joker",

	-- lettergem mentioned
	"lettergem_a",
	"lettergem_b",
	"lettergem_c",
	"lettergem_d",
	"lettergem_e",
	"lettergem_f",
	"lettergem_g",
	"lettergem_h",
	"lettergem_i",
	"lettergem_j",
	"lettergem_k",
	"lettergem_l",
	"lettergem_m",
	"lettergem_n",
	"lettergem_o",
	"lettergem_p",
	"lettergem_q",
	"lettergem_r",
	"lettergem_s",
	"lettergem_t",
	"lettergem_u",
	"lettergem_v",
	"lettergem_w",
	"lettergem_x",
	"lettergem_y",
	"lettergem_z",
}

for _, path in ipairs(FLUFF.hidden_joker_pool) do
	assert(SMODS.load_file("src/jokers/" .. path .. ".lua"))()
end
