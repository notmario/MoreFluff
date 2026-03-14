SMODS.Joker {
    key = "lettergem_m",
    atlas = "mf_oldfluff",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    no_collection = true,
    no_shader_on_modbadge = true,
    lettergem_badge = true,
    pools = {
        letterjoker = true,
    },
    rarity = "mf_oldfluff",
    cost = 3 * 2,
    pos = { x = 3, y = 4 },
    config = { extra = { price = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(1,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        local other_card = SMODS.add_card {
                            set = 'Joker',
                            key = 'j_jolly',
                        }
                        other_card.ability.extra_value = (other_card.ability.extra_value or 0) + card.ability.extra.price
                        other_card:set_cost()
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