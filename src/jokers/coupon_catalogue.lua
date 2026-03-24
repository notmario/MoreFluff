SMODS.Joker {
	key = "coupon_catalogue",
	name = "Coupon Catalogue",
	config = {
		extra = { mult = 15 },
	},
	pos = { x = 0, y = 3 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_shader_on_modbadge = true,
	no_collection = true,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		local redeemed = 0
		for k, v in pairs(G.GAME.used_vouchers) do
			if v == true then
				redeemed = redeemed + 1
			end
		end
		return {
			vars = { center.ability.extra.mult, redeemed * center.ability.extra.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
			local redeemed = 0
			for k, v in pairs(G.GAME.used_vouchers) do
				if v == true then
					redeemed = redeemed + 1
				end
			end
			if redeemed > 0 and card.ability.extra.mult then
				return {
					mult = card.ability.extra.mult * to_big(redeemed),
				}
			end
		end
	end,
}
