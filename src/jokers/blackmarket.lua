SMODS.Joker({
	key = "blackmarket",
	name = "Black Market",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 2, y = 1 },
	cost = 4,
	config = { extra = { cost = 10 } },
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.cost },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and context.blind.boss and not self.getting_sliced then
			if
				#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
				and G.GAME.dollars >= 10 + G.GAME.bankrupt_at
			then
				ease_dollars(-10)
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						local card = create_card(nil, G.consumeables, nil, nil, nil, nil, "c_ankh", "sup")
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
						return true
					end,
				}))
				return {
					message = localize("k_plus_ankh"),
					colour = G.C.SECONDARY_SET.Spectral,
				}
			end
		end
	end,
})
