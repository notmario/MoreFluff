SMODS.Joker {
	key = "summoners_pact",
	name = "Summoner's Pact",
	atlas = "mf_jokers",
	config = {
		extra = {
            cards = 17,
        },
	},
	pos = { x = 2, y = 15 },

	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { "generation", "joker", "rarity", "exile", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards },
		}
	end,
	-- set_ability = function(self, card, initial, delay_sprites)
	-- 	if not card.ability.mf_exile_until_id then card.ability.mf_exile_until_id = math.random(1000000000000) end
	-- end,
	calculate = function(self, card, context)
		if context.setting_blind and not card.getting_sliced then
			local jokers_to_create = math.min(1,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        local other_card = SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Rare',
                            key_append = 'summoners_pact'
                        }
                        other_card.ability.mf_exile_until_id = other_card.ability.mf_exile_until_id or math.random(1000000000000)
                        for i = 1, card.ability.extra.cards do
                            FLUFF.draw_to_exile(false, i / card.ability.extra.cards, nil, function(other_other_card)
                                other_other_card.ability.mf_pact_id = other_card.ability.mf_exile_until_id
                            end)
                        end
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
		end
    end,
}