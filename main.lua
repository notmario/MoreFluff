FLUFF = SMODS.current_mod
FLUFF.is_rewrite = true

assert(SMODS.load_file("src/tetr_stuff.lua"))()
assert(SMODS.load_file("src/atlases.lua"))()
assert(SMODS.load_file("src/sounds.lua"))()
assert(SMODS.load_file("src/planeswalker.lua"))()
assert(SMODS.load_file("src/rarities.lua"))()
assert(SMODS.load_file("src/attributes.lua"))()

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/colours.lua"))()
assert(SMODS.load_file("src/modifiers.lua"))()
assert(SMODS.load_file("src/rotarots.lua"))()
assert(SMODS.load_file("src/decks.lua"))()
assert(SMODS.load_file("src/superboss.lua"))()

assert(SMODS.load_file("src/uibadge.lua"))()
assert(SMODS.load_file("src/modpageui.lua"))()
assert(SMODS.load_file("src/misc.lua"))()

assert(SMODS.load_file("src/mod_calculate.lua"))()
