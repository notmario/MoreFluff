SMODS.Stake {
    key = "pink",
    above_stake = "gold",
    applied_stakes = { "gold" },
    atlas = 'mf_stakes',
    pos = { x = 0, y = 0 },
    sticker_atlas = "mf_stake_stickers",
    sticker_pos = { x = 0, y = 0 },
    prefix_config = { applied_stakes = { mod = false } },
    modifiers = function()
        G.GAME.modifiers.mf_force_standard_pack = true
    end,
    colour = HEX("e379dd"),
}

local gp = get_pack
function get_pack(_key, _type)
    if G.GAME.modifiers.mf_force_standard_pack and #G.GAME.current_round.used_packs == 1 then
        return G.P_CENTERS['p_standard_normal_'..(math.random(1, 4))]
    else
        return gp(_key, _type)
    end
end

-- SMODS.Stake {
--     key = "lime",
--     above_stake = "pink",
--     applied_stakes = { "pink" },
--     atlas = 'mf_stakes',
--     pos = { x = 1, y = 0 },
--     sticker_atlas = "mf_stake_stickers",
--     sticker_pos = { x = 1, y = 0 },
--     modifiers = function()
--         G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
--     end,
--     colour = HEX("5cf85f"),
-- }

SMODS.Stake {
    key = "steel",
    above_stake = "pink",
    applied_stakes = { "pink" },
    atlas = 'mf_stakes',
    pos = { x = 0, y = 1 },
    sticker_atlas = "mf_stake_stickers",
    sticker_pos = { x = 0, y = 1 },
    shiny = true,
    modifiers = function()
        G.GAME.modifiers.enable_heavy_in_shop = true
    end,
    colour = HEX("dee7f6"),
}

SMODS.Sticker {
    key = "heavy",
    badge_colour = HEX '65a5dd',
    pos = { x = 1, y = 2 },
    atlas = "mf_stake_stickers",
    sets = { ["Joker"] = true },
    should_apply = function (self, card, center, area, bypass_reroll)
        return false
    end,
    calculate = function(self, card, context)
        -- print(context)
    end
}

local catd = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    local should_do_it = not self.added_to_deck
    catd(self, from_debuff)
    if should_do_it then
        if self.ability["mf_heavy"] then
            SMODS.change_discard_limit(-1)
        end
    end
end

local crfd = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    local should_do_it = self.added_to_deck
    crfd(self, from_debuff)
    if should_do_it then
        if self.ability["mf_heavy"] then
            SMODS.change_discard_limit(1)
        end
    end
end

SMODS.Stake {
    key = "zodiac",
    above_stake = "steel",
    applied_stakes = { "steel" },
    atlas = 'mf_stakes',
    pos = { x = 1, y = 1 },
    sticker_atlas = "mf_stake_stickers",
    sticker_pos = { x = 1, y = 1 },
    modifiers = function()
        G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.1,
        func = function()
            local vouchers = {}
            if G.GAME.used_vouchers["v_tarot_merchant"] then
                vouchers[#vouchers + 1] = "v_tarot_tycoon"
            else
                vouchers[#vouchers + 1] = "v_tarot_merchant"
            end
            if G.GAME.used_vouchers["v_planet_merchant"] then
                vouchers[#vouchers + 1] = "v_planet_tycoon"
            else
                vouchers[#vouchers + 1] = "v_planet_merchant"
            end
            if G.GAME.used_vouchers["v_magic_trick"] then
                vouchers[#vouchers + 1] = "v_illusion"
            else
                vouchers[#vouchers + 1] = "v_magic_trick"
            end
            for k, v in pairs(vouchers) do
                G.GAME.used_vouchers[v] = true
                G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                    Card.apply_to_run(nil, G.P_CENTERS[v])
                    return true
                    end
                }))
            end
            return true end
        }))
    end,
    colour = HEX("534e79"),
}

SMODS.Stake {
    key = "hot",
    above_stake = "zodiac",
    applied_stakes = { "zodiac" },
    atlas = 'mf_stakes',
    pos = { x = 2, y = 1 },
    sticker_atlas = "mf_stake_stickers",
    sticker_pos = { x = 2, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_potato_in_shop = true
    end,
    colour = HEX("fb4f20"),
}

SMODS.Sticker {
    key = "potato",
    badge_colour = HEX 'e77e56',
    pos = { x = 2, y = 2 },
    atlas = "mf_stake_stickers",
    sets = { ["Joker"] = true },
    should_apply = function (self, card, center, area, bypass_reroll)
        return false
    end,
    calculate = function(self, card, context)
        -- print(context)
    end
}

local ccsc = Card.can_sell_card
function Card:can_sell_card(context)
    local result = ccsc(self, context)

    if self.area == G.jokers then
        local has_potato = false
        for _, card in pairs(G.jokers.cards) do
            if card.ability["mf_potato"] then
                has_potato = true
            end
        end
        if has_potato and not self.ability["mf_potato"] then
            return false
        end
    end
    
    return result
end

-- SMODS.Stake {
--     key = "accelerated",
--     above_stake = "hot",
--     applied_stakes = { "hot" },
--     atlas = 'mf_stakes',
--     pos = { x = 3, y = 1 },
--     sticker_atlas = "mf_stake_stickers",
--     sticker_pos = { x = 3, y = 1 },
--     modifiers = function()
--         G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
--     end,
--     colour = HEX("4f6367"),
-- }

-- SMODS.Stake {
--     key = "cardboard",
--     above_stake = "accelerated",
--     applied_stakes = { "accelerated" },
--     atlas = 'mf_stakes',
--     pos = { x = 0, y = 2 },
--     sticker_atlas = "mf_stake_stickers",
--     sticker_pos = { x = 0, y = 2 },
--     modifiers = function()
--         G.GAME.uncommon_mod = G.GAME.uncommon_mod * 0.5
--         G.GAME.rare_mod = G.GAME.rare_mod * 0.5
--     end,
--     colour = HEX("cd9d71"),
-- }

-- SMODS.Stake {
--     key = "violet",
--     above_stake = "cardboard",
--     applied_stakes = { "cardboard" },
--     atlas = 'mf_stakes',
--     pos = { x = 2, y = 0 },
--     sticker_atlas = "mf_stake_stickers",
--     sticker_pos = { x = 2, y = 0 },
--     modifiers = function()
--         G.GAME.modifiers.ante_4_showdown = true
--     end,
--     colour = HEX("7859e4"),
-- }

-- local gnb = get_new_boss
-- function get_new_boss()
--     local force_showdown = false
--     local old_ante = G.GAME.round_resets.ante
--     if G and G.GAME and G.GAME.modifiers and G.GAME.modifiers.ante_4_showdown then
--         force_showdown = true
--     end

--     if force_showdown and G.GAME.round_resets.ante == 4 then
--         G.GAME.round_resets.ante = G.GAME.win_ante
--     end
--     local ret = gnb()
--     G.GAME.round_resets.ante = old_ante

--     return ret
-- end

SMODS.Stake {
    key = "jimbo",
    above_stake = "hot",
    applied_stakes = { "hot" },
    atlas = 'mf_stakes',
    pos = { x = 3, y = 0 },
    sticker_atlas = "mf_stake_stickers",
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.win_ante = G.GAME.win_ante + 1
        G.GAME.modifiers.jimbostake_force_antenine = true
    end,
    colour = G.C.RED,
}

local cc = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = cc(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)

    if _type == "Joker" and (area == G.shop_jokers or area == G.pack_cards) then
        local heavypoll = pseudorandom((area == G.pack_cards and 'packheavy' or 'heavypoll')..G.GAME.round_resets.ante)
        if G.GAME.modifiers.enable_heavy_in_shop and heavypoll > 0.70 then
            card.ability["mf_heavy"] = true
        end
        local potpoll = pseudorandom((area == G.pack_cards and 'packpot' or 'potpoll')..G.GAME.round_resets.ante)
        if G.GAME.modifiers.enable_potato_in_shop and potpoll > 0.70 and not card.ability.eternal then
            card.ability["mf_potato"] = true
        end
    end

    return card
end

local gfb = get_blind_amount
function get_blind_amount(ante, ...)
    if G.GAME.modifiers.scaling == 3 and G.GAME.modifiers.jimbostake_force_antenine and ante == 9 then
        return 500000
    end
    return gfb(ante, ...)
end