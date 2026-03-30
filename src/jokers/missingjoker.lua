SMODS.Joker({
	key = "missingjoker",
	name = "Missing Joker",
	atlas = "mf_jokers",
	config = {},
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 7,
	display_size = { w = 71, h = 95 },
	pixel_size = { w = 71, h = 95 },
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false, -- just in case
	pools = { ["Meme"] = true },
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if not G.mf_missingjoker_revert then
				G.mf_missingjoker_revert = {}
			end
			local joker_pool = {}
			local valid_pools = { "Joker" }
			for _, id in ipairs(valid_pools) do
				for k, v in pairs(G.P_CENTER_POOLS[id]) do
					if
						v.unlocked == true
						and (not next(SMODS.find_mod("Cryptid")) or not Cryptid.no(v, "doe", k))
						and v.perishable_compat
						and v.eternal_compat
						and not (
							G.GAME.banned_keys[v.key] or (G.GAME.cry_banished_keys and G.GAME.cry_banished_keys[v.key])
						)
					then
						joker_pool[#joker_pool + 1] = v.key
					end
				end
			end
			if #joker_pool <= 0 then
				joker_pool[#joker_pool + 1] = "v_blank"
			end
			local elem = pseudorandom_element(joker_pool, pseudoseed("missingjoker"))
			card:set_ability(G.P_CENTERS[elem])
			G.mf_missingjoker_revert[#G.mf_missingjoker_revert + 1] = card
			return {
				message = localize("k_transformed_ex"),
				colour = G.C.DARK_EDITION,
			}
		end
	end,
})
