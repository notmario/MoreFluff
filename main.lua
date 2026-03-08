FLUFF = SMODS.current_mod

assert(SMODS.load_file("atlases.lua"))()

-- we still use manual string loading for collection order.
-- theres probably a better way but Whatever!
local jokers = {
    "triangle",
}

for _, path in ipairs(jokers) do
    assert(SMODS.load_file("jokers/"..path..".lua"))()
end