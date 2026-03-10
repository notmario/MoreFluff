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

    "triangle",
}

for _, path in ipairs(FLUFF.joker_pool) do
    assert(SMODS.load_file("src/jokers/"..path..".lua"))()
end