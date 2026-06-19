SMODS.Joker {
	key = "ghostly_reflection",
	name = "Ghostly Reflection",
	atlas = "mf_jokers",
	config = {
		extra = {
			cards = 3,
		},
	},
	pos = { x = 5, y = 14 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "enhancements" },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
			for i = 1, card.ability.extra.cards do
				FLUFF.draw_to_exile(true, i / card.ability.extra.cards)
			end
		end
        if context.discard and context.other_card.config.center ~= G.P_CENTERS.c_base then
            for i, v in ipairs(G.mf_exile.cards) do
                local percent = 1.15 - (i - 0.999) / (#G.mf_exile.cards - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        play_sound("card1", percent)
                        G.mf_exile.cards[i]:juice_up(0.3, 0.3)
                        G.mf_exile.cards[i]:flip()
                        return true
                    end,
                }))
            end
            for i, v in ipairs(G.mf_exile.cards) do
                local percent = 0.85 + (i - 0.999) / (#G.mf_exile.cards - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        play_sound("tarot2", percent)
						if G.mf_exile.cards[i].playing_card then
							G.mf_exile.cards[i]:set_ability(context.other_card.config.center)
							G.mf_exile.cards[i].T.w = G.mf_exile.cards[i].T.w * FLUFF.exile_scale
							G.mf_exile.cards[i].T.h = G.mf_exile.cards[i].T.h * FLUFF.exile_scale
						end
                        G.mf_exile.cards[i]:flip()
                        return true
                    end,
                }))
            end
        end
	end,
}