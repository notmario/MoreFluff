SMODS.Joker({
	key = "tonersoup",
	name = "I Sip Toner Soup",
	config = {},
	pos = { x = 6, y = 2 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_shader_on_modbadge = true,
	no_collection = true,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	demicoloncompat = true,
	pools = { ["Food"] = true },
	calculate = function(self, card, context)
		if context.forcetrigger or (context.cardarea == G.jokers and context.before) then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						SMODS.add_card({ set = "Tarot" })
						G.GAME.consumeable_buffer = 0
						return true
					end,
				}))
			end
		end
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
			SMODS.destroy_cards({ card })
			return {
				message = localize("k_drank_ex"),
				colour = G.C.FILTER,
			}
		end
	end,
})
