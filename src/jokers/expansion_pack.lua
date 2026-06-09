SMODS.Joker({
	key = "expansion_pack",
	name = "Expansion Pack",
	atlas = "mf_jokers",
	config = {
		extra = 1,
	},
	pos = { x = 5, y = 0 },
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "joker", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if
			(context.setting_blind and not card.getting_sliced)
			and not (context.blueprint_card or card).getting_sliced
			and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
		then
			local jokers_to_create = math.floor(
				math.min(card.ability.extra, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			)
			G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = 1, jokers_to_create do
						SMODS.add_card {
							set = "Joker",
							attributes = { "Joker" },
							filter = function ( pool )
								local new_pool = {}
								for k, v in pairs(pool) do
									if G.P_CENTERS[v.key].original_mod then
										table.insert(new_pool, v)
									end
								end
								return new_pool
							end,
						}
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
			return { message = localize("k_plus_joker"), colour = G.C.BLUE }
		end
	end,
})
