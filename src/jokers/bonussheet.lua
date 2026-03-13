SMODS.Joker {
    key = "bonussheet",
    name = "Bonus Sheet",
    atlas = "mf_jokers",
    config = {
    },
    pos = {x = 3, y = 1},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = false,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { colours = { HEX "000000" } }
        }
    end,
    calculate = function(self, card, context)
        if context.open_booster then
            if context.booster and context.booster.kind == "Buffoon" then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    func = function()
                        card:juice_up(0.5, 0.5)
                        SMODS.add_card {
                            set = "Joker",
                            area = G.pack_cards,
                            rarity = "mf_oldfluff",
                        }
                        return true
                    end
                }))
            end
        end
    end,
}