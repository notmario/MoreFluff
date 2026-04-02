SMODS.Joker({
	key = "top10",
	name = "Top 10 Jokers From 1 To 10",
	atlas = "mf_jokers",
	config = {
		cash_per = 5,
	},
	pos = { x = 1, y = 6 },
	soul_pos = { x = 7, y = 4 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "economy", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.cash_per },
		}
	end,
	calc_dollar_bonus = function(self, card)
		local count = 0
		local cashmoney = G.GAME.dollars .. ""
		for i = 0, 9 do
			if string.match(cashmoney, i .. "") then
				count = count + 1
			end
		end
		if count > 0 then
			return card.ability.cash_per * count -- note to whoever is reading this i am a dumbass
		end
	end,
})
