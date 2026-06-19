SMODS.Joker({
	key = "marketable_plushie",
	name = "Marketable Plushie",
	config = {
		extra = { },
	},
	pos = { x = 6, y = 6 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "passive" },
	calculate = function(self, card, context)
	end,
})


SMODS.PokerHandPart {
    key = 'plushie_all',
    func = function(hand) if #hand > 0 then return {hand} end end,
}

for k, hand in pairs(SMODS.PokerHands) do
    local old_hand_evaluate = hand.evaluate
    hand.evaluate = function (parts, hand)
        local has_active_plushie = false
        for _, present in pairs(SMODS.find_card("j_mf_marketable_plushie")) do
        	has_active_plushie = true
			break
        end
        if has_active_plushie then
            if k == "cry_None" then
                -- probably for the best
            elseif k == "Three of a Kind" then
                return parts.mf_plushie_all
            else
                return {}
            end
        end
        return old_hand_evaluate(parts, hand)
    end
end