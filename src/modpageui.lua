-- referencing ellejokers
-- which is referencing aikoshen
-- lol ?

-- originally from slimeutils
function create_display_card(key, s, no_ui)
    s = s or 1
	local card = Card(G.ROOM.T.x,G.ROOM.T.y,G.CARD_W*.75*s,G.CARD_H*.75*s,nil,G.P_CENTERS[key], { bypass_discovery_center = true, bypass_discovery_ui = true })
	card.no_ui = no_ui
	card.states.drag.can = false
	return card
end

local card_pool = FLUFF.joker_pool

SMODS.Shader {
    key="triangle_badge_alt",
    path="triangle_badge_alt.fs"
}

FLUFF.custom_ui = function(mod_nodes)
	mod_nodes = EMPTY(mod_nodes)

    local chosen_cards = {"triangle"}
    local random_card = function()
        if #chosen_cards >= #card_pool then
            return card_pool[math.ceil(math.random() * #card_pool)]
        else
            local card, card_unique
            repeat
                card = card_pool[math.ceil(math.random() * #card_pool)]
                card_unique = true
                for _, c in pairs(chosen_cards) do
                    if c == card then card_unique = false end
                end
            until card_unique

            chosen_cards[#chosen_cards + 1] = card

            return card
        end
    end

	mod_nodes[#mod_nodes+1] = {n = G.UIT.C, config = {padding = 0.1}, nodes = {
		{n = G.UIT.R,
			config = {
				align = "cm"
			}, nodes = {
				{n = G.UIT.R,
					config = {
						r = 0.1,
						align = "cm",
						padding = 0.1,
						colour = HEX("ff6868"),
					}, nodes = {
						{n = G.UIT.C,
							config = {
								r = 0.1,
								align = "cm",
								padding = 0.2,
								colour = G.C.BLACK,
                                shader = "mf_triangle_badge_alt",
							}, nodes = {
								{n = G.UIT.T, config = {text = "More Fluff", scale = .8, colour = G.C.WHITE}}
						}}
				}}
		}},
        {n = G.UIT.R, config = {align = "cm"}, nodes = {{n = G.UIT.T, config = {text = "(Or: an Assortment of Balatro Cards of Dubious Excellence)", scale = .3, colour = G.C.WHITE}}}},
        {n = G.UIT.R, config = {align = "cm"}, nodes = {{n = G.UIT.T, config = {text = "(Brought to you by John Balatro)", scale = .3, colour = G.C.WHITE}}}},
        {n = G.UIT.R, config = {align = "cm"}, nodes = {
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.O, config = { object = create_display_card("j_mf_"..random_card(), 0.7, false) }}}},
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.O, config = { object = create_display_card("j_mf_"..random_card(), 0.9, false) }}}},
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.O, config = { object = create_display_card("j_mf_"..random_card(), 1.0, false) }}}},
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.O, config = { object = create_display_card("j_mf_"..random_card(), 1.1, false) }}}},
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.O, config = { object = create_display_card("j_mf_"..random_card(), 1.0, false) }}}},
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.O, config = { object = create_display_card("j_mf_"..random_card(), 0.9, false) }}}},
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.O, config = { object = create_display_card("j_mf_"..random_card(), 0.7, false) }}}},
        }},
        {n = G.UIT.R, config = {align = "cm"}, nodes = {
            {n = G.UIT.R,
                config = {
                    emboss = 0.05,
                    r = 0.1,
                    minw = 6,
                    minh = 2.4,
                    align = "cm",
                    padding = 0.1,
                    colour = G.C.L_BLACK
                }, nodes = {
                {n = G.UIT.C, nodes = {{n = G.UIT.O, config = { object = create_display_card('j_mf_triangle', 1.0, true), juice_up = true } }}},
                {n = G.UIT.C, config = {align = "cl", padding = 0.1, minw = 4}, nodes = {
                    {n = G.UIT.R, nodes = {
                        {n = G.UIT.T, config = {text = "by this ", scale = .4, colour = G.C.WHITE}},
                        {n = G.UIT.T, config = {text = "mf", scale = .4, colour = HEX("ff6868")}}
                    }},
                    {n = G.UIT.R, nodes = {{n = G.UIT.T, config = {text = "(with help from many others!)", scale = .3, colour = G.C.WHITE}}}}
                }}
            }},
        }},
    }}
end