-- referencing ellejokers
-- which is referencing aikoshen
-- lol ?

-- originally from slimeutils
function create_display_card(key, s, no_ui)
	s = s or 1
	local card = Card(
		G.ROOM.T.x,
		G.ROOM.T.y,
		G.CARD_W * 0.75 * s,
		G.CARD_H * 0.75 * s,
		nil,
		G.P_CENTERS[key],
		{ bypass_discovery_center = true, bypass_discovery_ui = true }
	)
	card.no_ui = no_ui
	card.states.drag.can = false
	return card
end

local card_pool = FLUFF.joker_pool

local times_spawned = 0
local has_toggled = false

SMODS.Shader({
	key = "triangle_badge_alt",
	path = "triangle_badge_alt.fs",
})

FLUFF.custom_ui = function(mod_nodes)
	times_spawned = times_spawned + 1

	if times_spawned >= 10 then
		if times_spawned % 2 == 1 then
			if not has_toggled then
				has_toggled = true
				for _, center in pairs(G.P_CENTERS) do
					if center.original_mod == FLUFF then
						center.no_collection = false
					end
				end
			end
			card_pool = FLUFF.hidden_joker_pool
		else
			card_pool = FLUFF.joker_pool
		end
	end
	mod_nodes = EMPTY(mod_nodes)

	local chosen_cards = { "triangle" }
	local random_card = function()
		if #chosen_cards >= #card_pool then
			return card_pool[math.ceil(math.random() * #card_pool)]
		else
			local card, card_unique
			repeat
				card = card_pool[math.ceil(math.random() * #card_pool)]
				card_unique = true
				for _, c in pairs(chosen_cards) do
					if c == card then
						card_unique = false
					end
				end
			until card_unique

			chosen_cards[#chosen_cards + 1] = card

			return card
		end
	end

	mod_nodes[#mod_nodes + 1] = {
		n = G.UIT.C,
		config = { padding = 0.1 },
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
				},
				nodes = {
					{
						n = G.UIT.R,
						config = {
							r = 0.1,
							align = "cm",
							padding = 0.1,
							colour = HEX("ff6868"),
						},
						nodes = {
							{
								n = G.UIT.C,
								config = {
									r = 0.1,
									align = "cm",
									padding = 0.2,
									colour = G.C.BLACK,
									shader = "mf_triangle_badge_alt",
								},
								nodes = {
									{ n = G.UIT.T, config = { text = "More Fluff", scale = 0.8, colour = G.C.WHITE } },
								},
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = "(Or: an Assortment of Balatro Cards of Dubious Excellence)",
							scale = 0.3,
							colour = G.C.WHITE,
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = { text = "(Brought to you by John Balatro)", scale = 0.3, colour = G.C.WHITE },
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = { object = create_display_card("j_mf_" .. random_card(), 0.7, false) },
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = { object = create_display_card("j_mf_" .. random_card(), 0.9, false) },
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = { object = create_display_card("j_mf_" .. random_card(), 1.0, false) },
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = { object = create_display_card("j_mf_" .. random_card(), 1.1, false) },
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = { object = create_display_card("j_mf_" .. random_card(), 1.0, false) },
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = { object = create_display_card("j_mf_" .. random_card(), 0.9, false) },
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = { object = create_display_card("j_mf_" .. random_card(), 0.7, false) },
							},
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							emboss = 0.05,
							r = 0.1,
							minw = 6,
							minh = 2.4,
							align = "cm",
							padding = 0.1,
							colour = G.C.L_BLACK,
						},
						nodes = {
							{
								n = G.UIT.C,
								nodes = {
									{
										n = G.UIT.O,
										config = {
											object = create_display_card("j_mf_triangle", 1.0, true),
											juice_up = true,
										},
									},
								},
							},
							{
								n = G.UIT.C,
								config = { align = "cl", padding = 0.1, minw = 4 },
								nodes = {
									{
										n = G.UIT.R,
										nodes = {
											{
												n = G.UIT.T,
												config = { text = "by this ", scale = 0.4, colour = G.C.WHITE },
											},
											{
												n = G.UIT.T,
												config = { text = "mf", scale = 0.4, colour = HEX("ff6868") },
											},
										},
									},
									{
										n = G.UIT.R,
										nodes = {
											{
												n = G.UIT.T,
												config = {
													text = "(with help from many others!)",
													scale = 0.3,
													colour = G.C.WHITE,
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	}
end

FLUFF.extra_tabs = function() 
	return {
		{
			label = localize("mf_credits"),
			chosen = false,
			tab_definition_function = FLUFF.credits_ui,
		},
	}
end

G.FUNCS.duelzone_ver2_link = function(e)
  	love.system.openURL( "https://www.youtube.com/watch?v=F-Dm3ayqwkI" )
end

FLUFF.credits_ui = function()
	local artists_nodes = {
		{ n = G.UIT.R, config = { align = "cm", }, nodes = { { n = G.UIT.T, config = { text = "Misc. Jokers", scale = .4, shadow = true, align = "bm" } } } },
	}

	local artist_keys = {}

	for key, _ in pairs(FLUFF.artists) do
		if key ~= "Multi" then artist_keys[#artist_keys + 1] = key end -- colour card
	end

	table.sort(artist_keys, function (a, b) return string.lower(a) < string.lower(b) end)

	for _, artist_key in ipairs(artist_keys) do
		local dev = FLUFF.artists[artist_key]
		artists_nodes[#artists_nodes + 1] = { 
			n = G.UIT.R, config = { align = "cm", }, 
			nodes = { { n = G.UIT.T, config = { text = artist_key, scale = 0.25, shadow = true, align = "bm", colour = dev.colour } } }
		}
	end

    local ui = {
        n = G.UIT.ROOT,
        config = { align = "cm", minh = G.ROOM.T.h * .5, minw = G.ROOM.T.w * .5, padding = 0.0, r = 0.1, colour = G.C.BLACK, emboss = 0.05, },
        nodes = {
			{
				n = G.UIT.C,
				config = { align = "cl", padding = 0.1, minw = 4 },
				nodes = {
					{
						n = G.UIT.R,
							config = { align = "cm", minw = 2.5, minh = 2.5, padding = 0.05, r = 0.1, colour = G.C.L_BLACK },
						nodes = {
							{
								n = G.UIT.C,
                        		config = { align = "cl", minw = 1.9, minh = 1, padding = 0.05, },
								nodes = {
                            		{ n = G.UIT.R, config = {}, nodes = { { n = G.UIT.T, config = { text = "Programming", scale = .4, shadow = true, align = "tm" } } } },
                            		{ n = G.UIT.R, config = {}, nodes = { { n = G.UIT.T, config = { text = "Booster Music", scale = .4, shadow = true, align = "tm" } } } },
                            		{ n = G.UIT.R, config = {}, nodes = { { n = G.UIT.T, config = { text = "Most Art", scale = .4, shadow = true, align = "tm" } } } },
								},
							},
							{
								n = G.UIT.C,
                        		config = { align = "cm", minw = 2.1, minh = 1, padding = 0.05, },
								nodes = {
                            		{ n = G.UIT.R, config = {}, nodes = { { n = G.UIT.T, config = { text = "by notmario", scale = .4, shadow = true, align = "tm" } } } },
								},
							},
							{
								n = G.UIT.C,
								nodes = {
									{
										n = G.UIT.O,
										config = {
											object = create_display_card("j_mf_triangle", 1.0, true),
											juice_up = true,
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = { minw = .05 }, 
					},
					{
						n = G.UIT.R,
						config = { minw = 3.5, minh = 0.03, colour = G.C.L_BLACK, emboss = 0. }, 
					},
					{
						n = G.UIT.R,
						config = { minw = .05 }, 
					},
					{
						n = G.UIT.R,
						config = { align = "cm", minw = .05 },
						nodes = {
							{ n = G.UIT.R, config = {}, nodes = { { n = G.UIT.T, config = { text = "Other Art", scale = .5, shadow = true, align = "tm" } } } },
						}
					},
					{
						n = G.UIT.R,
						config = { minw = .05 }, 
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cm", minw = 2.5, minh = 2.5, padding = 0.05, r = 0.1, colour = G.C.L_BLACK },
								nodes = {

                            		{ n = G.UIT.R, config = { align = "cm", }, nodes = { {
										n = G.UIT.O,
										config = {
											object = create_display_card("c_mf_lilac", 1.0, true),
											juice_up = true,
										},
									} } },
									
                            		{ n = G.UIT.R, config = { align = "cm", }, nodes = { { n = G.UIT.T, config = { text = "Colour Cards", scale = .4, shadow = true, align = "bm" } } } },
                            		{ n = G.UIT.R, config = { align = "cm", }, nodes = { { n = G.UIT.T, config = { text = "by Multi", scale = .3, shadow = true, align = "bm" } } } },
								},
							},
							{
								n = G.UIT.C,
								config = { align = "cm", minw = .05 },
							},
							{
								n = G.UIT.C,
								config = { align = "cm", minw = 2.5, minh = 2.5, padding = 0.05, r = 0.1, colour = G.C.L_BLACK },
								nodes = artists_nodes,
							},
							{
								n = G.UIT.C,
								config = { align = "cm", minw = .05 },
							},
							{
								n = G.UIT.C,
								config = { align = "cm", minw = 2.5, minh = 2.5, padding = 0.05, r = 0.1, colour = G.C.L_BLACK },
								nodes = {
                            		{ n = G.UIT.R, config = { align = "cm", }, nodes = { { n = G.UIT.T, config = { text = "Superboss Theme", scale = .4, shadow = true, align = "bm" } } } },
                            		{ n = G.UIT.R, config = { align = "cm", }, nodes = { { n = G.UIT.T, config = { text = "DUEL ZONE (VER. 2)", scale = .3, shadow = true, align = "bm" } } } },
                            		{ n = G.UIT.R, config = { align = "cm", }, nodes = { { n = G.UIT.T, config = { text = "by dante, Geshtro", scale = .3, shadow = true, align = "bm" } } } },
                            		G.F_EXTERNAL_LINKS and { n = G.UIT.R, config = { align = "cm", }, nodes = { { n=G.UIT.C, config={padding = 0.}, nodes={
										UIBox_button({label = {'Youtube'}, button = 'duelzone_ver2_link', scale = .5, padding = 0.02})
									}} } } or nil,
                            		
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = { minw = .05 }, 
					},
					{
						n = G.UIT.R,
						config = { minw = 3.5, minh = 0.03, colour = G.C.L_BLACK, emboss = 0. }, 
					},
					{
						n = G.UIT.R,
						config = { minw = .05 }, 
					},
					{
						n = G.UIT.R,
						config = { align = "cm", minw = .05 },
						nodes = {
							{ n = G.UIT.R, config = {}, nodes = { { n = G.UIT.T, config = { text = "thank you for playing! <3", scale = .3, shadow = true, align = "tm" } } } },
						}
					},
				},
			},
        }
    }

    return ui
end