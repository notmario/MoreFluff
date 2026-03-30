SMODS.Joker({
	key = "friendinsideme",
	name = "Friend Inside Me",
	atlas = "mf_jokers",
	config = {
		active = true,
	},
	pos = { x = 0, y = 8 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	pools = { ["Meme"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.active and "active" or "inactive",
			},
		}
	end,
	calculate = function(self, card, context)
		if context.selling_card and card.ability.active then
			if
				context.card.ability.set == "Joker"
				and (context.card.config.center.rarity == 1 or context.card.config.center.rarity == 2)
			then
				card.ability.active = false

				rarity = "Uncommon"
				if context.card.config.center.rarity == 2 then
					rarity = "Rare"
				end
				SMODS.add_card({
					set = "Joker",
					rarity = rarity,

					edition = context.card.edition,
				})

				return {
					message = localize("k_friend_ex"),
				}
			end
		end
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and G.GAME.blind.boss
		then
			card.ability.active = true
			return {
				message = localize("k_active_ex"),
			}
		end
	end,
})
