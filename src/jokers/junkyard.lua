SMODS.Joker({
	key = "junkyard",
	name = "Junkyard",
	atlas = "mf_jokers",
	config = {
		extra = { xmult = 1.5, xchips = 1.5 },
	},
	pos = { x = 2, y = 13 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "enhancement", "xmult", "xchips", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.xmult, center.ability.extra.xchips },
		}
	end,
	calculate = function(self, card, context)
        if context.initial_scoring_step then
            local rets = {}

            for _, other_card in ipairs(context.full_hand) do
                if SMODS.has_no_rank(other_card) then
                    rets[#rets + 1] = {
                        xmult = card.ability.extra.xmult,
                        xchips = card.ability.extra.xchips,
                        card = other_card
                    }
                end
            end

            return SMODS.merge_effects(rets)
        end
	end,
})
