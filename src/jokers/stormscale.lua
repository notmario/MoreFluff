SMODS.Joker {
	key = "stormscale",
	name = "Stormscale",
	atlas = "mf_oldfluff",
	config = {
        extra = {
            xmult = 1.5,
            purchases_required = 2,
            purchases = 0,
        }
    },
	pos = { x = 4, y = 6 },
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	attributes = { "xmult", "jokers", "generation" },
	loc_vars = function(self, info_queue, center)
        return { vars = { 
            center.ability.extra.xmult,
            nil,
            center.ability.extra.purchases_required,
            math.floor(center.ability.extra.purchases / center.ability.extra.purchases_required),
        } }
	end,
	calculate = function(self, card, context)
        if (context.buying_card and context.card ~= card) or (context.open_booster) and not context.blueprint then
            card.ability.extra.purchases = card.ability.extra.purchases + 1
            if math.fmod(card.ability.extra.purchases, card.ability.extra.purchases_required) < 0.01 then
                return {
                    message = localize "k_upgrade_ex"
                }
            else
                return {
                    message = math.fmod(card.ability.extra.purchases, card.ability.extra.purchases_required) .. "/" .. card.ability.extra.purchases_required
                }
            end
        end
        if context.ending_shop and not context.blueprint and card.ability.extra.purchases >= card.ability.extra.purchases_required then
            for i = 1, math.floor(card.ability.extra.purchases / card.ability.extra.purchases_required) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local other_card = SMODS.add_card { key = "j_mf_stormscale" }
                        other_card:set_edition("e_negative", true)
                        other_card.ability.extra.stormscale_temp = true
                        return true
                    end
                }))
            end
            return { message = localize('k_duplicated_ex') }
        end
        if context.end_of_round and not context.blueprint then
            if card.ability.extra.stormscale_temp then
                SMODS.destroy_cards(card, nil, nil, true)
            else
                card.ability.extra.purchases = 0
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
	end,
}
