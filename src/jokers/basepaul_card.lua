SMODS.Joker({
	key = "basepaul_card",
	name = "Basepaul Card",
	atlas = "mf_jokers",
	config = {
		extra = {
			x_mult = 1.25,
		},
	},
	pos = { x = 1, y = 0 },
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_mult, center.ability.extra.x_mult * 10 },
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
			if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "paul") then
				return {
					xmult = card.ability.extra.x_mult * 10,
				}
			else
				return {
					xmult = card.ability.extra.x_mult,
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" },
					},
				},
			},
			reminder_text = {
				{
					ref_table = "card.joker_display_values",
					ref_value = "inactive_text",
					colour = G.C.GRAY,
				},
				{
					ref_table = "card.joker_display_values",
					ref_value = "active_text",
					colour = G.C.RED,
				},
			},
			calc_function = function(card)
				if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "paul") then
					card.joker_display_values.x_mult = card.ability.extra.x_mult * 10
					card.joker_display_values.inactive_text = ""
					card.joker_display_values.active_text = localize("k_display_for_paul_ex")
				else
					card.joker_display_values.x_mult = card.ability.extra.x_mult
					card.joker_display_values.inactive_text = localize("k_display_for_paul")
					card.joker_display_values.active_text = ""
				end
			end,
		}
	end,
})
