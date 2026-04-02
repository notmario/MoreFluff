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
			-- ah shit.
			function temp_ban_joker(key)
				if type(G.GAME.banned_keys[key]) ~= "number" and G.GAME.banned_keys[key] ~= nil then
					return nil
				end
				if G.GAME.banned_keys[key] == true then
					G.GAME.banned_keys[key] = 214389
				end
				if not G.GAME.banned_keys[key] then
					G.GAME.banned_keys[key] = 214389
				elseif G.GAME.banned_keys[key] % 214389 == 0 then
					G.GAME.banned_keys[key] = G.GAME.banned_keys[key] + 214389
				end
			end
			for i = 1, #FLUFF.vanilla_jokers do
				temp_ban_joker(FLUFF.vanilla_jokers[i])
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = 1, jokers_to_create do
						local n_card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "exp")
						n_card:add_to_deck()
						G.jokers:emplace(n_card)
						n_card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					function temp_unban_joker(key)
						if type(G.GAME.banned_keys[key]) ~= "number" and G.GAME.banned_keys[key] ~= nil then
							return nil
						end
						if G.GAME.banned_keys[key] == 214389 then
							G.GAME.banned_keys[key] = nil
						elseif G.GAME.banned_keys[key] % 214389 == 0 then
							G.GAME.banned_keys[key] = G.GAME.banned_keys[key] - 214389
						end
					end
					for i = 1, #FLUFF.vanilla_jokers do
						temp_unban_joker(FLUFF.vanilla_jokers[i])
					end
					return true
				end,
			}))
			return { message = localize("k_plus_joker"), colour = G.C.BLUE }
		end
	end,
})
