SMODS.Joker({
	key = "jokerreacts",
	name = "Joker Reacts To Broccoli",
	atlas = "mf_jokers",
	config = {
		extra = { odds = 3, dollars = 2, mult_gain = 1, mult = 0 },
	},
	pos = { x = 7, y = 11 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "joker", "scaling", "mult", "economy", "face_down", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.odds, card.ability.extra.dollars, card.ability.extra.mult_gain, card.ability.extra.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.modify_weights and context.pool_types.Joker then
			for _, c in pairs(context.pool) do
				if FLUFF.has_attribute(c.key, "food") then
					c.weight = c.weight * card.ability.extra.odds
				end
			end
		end
        if context.modify_shop_card and FLUFF.has_attribute(context.card, "food") then
            context.card.mf_force_face_down = true
        end
        if context.buying_card and FLUFF.has_attribute(context.card, "food") then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_gain",
                message_key = "a_mult",
                message_colour = G.C.RED,
            })
            return {
                dollars = card.ability.extra.dollars
            }
        end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})

local cae = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped, ...)
    cae(self, card, location, stay_flipped, ...)
    if card.mf_force_face_down and self == G.shop_jokers then
        card.facing = 'back'
        card.sprite_facing = 'back'
        card.flipping = 'f2b'
    end
end