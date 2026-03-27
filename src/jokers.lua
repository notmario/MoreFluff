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

	"bonussheet",
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

	-- powerful
	"triangle",
}

for _, path in ipairs(FLUFF.joker_pool) do
	assert(SMODS.load_file("src/jokers/" .. path .. ".lua"))()
end

SMODS.Rarity({
	key = "oldfluff",
	loc_txt = {
		name = "Scrapped",
	},
	badge_colour = HEX("000000"),
})

SMODS.ObjectType({
	key = "letterjoker",
})

SMODS.Rarity({
	key = "token",
	badge_colour = HEX("474747"),
	loc_txt = {
		name = "Token",
	},
})

FLUFF.hidden_joker_pool = {
	-- tokens
	"oopsallfives",
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
	"badlegaldefence",
	"flintandsteel",
	"sudoku",

	"talljoker",
	"tonersoup",
	"hallofmirrors",
	"virtual",
	"impostor",
	"coupon_catalogue",

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
