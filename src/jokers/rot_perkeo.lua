SMODS.Joker({
	key = "rot_perkeo",
	name = "Perkeo!",
	atlas = "mf_jokers",
	config = {
        extra = {
        }
    },
	pos = { x = 4, y = 10 },
	soul_pos = { x = 4, y = 11 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
	    return {
	        vars = { }
	    }
	end,
	calculate = function(self, card, context) end,
})
