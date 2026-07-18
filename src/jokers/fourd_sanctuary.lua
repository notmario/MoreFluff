SMODS.Joker({
	key = "fourd_sanctuary",
	name = "4rd Sanctuary",
	config = {
		extra = { },
	},
	pos = { x = 9, y = 6 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "tarot", "rotarot", "exile", },
    mf_rotate_by = 1.0,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.freakiness, card.ability.extra.increase },
		}
	end,
	calculate = function(self, card, context)
        if context.using_consumeable
		and context.consumeable.ability.set == "Rotarot"
		and not context.consumeable.ability.mf_suspended then
            local has_suspended_rotarot = false
            for _, _card in pairs(G.mf_exile.cards) do
                if _card.ability.mf_suspended and _card.ability.set == "Rotarot" then
                    has_suspended_rotarot = true
                    break
                end
            end
            if not has_suspended_rotarot then
                for i = 1, 11 do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            FLUFF.create_and_suspend_card( {
                                key = context.consumeable.config.center_key,
                                area = G.play
                            }, i)
                            return true
                        end,
                    }))
                end
            end
        end
	end,
})
