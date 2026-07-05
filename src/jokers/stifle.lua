SMODS.Joker {
	key = "stifle",
	name = "Stifle",

	config = {
		extra = {
            chips = 120,
        },
	},
	atlas = "mf_jokers",
	pos = { x = 0, y = 16 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "chips", "joker", "position" },
	loc_vars = function(self, info_queue, card)
		return {
            vars = { card.ability.extra.chips }
        }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            -- check joker to the right
            right_card = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    right_card = G.jokers.cards[i + 1]
                end
            end
            if right_card then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
	end,
}

local card_can_calculate = Card.can_calculate
function Card:can_calculate(ignore_debuff, ignore_sliced, ...)
    if self.area == G.jokers then
        -- check joker to the left
        left_card = nil
        for i = 2, #G.jokers.cards do
            if G.jokers.cards[i] == self then
                left_card = G.jokers.cards[i - 1]
            end
        end
        if left_card and left_card.config.center_key == "j_mf_stifle" then
            return false
        end
    end
    return card_can_calculate(self, ignore_debuff, ignore_sliced, ...)
end