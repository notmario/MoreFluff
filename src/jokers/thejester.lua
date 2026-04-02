SMODS.Joker({
	key = "thejester",
	name = "The Jester",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 3, y = 1 },
	cost = 20,
	config = { extra = { xmult_per = 2.5 } },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", "hands", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.xmult_per },
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
			local triggers = {}
			for j = 1, #context.scoring_hand do
				local my_id = context.scoring_hand[j]:get_id()
				local count = 0
				for i = 1, #context.scoring_hand do
					if context.scoring_hand[i]:get_id() == my_id then
						count = count + 1
					end
					if count == 2 and i == j then
						triggers[#triggers + 1] = { xmult = card.ability.extra.xmult_per }
					end
				end
			end

			return SMODS.merge_effects(triggers)
		end
	end,
})
