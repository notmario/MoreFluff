SMODS.Joker({
	key = "monochrome",
	name = "Monochrome Joker",
	atlas = "mf_oldfluff",
	config = {
		extra = {
			mult_per = 2,
			mult = 2,
		},
	},
	pos = { x = 8, y = 1 },
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult_per, center.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if
			context.setting_blind
			and not context.blueprint
			and not self.getting_sliced
			and not (context.blueprint_card or self).getting_sliced
		then
			local okay = true
			for i = 1, #G.consumeables.cards do
				if G.consumeables.cards[i].ability.set == "Colour" then
					okay = false
					break
				end
			end
			if okay then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "mult_per",
					message_key = "a_mult",
					colour = G.C.TEXT_DARK,
				})
			elseif card.ability.extra.mult > card.ability.extra.mult_per then
				card.ability.extra.mult = card.ability.extra.mult_per
				return { message = localize("k_reset"), colour = G.C.PURPLE }
			end
		end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})
