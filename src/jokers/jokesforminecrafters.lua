local jokes = {}

jokes["none"] = {
    key = "none",
    check = function(card) return true end,
}
jokes["hearts"] = {
    key = "hearts",
    check_suit = "Hearts",
}
jokes["diamonds"] = {
    key = "diamonds",
    check_suit = "Diamonds",
}
jokes["clubs"] = {
    key = "clubs",
    check_suit = "Clubs",
}
jokes["spades"] = {
    key = "spades",
    check_suit = "Spades",
}
jokes["face"] = {
    key = "face",
    check = function(card) return card:is_face(true) end,
}
jokes["hack"] = {
    key = "hack",
    check_ranks = {2,3,4,5},
}
jokes["odd"] = {
    key = "odd",
    check_ranks = {14,3,5,7,9},
}
jokes["even"] = {
    key = "even",
    check_ranks = {2,4,6,8,10},
}
jokes["fib"] = {
    key = "fib",
    check_ranks = {14,2,3,5,8},
}

SMODS.Joker {
	key = "jokesforminecrafters",
	name = "Jokes for Minecrafters",
	atlas = "mf_jokers",
	config = {
		extra = {
            current_joke = "none",
            has_triggered = false,
        },
	},
	pos = { x = 9, y = 12 },
	rarity = 1,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "destroy_card", "discard" },
	loc_vars = function(self, info_queue, card)
		return {
            key = "j_mf_jokesforminecrafters_"..card.ability.extra.current_joke,
			vars = {},
		}
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.current_joke = pseudorandom_element(jokes, "choose_joke").key
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.current_joke = pseudorandom_element(jokes, "choose_joke").key
            card.ability.extra.has_triggered = false
            return {
                message = localize "k_page_turn"
            }
		end
        if context.pre_discard then
            for _, other_card in ipairs(context.full_hand) do
                if not card.ability.extra.has_triggered then
                    local joke = jokes[card.ability.extra.current_joke]

                    local valid = false
                    if joke.check then valid = joke.check(other_card) end
                    if joke.check_suit then valid = other_card:is_suit(joke.check_suit) end
                    if joke.check_ranks then
                        for _, rank in pairs(joke.check_ranks) do
                            if other_card:get_id() == rank then valid = true end
                        end
                    end

                    if valid then
                        card.ability.extra.has_triggered = true
                        SMODS.destroy_cards { other_card }
                        delay(0.5)
                    end
                end
            end
        end
	end,
}