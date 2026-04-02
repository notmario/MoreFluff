SMODS.Joker {
    key = "refrigerator",
    name = "Refrigerator",
	atlas = "mf_jokers",
	config = { extra = 1 },
	pos = { x = 8, y = 10 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "joker", },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra }}
	end,
    calculate = function(self, card, context)
		if
			(context.setting_blind and not card.getting_sliced)
			and not (context.blueprint_card or card).getting_sliced
			and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
            and G.GAME.blind.boss
		then
			local jokers_to_create = math.floor(
				math.min(card.ability.extra, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			)
            for i = 1, jokers_to_create do
                local key = SMODS.poll_object { type = "Joker", attributes = { "food" } }
                SMODS.add_card { key = key, type = "Joker", }
            end
			return { message = localize("k_plus_joker"), colour = G.C.BLUE }
		end
        if context.check_eternal and FLUFF.has_attribute(context.other_card, "food") and context.trigger.destroy_cards then
            return { no_destroy = { override_compat = true } }
        end
    end,
}

local ssc = SMODS.scale_card
function SMODS.scale_card(card, ...)
    if next(SMODS.find_card("j_mf_refrigerator")) and FLUFF.has_attribute(card, "food") then return nil end
    return ssc(card, ...)
end