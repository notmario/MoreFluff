SMODS.Joker({
	key = "sealthedeal",
	name = "Seal the Deal",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 6, y = 0 },
	cost = 6,
	config = { extra = {} },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "seals", "hands", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands } }
	end,
	calculate = function(self, card, context)
		if
			context.after
			and G.GAME.chips + SMODS.calculate_round_score() >= G.GAME.blind.chips
			and context.cardarea == G.jokers
		then
			local unsealed = {}
			for k, v in ipairs(context.full_hand) do
				if not v.seal then
					unsealed[#unsealed + 1] = v
				end
			end
			if #unsealed > 0 then
				local conv_card = pseudorandom_element(unsealed, pseudoseed("seal_the_deal_card"))
				local seal = SMODS.poll_seal({ guaranteed = true })

				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card:juice_up(0.3, 0.5)
						return true
					end,
				}))

				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						conv_card:set_seal(seal, nil, true)
						return true
					end,
				}))

				return {
					message = localize("k_sealed_ex"),
					card = card,
				}
			end
		end
	end,
})
