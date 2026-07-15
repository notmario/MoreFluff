SMODS.Joker({
	key = "repack",
	name = "Repack",
	atlas = "mf_jokers",
	config = {
		extra = { },
	},
	pos = { x = 7, y = 5 },
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "shop", "booster", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_mf_modded_normal_1
	end,
	calculate = function(self, card, context)
		if context.starting_shop and not card.ability.triggered then
			card.ability.triggered = true
			SMODS.add_booster_to_shop("p_mf_modded_normal_1")
			SMODS.add_booster_to_shop("p_mf_modded_normal_2")
			return nil, true
		end
		if context.end_of_round then
			card.ability.triggered = nil
		end
	end,
})

for i = 1,2 do
    SMODS.Booster({
        key = "modded_normal_"..i,
        kind = "Modded",
        atlas = "mf_packs",
        pos = { x = i - 1, y = 1 },
        config = { extra = 3, choose = 1, modded_pack = true },
        cost = 8,
        weight = 0.,
        unlocked = true,
        discovered = true,
        draw_hand = true,
        no_collection = true,
        in_pool = function (...) return false end,
        create_card = function(self, card)
            -- ah shit.
            local ctype = "Joker"
            if pseudorandom("modded_isconsumable") > 0.5 then
                ctype = "Consumeables"
            end

            local n_card = SMODS.create_card {
                set = ctype,
                attributes = { ctype },
                skip_materialize = true,
                filter = function ( pool )
                    local new_pool = {}
                    for k, v in pairs(pool) do
                        if G.P_CENTERS[v.key].original_mod then
                            table.insert(new_pool, v)
                        end
                    end
                    if #new_pool == 0 then return pool end
                    return new_pool
                end,
            }
            return n_card
        end,
        loc_vars = function(self, info_queue, card)
            local cfg = (card and card.ability) or self.config
            return { vars = { cfg.choose, cfg.extra }, key = self.key:sub(1, -3) }
        end,
        group_key = "k_modded_pack",
    })
end