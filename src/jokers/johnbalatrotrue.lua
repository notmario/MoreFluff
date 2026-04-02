SMODS.Joker({
	key = "johnbalatrotrue",
	name = "John Balatro",
	atlas = "mf_jokers",
	config = {
		extra = {},
	},
	pos = { x = 3, y = 9 },
	soul_pos = { x = 4, y = 9 },
	rarity = "mf_superlegendary",
	cost = 50,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	no_collection = true,

	planeswalker = false,
	planeswalker_costs = {},
	pronouns = "she_her",
	loc_txt = {},
	attributes = { },
	loc_vars = function(self, info_queue, center) end,
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			if FLUFF.should_talisman_key("emult") then
				return {
					emult = card.ability.extra.powmult,
				}
			else
				return {
					pre_func = function()
						mult = mod_mult(mult ^ 2)
					end,
					message = "^2 Mult",
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
})

if Jen then
	SMODS.Rarity({
		key = "john",
		loc_txt = {
			name = "John",
		},
		badge_colour = HEX("2852FF"),
	})
	SMODS.Joker({
		key = "johnbalatro_super_ultra_mega_upgraded_deluxe",
		atlas = "mf_jokers",
		config = {
			extra = {
				operator = 1,
				value = 2,
				op_mult = 2,
				op_mult_mult = 3,
				op_mult_mult_mult = 4,
				loops = 1,
			},
		},
		pos = { x = 3, y = 9 },
		soul_pos = { x = 4, y = 9 },
		rarity = "mf_john",
		cost = 999e999,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		eternal_compat = true,
		perishable_compat = true,
		demicoloncompat = true,
		no_collection = true,

		planeswalker = false,
		planeswalker_costs = {},
		pronouns = "she_her",
		loc_txt = {},
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.operator,
					card.ability.extra.value,
					card.ability.extra.op_mult,
					"{",
					"}",
					card.ability.extra.op_mult_mult,
				},
			}
		end,
		calculate = function(self, card, context)
			if context.cardarea == G.jokers and context.joker_main then
				return {
					hypermult = { card.ability.extra.operator, card.ability.extra.value },
				}
			end
			if context.end_of_round and not context.individual and not context.blueprint and not context.repetition then
				for i = 1, z do
					card.ability.extra.op_mult = card.ability.extra.op_mult * card.ability.extra.op_mult_mult
					card.ability.extra.operator = card.ability.extra.operator * card.ability.extra.op_mult
				end
				return {
					message = localize("k_upgrade_ex"),
				}
			end
		end,
		remove_from_deck = function(self, card, from_debuff)
			G.crashthegame.lololol()
		end,
	})
end
