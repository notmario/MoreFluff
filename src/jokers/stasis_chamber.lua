SMODS.Joker {
	key = "stasis_chamber",
	name = "Stasis Chamber",
	atlas = "mf_jokers",
	config = {
		extra = { },
	},
	pos = { x = 6, y = 14 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "discard" },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
	end,
}

local gfdcfh = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook, ...)
    if not hook and next(SMODS.find_card("j_mf_stasis_chamber")) then
        stop_use()
        G.CONTROLLER.interrupt.focus = true
        G.CONTROLLER:save_cardarea_focus('hand')

        for k, v in ipairs(G.playing_cards) do
            v.ability.forced_selection = nil
        end

        if G.CONTROLLER.focused.target and G.CONTROLLER.focused.target.area == G.hand then G.card_area_focus_reset = {area = G.hand, rank = G.CONTROLLER.focused.target.rank} end
        local highlighted_count = math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards)
        if highlighted_count > 0 then 
            update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
            table.sort(G.hand.highlighted, function(a,b) return a.T.x < b.T.x end)
            inc_career_stat('c_cards_discarded', highlighted_count)
            local cards = {}
            local destroyed_cards = {}
            for i=1, highlighted_count do
                table.insert(cards, G.hand.highlighted[i])
                G.hand.highlighted[i].ability.discarded = true
                -- draw_card(G.hand, G.discard, i*100/highlighted_count, 'down', false, G.hand.highlighted[i])
                FLUFF.exile_card(G.hand.highlighted[i], -i/highlighted_count, "ante")
            end

            G.GAME.round_scores.cards_discarded.amt = G.GAME.round_scores.cards_discarded.amt + #cards
            if not hook then
                if G.GAME.modifiers.discard_cost then
                    ease_dollars(-G.GAME.modifiers.discard_cost)
                end
                ease_discard(-1)
                G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + 1
                G.STATE = G.STATES.DRAW_TO_HAND
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.STATE_COMPLETE = false
                        return true
                    end
                }))
            end
        end
    else
        gfdcfh(e, hook, ...)
    end
end

-- local dc = draw_card
-- function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only, ...)
-- 	if to == G.discard and card and next(SMODS.find_card("j_mf_stasis_chamber")) then
--         to = G.mf_exile
-- 		G.E_MANAGER:add_event(Event({
-- 			trigger = 'before',
-- 			delay = 0.,
-- 			func = function()
-- 				card.T.w = card.T.w * FLUFF.exile_scale
-- 				card.T.h = card.T.h * FLUFF.exile_scale
-- 				return true
-- 			end
-- 		}))
--     end
-- 	dc(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only, ...)
-- end