SMODS.Joker({
	key = "sudoku",
	name = "Sudoku",
	config = {
		my_x_mult = 5, -- if i just have x_mult smods automatically picks it up. thanks smods!
		extra = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
		},
	},
	pos = { x = 4, y = 2 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_shader_on_modbadge = true,
	no_collection = true,
	cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", "reset", "rank", "ace", "two", "three", "four", "five", "six", "seven", "eight", "nine", "hands", "boss_blind", },
	loc_vars = function(self, info_queue, center)
		local funny = function(val)
			return (val > 0) and G.C.FILTER or G.C.UI.TEXT_INACTIVE
		end
		return {
			vars = {
				center.ability.my_x_mult,
				colours = {
					funny(center.ability.extra[1]),
					funny(center.ability.extra[2]),
					funny(center.ability.extra[3]),
					funny(center.ability.extra[4]),
					funny(center.ability.extra[5]),
					funny(center.ability.extra[6]),
					funny(center.ability.extra[7]),
					funny(center.ability.extra[8]),
					funny(center.ability.extra[9]),
				},
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and context.cardarea == G.jokers
			and not context.blueprint
			and not context.repetition
			and G.GAME.blind.boss
		then
			card.ability.extra = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			return {
				message = localize("k_reset"),
				colour = G.C.RED,
				card = card,
			}
		end
		if context.individual and context.cardarea == G.play and not context.blueprint and not context.repetition then
			local rank = context.other_card:get_id()
			if rank == 14 then
				rank = 1
			end

			if rank >= 1 and rank <= 9 then
				if card.ability.extra[rank] == 0 then
					card.ability.extra[rank] = 1
					return {
						message = localize("k_noted_ex"),
					}
				end
			end
		end
		if context.cardarea == G.jokers and context.joker_main then
			local okay = true
			for k, v in ipairs(card.ability.extra) do
				if v == 0 then
					okay = false
					break
				end
			end
			if okay then
				return {
					xmult = card.ability.my_x_mult,
				}
			end
		end
	end,
})
