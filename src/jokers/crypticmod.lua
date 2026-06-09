SMODS.Joker {
	key = "crypticmod",
	name = "Cryptic Mod",
	atlas = "mf_jokers",
	config = {
		extra = {
		},
	},
	pos = { x = 0, y = 12 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "joker", "editions", },
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_mf_cryptic
		return {
			vars = { },
		}
	end,
    calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
            local temp_pool = {}
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == "Joker" and not v.edition then
                    table.insert(temp_pool, v)
                end
            end
            if #temp_pool > 0 then
                return {
                    pre_func = function()
                        local eligible_card = pseudorandom_element(temp_pool, pseudoseed("cryptic_mod"))
                        local edition = { mf_cryptic = true }
                        eligible_card:set_edition(edition, true)
                        check_for_unlock({ type = "have_edition" })
                        card:juice_up(0.3, 0.5)
                    end,
                    message = "???"
                }
            end
        end
    end,
}

SMODS.Shader {
    key = "cryptic",
    path = "cryptic.fs",
}

SMODS.Edition {
    key = "cryptic",
    shader = "cryptic",
	atlas = "mf_jokers",
	pos = { x = 6, y = 7 },
	loc_vars = function(self, info_queue, card)
        return { key = card.playing_card and "e_mf_cryptic_playing_card" or nil }
	end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                pre_func = function()
                    SMODS.draw_cards(3)
                end,
                message = "??"
            }
        end
        if context.drawing_cards and context.amount > 0 then
            return {
                modify = context.amount + 3
            }
        end
    end
}