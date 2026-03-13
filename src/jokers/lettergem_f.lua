SMODS.Joker {
    key = "lettergem_f",
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
    cost = 4 * 2,
    pos = { x = 6, y = 3 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX "a9683b" } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(1,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'letterjoker',
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = HEX "a9683b",
            }
        end
    end,
}