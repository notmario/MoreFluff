SMODS.Joker({
	key = "aura_farm",
	name = "Aura Farm",

	atlas = "mf_purple",
	rarity = "mf_scrapped",
	no_collection = true,
	cost = 7,
	pos = { x = 0, y = 0 },
	config = { extra = { } },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", "tarot", },
	loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_aura
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
	end,
})

local fhpc = FLUFF.has_prepared_card
function FLUFF.has_prepared_card(card)
    if next(SMODS.find_card("j_mf_aura_farm")) and card.ability.set == "Tarot" and card.area == G.consumeables then
        return true
    end
    return fhpc(card)
end

local fgpc = FLUFF.get_prepared_card
function FLUFF.get_prepared_card(card)
    if next(SMODS.find_card("j_mf_aura_farm")) and card.ability.set == "Tarot" then
        return "c_aura"
    end
    return fgpc(card)
end

local fip = FLUFF.is_prepared
function FLUFF.is_prepared(card)
    if next(SMODS.find_card("j_mf_aura_farm")) and card.ability.set == "Tarot" and card.area == G.consumeables then
        return (card.ability.extra or {}).is_prepared ~= false
    end
    return fip(card)
end
