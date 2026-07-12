-- rotate hook
local card_draw = Card.draw
function Card:draw(layer, ...)
	if self.config and self.config.center and self.config.center.mf_rotate_by then
		self.VT.r = self.VT.r + self.config.center.mf_rotate_by
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r + self.config.center.mf_rotate_by
		end
	end

	card_draw(self, layer, ...)

	if self.config and self.config.center and self.config.center.mf_rotate_by then
		self.VT.r = self.VT.r - self.config.center.mf_rotate_by
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r - self.config.center.mf_rotate_by
		end
	end
end

local ncwp = Node.collides_with_point
function Node:collides_with_point(point, ...)
	if self.config and self.config.center and self.config.center.mf_rotate_by then
		self.VT.r = self.VT.r + self.config.center.mf_rotate_by
	end

	local res = ncwp(self, point, ...)

	if self.config and self.config.center and self.config.center.mf_rotate_by then
		self.VT.r = self.VT.r - self.config.center.mf_rotate_by
	end

	return res
end

SMODS.DynaTextEffect({
	key = "rotarot_title",
	func = function(dynatext, index, letter)
		letter.r = math.pi / 12
	end,
})

SMODS.ConsumableType({
	key = "Rotarot",
	primary_colour = HEX("8e73d9"),
	secondary_colour = HEX("8e73d9"),
	collection_rows = { 5, 6 },
	shop_rate = 2.0,
	loc_txt = {},
	default = "c_mf_rot_strength",
	can_stack = true,
	can_divide = true,
})

SMODS.UndiscoveredSprite({
	key = "Rotarot",
	atlas = "mf_rotarots",
	path = "mf_rotarots.png",
	pos = { x = 0, y = 0 },
})

G.C.SECONDARY_SET.Rotarot = HEX("8e73d9")

-- type, cost, count, x pos, y pos, choose, size, weight
for _, booster_type in ipairs({
	{ "normal", 4, 4, 0, 2, 1, 3, 0.96 },
	{ "jumbo", 6, 2, 0, 3, 1, 5, 0.96 },
	{ "mega", 8, 2, 2, 3, 2, 5, 0.48 },
}) do
	for i = 1, booster_type[3] do
		SMODS.Booster({
			key = "rotarot_" .. booster_type[1] .. "_" .. i,
			kind = "Rotarot",
			atlas = "mf_packs",
			mf_rotate_by = math.pi / 4,
			pos = { x = booster_type[4] + (i - 1), y = booster_type[5] },
			config = { choose = booster_type[6], extra = booster_type[7], rotarot_pack = true },
			draw_hand = true,
			cost = booster_type[2],
			weight = booster_type[8],
			unlocked = true,
			discovered = true,
			no_collection = (i == 2) or (i == 4),
			attributes = { "rotarot", "consumable", },
			create_card = function(self, card)
				local n_card = create_card("Rotarot", G.pack_cards, nil, nil, true, true, nil, "mf_rotarot")
				return n_card
			end,
			ease_background_colour = function(self)
				ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Rotarot)
				ease_background_colour({
					new_colour = G.C.SECONDARY_SET.Rotarot,
					special_colour = G.C.BLACK,
					contrast = 2,
				})
			end,
			loc_vars = function(self, info_queue, card)
				local cfg = (card and card.ability) or self.config
				return { vars = { cfg.choose, cfg.extra }, key = self.key:sub(1, -3) }
			end,
			group_key = "k_rotarot_pack",
		})
	end
end

SMODS.Tag({
	key = "rotarot",
	atlas = "mf_tags",
	pos = { x = 1, y = 0 },
	unlocked = true,
	discovered = true,
	attributes = { "booster", },
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = { set = "Other", key = "p_mf_rotarot_mega", specific_vars = { 2, 5 } }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SECONDARY_SET.Code, function()
				local key = "p_mf_rotarot_mega_1"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				-- uh. should this be here??
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true, true)
				end
				card:start_materialize()
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})

-- fool
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Fool",
	key = "rot_fool",
	pos = { x = 0, y = 0 },
	config = {},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "generation", "rotarot", "colour", "consumable", },
	can_use = function(self, card)
		if
			(#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables)
			and G.GAME.last_rot_tarot_colour
			and G.GAME.last_rot_tarot_colour ~= "c_mf_rot_fool"
		then
			return true
		end
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		if G.GAME.last_rot_tarot_colour and G.GAME.last_rot_tarot_colour ~= "c_mf_rot_fool" then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound("timpani")
						local card = create_card(
							"Rot_Tarot_Colour",
							G.consumeables,
							nil,
							nil,
							nil,
							nil,
							G.GAME.last_rot_tarot_colour,
							"fool"
						)
						card:add_to_deck()
						G.consumeables:emplace(card)
						used_tarot:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
		end
		delay(0.6)
	end,
	loc_vars = function(self, info_queue, card)
		local fool_c = G.GAME.last_rot_tarot_colour and G.P_CENTERS[G.GAME.last_rot_tarot_colour] or nil
		local last_tarot_planet = fool_c and localize({ type = "name_text", key = fool_c.key, set = fool_c.set })
			or localize("k_none")
		local colour = (not fool_c or fool_c.name == "rot_Fool") and G.C.RED or G.C.GREEN
		loc_vars = { last_tarot_planet }
		if not (not fool_c or fool_c.name == "rot_Fool") then
			info_queue[#info_queue + 1] = fool_c
		end

		main_end = {
			{
				n = G.UIT.C,
				config = { align = "bm", padding = 0.02 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = " " .. last_tarot_planet .. " ",
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.3,
									shadow = true,
								},
							},
						},
					},
				},
			},
		}
		return { vars = { last_tarot_planet }, main_end = main_end }
	end,
})

-- magician
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Magician",
	key = "rot_magician",
	pos = { x = 1, y = 0 },
	config = {
		max_highlighted = 5,
		mod_conv = "m_mf_yucky",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_yucky

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

SMODS.Consumable({
	set = "Rotarot",
	name = "rot_HighPriestess",
	key = "rot_high_priestess",
	pos = { x = 2, y = 0 },
	config = {
		val = 2,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "generation", "colour", "consumable", },
	can_use = function(self, card)
		return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		for i = 1, math.min(card.ability.val, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound("timpani")
						local card = create_card("Colour", G.consumeables, nil, nil, nil, nil, nil, "pri")
						card:add_to_deck()
						G.consumeables:emplace(card)
						used_tarot:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
		end
		delay(0.6)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- empress
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Empress",
	key = "rot_empress",
	pos = { x = 3, y = 0 },
	config = {
		max_highlighted = 2,
		mod_conv = "m_mf_cult",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_cult

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

-- emperor
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Emperor",
	key = "rot_emperor",
	pos = { x = 4, y = 0 },
	config = {
		val = 2,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "generation", "rotarot", "consumable", },
	can_use = function(self, card)
		return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		for i = 1, math.min(card.ability.val, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound("timpani")
						local card = create_card("Rotarot", G.consumeables, nil, nil, nil, nil, nil, "emp")
						card:add_to_deck()
						G.consumeables:emplace(card)
						used_tarot:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
		end
		delay(0.6)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- hierophant
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Heirophant",
	key = "rot_heirophant",
	pos = { x = 5, y = 0 },
	config = {
		max_highlighted = 2,
		mod_conv = "m_mf_monus",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_monus

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

-- lovers
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Lovers",
	key = "rot_lovers",
	pos = { x = 6, y = 0 },
	config = {
		max_highlighted = 2,
		mod_conv = "m_mf_styled",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_styled

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

-- chariot
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Chariot",
	key = "rot_chariot",
	pos = { x = 7, y = 0 },
	config = {
		max_highlighted = 1,
		mod_conv = "m_mf_teal",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_teal

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

-- justice
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Justice",
	key = "rot_justice",
	pos = { x = 8, y = 0 },
	config = {
		max_highlighted = 1,
		mod_conv = "m_mf_brass",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_brass

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

-- hermit
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Hermit",
	key = "rot_hermit",
	pos = { x = 9, y = 0 },
	config = {
		val = 25,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "economy", },
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				give = card.ability.val - math.fmod(to_number(G.GAME.dollars), card.ability.val)
				if give == card.ability.val then
					give = 0
				end
				ease_dollars(give)
				return true
			end,
		}))
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

FLUFF.blacklisted_editions = {
	"e_base", -- oops
	"e_mf_titlescreenace",
}

-- wheel of fortune
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Wheel",
	key = "rot_wheel",
	pos = { x = 0, y = 1 },
	config = {
		chance = 5,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "editions", "modify_card", "joker", },
	can_use = function(self, card)
		return #card.eligible_strength_jokers >= 1
	end,
	update = function(self, card, dt)
		if G.jokers then
			card.eligible_strength_jokers = EMPTY(card.eligible_strength_jokers)
			for k, v in pairs(G.jokers.cards) do
				if v.ability.set == "Joker" and not v.edition then
					table.insert(card.eligible_strength_jokers, v)
				end
			end
		end
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		if SMODS.pseudorandom_probability(card, "rot_wheel", 1, card.ability.chance, "rot_wheel") then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					local over = false
					local eligible_card =
						pseudorandom_element(card.eligible_strength_jokers, pseudoseed("evil_wheel_roll"))
					local edition_pool = {}
					for _, ed in pairs(G.P_CENTER_POOLS["Edition"]) do
						for _, bl_ed in pairs(FLUFF.blacklisted_editions) do
							if ed.key == bl_ed then
								goto wof_continue
							end
						end
						edition_pool[#edition_pool + 1] = ed.key
						::wof_continue::
					end
					local edition = pseudorandom_element(edition_pool, pseudoseed("evil_wheel_roll"))
					eligible_card:set_edition(edition, true)
					check_for_unlock({ type = "have_edition" })
					used_tarot:juice_up(0.3, 0.5)
					return true
				end,
			}))
		else
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					attention_text({
						text = localize("k_nope_ex"),
						scale = 1.3,
						hold = 1.4,
						major = used_tarot,
						backdrop_colour = G.C.SECONDARY_SET.Tarot,
						align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm",
						offset = {
							x = 0,
							y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0,
						},
						silent = true,
					})
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound("tarot2", 0.76, 0.4)
							return true
						end,
					}))
					play_sound("tarot2", 1, 0.4)
					used_tarot:juice_up(0.3, 0.5)
					return true
				end,
			}))
		end
	end,
	loc_vars = function(self, info_queue, card)
		for _, thing in pairs(G.P_CENTER_POOLS["Edition"]) do
			for _, bl_ed in pairs(FLUFF.blacklisted_editions) do
				if thing.key == bl_ed then
					goto wof_loc_continue
				end
			end
			info_queue[#info_queue + 1] = thing
			::wof_loc_continue::
		end

		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.chance, "rot_wheel")

		return { vars = {
			new_numerator,
			new_denominator,
		} }
	end,
})

-- strength
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Strength",
	key = "rot_strength",
	pos = { x = 1, y = 1 },
	config = {
		max_highlighted = 3,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "rank", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_tarot:juice_up(0.3, 0.5)
				return true
			end,
		}))
		for i = 1, #G.hand.highlighted do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound("card1", percent)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					local _card = G.hand.highlighted[i]
					local new_rank = pseudorandom_element(SMODS.Ranks, pseudoseed("rot_strength"))
					assert(SMODS.change_base(_card, nil, new_rank.key))
					return true
				end,
			}))
		end
		for i = 1, #G.hand.highlighted do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound("tarot2", percent, 0.6)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end,
		}))
		delay(0.5)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highlighted } }
	end,
})

-- hanged man
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Hanged",
	key = "rot_hanged_man",
	pos = { x = 2, y = 1 },
	config = {
		val = 3,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "destroy_card", },
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	use = function(self, card, area, copier)
		local temp_hand = {}
		local destroyed_cards = {}
		for k, v in ipairs(G.hand.cards) do
			temp_hand[#temp_hand + 1] = v
		end
		table.sort(temp_hand, function(a, b)
			return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
		end)
		pseudoshuffle(temp_hand, pseudoseed("brown"))

		for i = 1, math.min(#temp_hand, card.ability.val) do
			destroyed_cards[#destroyed_cards + 1] = temp_hand[i]
		end

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				SMODS.destroy_cards(destroyed_cards)
				return true
			end,
		}))
		delay(0.6)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- death
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Death",
	key = "rot_death",
	pos = { x = 3, y = 1 },
	config = {
		max_highlighted = 3,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				used_tarot:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.2)
		for i = 1, #G.hand.highlighted do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound("tarot2", percent, 0.6)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		local rightmost = pseudorandom_element(G.hand.highlighted, pseudoseed("rot_death"))
		for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if G.hand.highlighted[i] ~= rightmost then
						copy_card(rightmost, G.hand.highlighted[i])
					end
					return true
				end,
			}))
		end
		delay(0.2)
		for i = 1, #G.hand.highlighted do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound("tarot2", percent, 0.6)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end,
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end,
		}))
		delay(0.5)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.max_highlighted } }
	end,
})

-- temperance
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Temperance",
	key = "rot_temperance",
	pos = { x = 4, y = 1 },
	config = {
		val = 3,
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "sell_value", "economy", "modify_card", },
	can_use = function(self, card)
		return #G.jokers.cards >= 1 or #G.consumeables.cards >= 1
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		for k, v in ipairs(G.jokers.cards) do
			if v.set_cost then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.val
						v:set_cost()
						v:juice_up(0.3, 0.5)
						used_tarot:juice_up(0.3, 0.5)
						play_sound("timpani")
						return true
					end,
				}))
			end
		end
		for k, v in ipairs(G.consumeables.cards) do
			if v.set_cost then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.val
						v:set_cost()
						v:juice_up(0.3, 0.5)
						used_tarot:juice_up(0.3, 0.5)
						play_sound("timpani")
						return true
					end,
				}))
			end
		end
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- devil
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Devil",
	key = "rot_devil",
	pos = { x = 5, y = 1 },
	config = {
		max_highlighted = 3,
		mod_conv = "m_mf_marigold",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_marigold

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

-- tower
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Tower",
	key = "rot_tower",
	pos = { x = 6, y = 1 },
	config = {
		max_highlighted = 1,
		mod_conv = "m_mf_gemstone",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "enhancements", "modify_card", },
	can_use = function(self, card)
		return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_gemstone

		return {
			vars = {
				card and card.ability.max_highlighted or self.config.max_highlighted,
				localize({ type = "name_text", set = "Enhanced", key = self.config.mod_conv }),
			},
		}
	end,
})

function do_suit_shit(card, copier)
	local used_tarot = copier or card
	local target_area = G.hand
	if G.STATE == G.STATES.BLIND_SELECT or G.STATE == G.STATES.ROUND_EVAL then
		target_area = G.deck
	end
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.7,
		func = function()
			play_sound("tarot1")
			used_tarot:juice_up(0.3, 0.5)
			local cards = {}
			for i = 1, card.ability.val do
				cards[i] = true
				local _suit, _rank = nil, nil
				_rank = pseudorandom_element(
					{ "A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K" },
					pseudoseed("suitarot")
				)
				_suit = card.ability.suit
				local cen_pool = {}
				for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
					if v.key ~= "m_stone" and not v.overrides_base_rank then
						cen_pool[#cen_pool + 1] = v
					end
				end
				create_playing_card({
					front = G.P_CARDS[_suit .. "_" .. _rank],
					center = pseudorandom_element(cen_pool, pseudoseed("suitarot")),
				}, target_area, nil, i ~= 1, { G.C.SECONDARY_SET.Rotarot })
			end
			playing_card_joker_effects(cards)
			return true
		end,
	}))
end

-- star
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Star",
	key = "rot_star",
	pos = { x = 7, y = 1 },
	config = {
		val = 3,
		suit = "D",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "playing_card", "suit", "diamonds", "enhancements", },
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	use = function(self, card, area, copier)
		do_suit_shit(card, copier)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- moon
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Moon",
	key = "rot_moon",
	pos = { x = 8, y = 1 },
	config = {
		val = 3,
		suit = "C",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "playing_card", "suit", "clubs", "enhancements", },
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	use = function(self, card, area, copier)
		do_suit_shit(card, copier)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- sun
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Sun",
	key = "rot_sun",
	pos = { x = 9, y = 1 },
	config = {
		val = 3,
		suit = "H",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "playing_card", "suit", "hearts", "enhancements", },
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	use = function(self, card, area, copier)
		do_suit_shit(card, copier)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- judgement
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_Judgement",
	key = "rot_judgement",
	pos = { x = 0, y = 2 },
	config = {},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "generation", "joker", },
	can_use = function(self, card)
		return #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers
	end,
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
			func = function()
                play_sound('timpani')
				SMODS.add_card {
					set = "Joker",
					attributes = { "Joker" },
					filter = function ( pool )
						local new_pool = {}
						for k, v in pairs(pool) do
							if G.P_CENTERS[v.key].original_mod then
								table.insert(new_pool, v)
							end
						end
						return new_pool
					end,
				}
				used_tarot:juice_up(0.3, 0.5)
				return true
			end,
		}))
        delay(0.6)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- world
SMODS.Consumable({
	set = "Rotarot",
	name = "rot_World",
	key = "rot_world",
	pos = { x = 1, y = 2 },
	config = {
		val = 3,
		suit = "S",
	},
	cost = 3,
	atlas = "mf_rotarots",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "playing_card", "suit", "diamonds", "enhancements", },
	can_use = function(self, card)
		return #G.hand.cards >= 1
	end,
	use = function(self, card, area, copier)
		do_suit_shit(card, copier)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.val } }
	end,
})

-- the soul!!
SMODS.Consumable({
	set = "Spectral",
	name = "rot_The Soul",
	key = "rot_soul",
	pos = { x = 2, y = 2 },
	cost = 4,
	hidden = true,
	soul_set = "Rotarot",
	unlocked = true,
	discovered = true,
	mf_rotate_by = math.pi / 4,
	attributes = { "generation", "joker" },
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				SMODS.add_card({ set = "Joker", rarity = "mf_rot_legendary" })
				check_for_unlock({ type = "spawn_legendary" })
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
	end,
	can_use = function(self, card)
		return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
	end,
})

SMODS.DrawStep({
	key = "mf_rot_soul",
	order = 50,
	func = function(card)
		if
			card.config.center.key == "c_mf_rot_soul"
			and (card.config.center.discovered or card.bypass_discovery_center)
		then
			local scale_mod = 0.05
				+ 0.05 * math.sin(1.8 * G.TIMERS.REAL)
				+ 0.07
					* math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14)
					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
			local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL)
				+ G.TIMERS.REAL / 8
				+ 0.07
					* math.sin(G.TIMERS.REAL * math.pi * 5)
					* (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

			G.shared_soul.role.draw_major = card
			G.shared_soul:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				card.children.center,
				scale_mod,
				rotate_mod,
				nil,
				0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
				nil,
				0.6
			)
			G.shared_soul:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})


SMODS.Voucher({
	object_type = "Voucher",
	key = "rotarot_merchant",
	atlas = "mf_vouchers",
	pos = { x = 0, y = 1 },
	mf_rotate_by = math.pi / 4,
	config = {
		extra = { odds_mult = 3, },
	},
	attributes = { "rotarot", "consumable", "booster", "shop" },
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue)
		return { vars = {
			self.config.extra.odds_mult
		} }
	end,
	calculate = function(self, card, context)
		if context.modify_weights and context.pool_types.Booster then
			for _, c in pairs(context.pool) do
				if G.P_CENTERS[c.key] and G.P_CENTERS[c.key].kind == "Rotarot" then
					c.weight = c.weight * card.ability.extra.odds_mult
				end
			end
		end
		if context.open_booster and context.card.config.center.kind == "Rotarot" then
			context.card.ability.extra = context.card.ability.extra + 1
		end
    end,
})
SMODS.Voucher({
	object_type = "Voucher",
	key = "rotarot_tycoon",
	atlas = "mf_vouchers",
	pos = { x = 1, y = 1 },
	mf_rotate_by = math.pi / 4,
	config = {
		extra = { odds_mult = 3, },
	},
	attributes = { "rotarot", "consumable", "booster", "shop" },
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue)
		return { vars = {
			self.config.extra.odds_mult * G.P_CENTERS["v_mf_rotarot_merchant"].config.extra.odds_mult
		} }
	end,
	calculate = function(self, card, context)
		if context.modify_weights and context.pool_types.Booster then
			for _, c in pairs(context.pool) do
				if G.P_CENTERS[c.key] and G.P_CENTERS[c.key].kind == "Rotarot" then
					c.weight = c.weight * card.ability.extra.odds_mult
				end
			end
		end
		if context.open_booster and context.card.config.center.kind == "Rotarot" then
			context.card.ability.extra = context.card.ability.extra + 1
		end
    end,
	requires = { "v_mf_rotarot_merchant" },
})