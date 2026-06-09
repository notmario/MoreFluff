FLUFF.get_hidden_rarity = function()
	local decided_rarity = "Rare";
	local rarities_possible = { "mf_oldfluff", "mf_letter", "mf_purple" }
	local rarity_odds_mult = { ["mf_oldfluff"] = 10, ["mf_letter"] = 10, ["mf_purple"] = 40000, }
	local real_rarities = {};

	for _, v in ipairs(rarities_possible) do
		for _, card in ipairs(G.P_JOKER_RARITY_POOLS[v]) do
			if (SMODS.showman(card.key) or not G.GAME.used_jokers[card.key]) and (not card.in_pool or card.in_pool(card, nil, nil)) then
				for _ = 1, rarity_odds_mult[v] do
					real_rarities[#real_rarities+1] = v;
				end
				break;
			end
		end
	end
	
	decided_rarity = pseudorandom_element(real_rarities, "hidden_rarity");

	return decided_rarity
end

SMODS.Rarity({
	key = "oldfluff",
	badge_colour = HEX("000000"),
})

SMODS.Rarity({
	key = "letter",
	badge_colour = HEX("a9683b"),
})

SMODS.Rarity({
	key = "purple",
	badge_colour = HEX("8d00ab"),
})

SMODS.Rarity({
	key = "token",
	badge_colour = HEX("474747"),
})

SMODS.Rarity({
	key = "superlegendary",
	badge_colour = HEX("2852FF"),
})

SMODS.Rarity({
	key = "rot_legendary",
	badge_colour = HEX("2852FF"),
})
