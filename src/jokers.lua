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

    "dropkick",
    "bladedance",
    "hyperbeam",
    "blasphemy",
    "dramaticentrance",

    "bonussheet",

    "triangle",
}

for _, path in ipairs(FLUFF.joker_pool) do
    assert(SMODS.load_file("src/jokers/"..path..".lua"))()
end

SMODS.Rarity {
    key = "oldfluff",
    loc_txt = {
        name = "Scrapped"
    },
    badge_colour = HEX "000000"
}

SMODS.ObjectType {
    key = "letterjoker"
}

FLUFF.hidden_joker_pool = {
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
}

for _, path in ipairs(FLUFF.hidden_joker_pool) do
    assert(SMODS.load_file("src/jokers/"..path..".lua"))()
end