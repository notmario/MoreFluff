G.get_new_superboss = function()
	local superboss_pool = {}
	for k, v in pairs(G.P_BLINDS) do
		if v.debuff.superboss then
			superboss_pool[k] = true
		end
	end

	local _, boss = pseudorandom_element(superboss_pool, pseudoseed("boss"))

	return boss
end

SMODS.Voucher({
	key = "superboss_ticket",
	atlas = "mf_vouchers",
	pos = { x = 3, y = 0 },

	no_collection = true,

	cost = 0,

	loc_vars = function(self)
		return {
			key = G.GAME.mf_forced_weird_route and "v_mf_superboss_ticket_weirdroute" or nil,
			vars = {
				G.GAME.win_ante or 8,
				(G.GAME.win_ante and G.GAME.round_resets.ante) and math.floor(
					G.GAME.round_resets.ante + (G.GAME.win_ante - G.GAME.round_resets.ante % G.GAME.win_ante)
				) or 8,
			},
		}
	end,

	redeem = function(self, card)
		if G.GAME.round_resets.ante ~= (G.GAME.win_ante or 8) then
			ease_ante((G.GAME.win_ante or 8) - G.GAME.round_resets.ante)
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			func = function()
				G.GAME.mf_superboss_active = true
				G.GAME.mf_superboss_shader_timer = G.TIMERS.REAL
				ease_background_colour{G.C.RED, special_colour = darken(G.C.BLACK, 0.2), contrast = 2}
				ease_background_colour_blind(G.STATE, "Small Blind")
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.15,
							func = function()
								SMODS.add_card {
									key = "p_mf_superboss_normal_1",
									area = G.play
								}
								return true
							end,
						}))

						delay(0.5)

						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.15,
							func = function()
								G.FUNCS.use_card({
									config = { ref_table = G.play.cards[1] }
								}, nil, nil)
								return true
							end,
						}))
						return true
					end,
				}))
				return true
			end,
		}))

		-- Increase ante scaling
		G.GAME.modifiers.scaling = G.GAME.modifiers.scaling or 1
		G.GAME.modifiers.bonus_scaling = (G.GAME.modifiers.bonus_scaling or 0 + 3)

		G.GAME.modifiers.scaling = G.GAME.modifiers.scaling + G.GAME.modifiers.bonus_scaling

		G.GAME.round_resets.blind_choices.Small = "bl_mf_bigger_blind"
		G.GAME.round_resets.blind_choices.Big = get_new_boss()
		G.GAME.round_resets.blind_choices.Boss = "bl_mf_violet_vessel_dx"
	end,

	requires = { "v_mf_impossiblevoucher" },
})

local ea = ease_ante
function ease_ante(mod, ...)
	if G.GAME.mf_superboss_active then
		play_sound("mf_buzzer")
		G.ROOM.jiggle = (G.ROOM.jiggle or 0) + 100
		ea(0, ...)
	else
		ea(mod, ...)
	end
end

local gfrb = G.FUNCS.reroll_boss
function G.FUNCS.reroll_boss(e, ...)
	if G.GAME.mf_superboss_active then
		play_sound("mf_buzzer")
		G.ROOM.jiggle = (G.ROOM.jiggle or 0) + 100
	else
		gfrb(e, ...)
	end
end

local csc = Card.set_cost

function Card:set_cost(...)
	csc(self, ...)
	if self.config.center.key == "v_mf_superboss_ticket" or
		self.config.center.key == "p_mf_superboss_normal_1" then
		self.cost = 0
	end
end

SMODS.Blind({
	key = "bigger_blind",
	name = "Bigger Blind",

	atlas = "mf_blinds",
	pos = { x = 0, y = 0 },

	dollars = 6,
	mult = 1,

	boss_colour = HEX("ac3232"),

	no_collection = true,

	in_pool = function(self)
		return false
	end,
})

SMODS.Blind({
	key = "violet_vessel_dx",
	name = "Violet Vessel DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 1 },

	discovered = true,

	dollars = 10,
	mult = 24,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	disable = function(self)
		G.GAME.blind.chips = G.GAME.blind.chips / 8
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	end,

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "cerulean_bell_dx",
	name = "Cerulean Bell DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 2 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,

		force_select_count = 3,
	},

	loc_vars = function(self)
		return { vars = { self.debuff.force_select_count } }
	end,

	disable = function(self)
		for k, v in ipairs(G.playing_cards) do
			v.ability.forced_selection = nil
		end
	end,

	drawn_to_hand = function(self)
		local any_forced = nil
		for k, v in ipairs(G.hand.cards) do
			if v.ability.forced_selection then
				any_forced = true
			end
		end
		if not any_forced then
			G.hand:unhighlight_all()
			local cb_dx_pool = {}
			for _, card in pairs(G.hand.cards) do
				cb_dx_pool[#cb_dx_pool + 1] = card
			end
			for _ = 1, self.debuff.force_select_count do
				if #cb_dx_pool == 0 then
					break
				end
				local forced_card = pseudorandom_element(cb_dx_pool, pseudoseed("cerulean_bell_dx"))
				-- table.remove(cb_dx_pool, forced_card)

				for i = 1, #cb_dx_pool do
					if cb_dx_pool[i] == forced_card then
						table.remove(cb_dx_pool, i)
						break
					end
				end

				forced_card.ability.forced_selection = true
				G.hand:add_to_highlighted(forced_card)
			end
		end
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "needle_dx",
	name = "The Needle DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 3 },

	discovered = true,

	dollars = 10,
	mult = 1,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	disable = function(self)
		ease_hands_played(G.GAME.blind.hands_sub)
		ease_discard(G.GAME.blind.discards_sub)
		G.GAME.current_round.discards_used = G.GAME.current_round.discards_used - G.GAME.blind.discards_sub
	end,

	set_blind = function(self)
		G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
		ease_hands_played(-G.GAME.blind.hands_sub)
		G.GAME.blind.discards_sub = G.GAME.round_resets.discards - 1
		ease_discard(-G.GAME.blind.discards_sub)
		G.GAME.current_round.discards_used = G.GAME.current_round.discards_used + G.GAME.blind.discards_sub
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "manacle_dx",
	name = "The Manacle DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 4 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	disable = function(self)
		if not G.GAME.blind.disabled then
			G.hand:change_size(3)

			G.FUNCS.draw_from_deck_to_hand(3)
		end
	end,

	defeat = function(self)
		if not G.GAME.blind.disabled then
			G.hand:change_size(3)
		end
	end,

	set_blind = function(self)
		G.hand:change_size(-3)
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "pillar_dx",
	name = "The Pillar DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 5 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	set_blind = function(self)
		for _, card in pairs(G.playing_cards) do
			if card.ability.mf_played_this_game and pseudorandom("pillar_dx") < 1 / 2 then
				card.ability.mf_played_this_game = false
			end
		end
	end,

	recalc_debuff = function(self, card, from_blind)
		if not G.GAME.blind.disabled and card.area ~= G.jokers then
			if card.ability.mf_played_this_game then
				return true
			end
		end
		return false
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "serpent_dx",
	name = "The Serpent DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 6 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "club_dx",
	name = "The Club DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 7 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	recalc_debuff = function(self, card, from_blind)
		if not G.GAME.blind.disabled and card.area ~= G.jokers then
			if not card:is_suit("Clubs") then
				return true
			end
		end
		return false
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "goad_dx",
	name = "The Goad DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 8 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	recalc_debuff = function(self, card, from_blind)
		if not G.GAME.blind.disabled and card.area ~= G.jokers then
			if not card:is_suit("Spades") then
				return true
			end
		end
		return false
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "window_dx",
	name = "The Window DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 9 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	recalc_debuff = function(self, card, from_blind)
		if not G.GAME.blind.disabled and card.area ~= G.jokers then
			if not card:is_suit("Diamonds") then
				return true
			end
		end
		return false
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "head_dx",
	name = "The Head DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 10 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	recalc_debuff = function(self, card, from_blind)
		if not G.GAME.blind.disabled and card.area ~= G.jokers then
			if not card:is_suit("Hearts") then
				return true
			end
		end
		return false
	end,

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "arm_dx",
	name = "The Arm DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 11 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	debuff_hand = function(self, cards, hand, handname, check)
		if G.GAME.blind.disabled then
			return
		end
		G.GAME.blind.triggered = false
		if to_number(G.GAME.hands[handname].level) > 0 then
			G.GAME.blind.triggered = true
			if not check then
				level_up_hand(nil, handname, nil, -G.GAME.hands[handname].level)
			end
		end
	end,

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "wheel_dx",
	name = "The Wheel DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 12 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	stay_flipped = function(self, area, card)
		if not G.GAME.blind.disabled then
			if area == G.hand then
				for _, other_card in pairs(G.hand.cards) do
					if other_card.facing == "front" then
						return true
					end
				end
			end
		end
		return false
	end,

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "house_dx",
	name = "The House DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 13 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	drawn_to_hand = function(self)
		if not G.GAME.blind.has_discarded then
			for _, v in ipairs(G.hand.cards) do
				G.hand.highlighted[#G.hand.highlighted + 1] = v
				v:highlight(true)
			end
			G.FUNCS.discard_cards_from_highlighted(nil, true)
			G.GAME.blind.has_discarded = true
		end
	end,

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "psychic_dx",
	name = "The Psychic DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 14 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		h_size_le = 4,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.Blind({
	key = "hook_dx",
	name = "The Hook DX",

	atlas = "mf_blinds",
	pos = { x = 0, y = 15 },

	discovered = true,

	dollars = 10,
	mult = 3,

	boss_colour = HEX("ac3232"),

	debuff = {
		superboss = true,

		akyrs_blind_difficulty = "dx",
		akyrs_cannot_be_disabled = true,
	},

	boss = {
		min = 9,
		max = 10,
		showdown = true,
	},

	drawn_to_hand = function(self)
		if G.GAME.blind.should_discard then
			for _, v in ipairs(G.hand.cards) do
				G.hand.highlighted[#G.hand.highlighted + 1] = v
				v:highlight(true)
			end
			G.FUNCS.discard_cards_from_highlighted(nil, true)
			G.GAME.blind.should_discard = false
		end
	end,

	press_play = function(self)
		G.GAME.blind.should_discard = true
	end,

	in_pool = function(self)
		return G.GAME.round_resets.ante > G.GAME.win_ante
	end,
})

SMODS.ScreenShader({
	key = "superboss",
	path = "superboss.fs",
	send_vars = function(self)
		return {
			iTime = G.TIMERS.REAL - (G.GAME.mf_superboss_shader_timer or 0),
		}
	end,
	should_apply = function(self)
		return G.GAME.mf_superboss_active
	end,
})

if BCATS and BCATS.BLIND_ATTRIBUTES then
	local blind_attrs = {
		["bl_mf_bigger_blind"] = { "none" },

		["bl_mf_violet_vessel_dx"] = { "floating", "metal" },
		["bl_mf_cerulean_bell_dx"] = { "floating", "angel" },
		["bl_mf_needle_dx"] = { "floating", "metal" },
		["bl_mf_manacle_dx"] = { "floating", "dark" },
		["bl_mf_pillar_dx"] = { "floating", "relic" },
		["bl_mf_serpent_dx"] = { "floating", "zombie" },
		["bl_mf_club_dx"] = { "floating", "aku" },
		["bl_mf_goad_dx"] = { "floating", "aku" },
		["bl_mf_window_dx"] = { "floating", "angel" },
		["bl_mf_head_dx"] = { "floating", "dark" },
		["bl_mf_arm_dx"] = { "floating", "aku" },
		["bl_mf_wheel_dx"] = { "floating", "metal" },
		["bl_mf_house_dx"] = { "floating", "relic" },
		["bl_mf_psychic_dx"] = { "floating", "relic" },
		["bl_mf_hook_dx"] = { "floating", "red" },
	}

	for k, v in pairs(blind_attrs) do
		BCATS.BLIND_ATTRIBUTES[k] = v
	end
end

SMODS.Booster({
	key = "superboss_normal_1",
	kind = "Superboss",
	atlas = "mf_packs",
	pos = { x = 0, y = 4 },
	config = { extra = 3, choose = 1, superboss_pack = true },
	cost = 0,
	weight = 0.,
	unlocked = true,
	discovered = true,
	draw_hand = false,
	no_collection = true,
	in_pool = function (...) return false end,
	create_card = function(self, card)
		_G.generating_superboss_pack = true
		local n_card = create_card("SuperbossToken", G.pack_cards, nil, nil, true, true, nil, "mf_superbosstoken")
		_G.generating_superboss_pack = nil
		return n_card
	end,
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra }, key = self.key:sub(1, -3) }
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.RED)
		ease_background_colour{G.C.RED, special_colour = darken(G.C.BLACK, 0.2), contrast = 2}
	end,
	group_key = "k_superboss_pack",
})

local ref = G.FUNCS.can_skip_booster
G.FUNCS.can_skip_booster = function(e, ...)
	-- ???????
	if SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.config.superboss_pack then
		if not G.GAME.mf_superboss_tried_to_skip then
			e.config.colour = G.C.RED
			e.config.button = 'skip_booster_fakeout'
		else
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		end
	else
		ref(e, ...)
	end
end

G.FUNCS.skip_booster_fakeout = function(e)
	play_sound("mf_buzzer")
	G.ROOM.jiggle = (G.ROOM.jiggle or 0) + 100
	G.GAME.mf_superboss_tried_to_skip = true
end

SMODS.ConsumableType({
	key = "SuperbossToken",
	primary_colour = HEX("ac3232"),
	secondary_colour = HEX("ac3232"),
	collection_rows = { 5, 5, 5 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_mf_violet_vessel_dx",
	can_stack = true,
	can_divide = true,
	no_collection = true
})

local my_superbosses = {
	"violet_vessel_dx",
	"cerulean_bell_dx",
	"needle_dx",
	"manacle_dx",
	"pillar_dx",
	"serpent_dx",
	"club_dx",
	"goad_dx",
	"window_dx",
	"head_dx",
	"arm_dx",
	"wheel_dx",
	"house_dx",
	"psychic_dx",
	"hook_dx",
}

for i, k in ipairs(my_superbosses) do
	SMODS.Consumable({
		set = "SuperbossToken",
		name = k,
		key = k,
		atlas = "mf_blinds",
		pos = { x = 0, y = i },
		display_size = { w = 68, h = 68 },
		config = {
			blind = "bl_mf_"..k,
		},
		cost = 3,
		unlocked = true,
		discovered = true,
		can_use = function(self, card)
			return true
		end,
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = G.P_BLINDS[self.config.blind]
			return {
				vars = { localize({ type = "name_text", set = "Blind", key = self.config.blind }), }
			}
		end,
		in_pool = function(self, args)
			return _G.generating_superboss_pack
		end,
		use = function(self, card, area, copier)
			G.GAME.round_resets.blind_choices.Boss = self.config.blind
		end,
	})
end

FLUFF.superboss_background = function()
	if not (G.GAME and G.GAME.mf_superboss_active) then return nil end

	local funny_offset_amount = 1 / ((G.GAME.mf_superboss_shader_timer - G.TIMERS.REAL) * 8. + 0.02)
	local mx, my = love.mouse.getPosition()
	local w,h = love.graphics.getDimensions()

	love.graphics.push()
	love.graphics.scale(1920 / w, 1080 / h)

	local function draw_chain( x, y, scale, rot, offset )
		love.graphics.push()

		love.graphics.scale(scale, scale)
		love.graphics.translate(x, y)

		local btx = ((mx - w/2) / w) * 16. * scale
		local bty = ((my - h/2) / h) * 16. * scale
		love.graphics.translate(btx, bty)

		love.graphics.rotate(rot)
		for i = 0, 52 do
			love.graphics.draw(G.ASSET_ATLAS["mf_chain"].image, -48 + (i - math.fmod(offset,  1.) + funny_offset_amount - 50) * -144, -48)
		end

		love.graphics.pop()
	end

	love.graphics.pop()

	love.graphics.setColor( 0.106, 0.149, 0.161, 0.6 )

	draw_chain ( -200, 0, 1., math.pi/16, G.TIMERS.REAL / 8. )
	draw_chain ( -200, 550, 1.05, -math.pi/32, -G.TIMERS.REAL / 6. )
	draw_chain ( -200, 650, 0.94, math.pi/46, G.TIMERS.REAL / 7. )
	draw_chain ( -200, 920, 1.1, -math.pi/64, -G.TIMERS.REAL / 5.6 )

	love.graphics.setColor( 0.106, 0.149, 0.161, 0.3 )

	draw_chain ( 50, -200, .53, math.pi / 2 - math.pi/24, G.TIMERS.REAL / 12. )
	draw_chain ( 550, -200, .49, math.pi / 2 + math.pi/48, -G.TIMERS.REAL / 13.2 )
	draw_chain ( 670, -200, .51, math.pi / 2 - math.pi/32, G.TIMERS.REAL / 12.1 )
	draw_chain ( 1050, -200, .55, math.pi / 2 + math.pi/36, -G.TIMERS.REAL / 11.7 )
	draw_chain ( 1150, -200, .47, math.pi / 2 - math.pi/20, G.TIMERS.REAL / 12.1 )
	draw_chain ( 1500, -200, .52, math.pi / 2 + math.pi/40, -G.TIMERS.REAL / 11.9 )
	draw_chain ( 1600, -200, .48, math.pi / 2 - math.pi/37, G.TIMERS.REAL / 10.4 )
	draw_chain ( 2050, -200, .49, math.pi / 2 + math.pi/35, -G.TIMERS.REAL / 11.4 )
	draw_chain ( 1980, -200, .54, math.pi / 2 - math.pi/28, G.TIMERS.REAL / 12.5 )
	draw_chain ( 2600, -200, .50, math.pi / 2 + math.pi/41, -G.TIMERS.REAL / 10.9 )
	draw_chain ( 2700, -200, .49, math.pi / 2 - math.pi/39, G.TIMERS.REAL / 9.9 )
	draw_chain ( 3000, -200, .51, math.pi / 2 + math.pi/38, -G.TIMERS.REAL / 12.9 )
	draw_chain ( 3300, -200, .48, math.pi / 2 - math.pi/42, G.TIMERS.REAL / 11.8 )
	draw_chain ( 3600, -200, .53, math.pi / 2 + math.pi/35, -G.TIMERS.REAL / 9.8 )
end

FLUFF.fwr_tobj = nil
local select_rad = 4.

-- from aquilarri
function FLUFF.get_card_pixel_pos(card)
    return 
        (G.ROOM.T.x + card.T.x + card.T.w * 0.5) * (G.TILESIZE * G.TILESCALE),
        (G.ROOM.T.y + card.T.y + card.T.h * 0.5) * (G.TILESIZE * G.TILESCALE)

end

local old_lovemousepressed = love.mousepressed
local old_lovemousereleased = love.mousereleased
function love.mousepressed(...)
	if G.GAME and G.GAME.mf_forced_weird_route then
		if G.GAME.mf_forced_weird_route_state == 1 then
			local tx, ty = FLUFF.get_card_pixel_pos(FLUFF.fwr_tobj)
			local mx, my = love.mouse.getPosition()
			local dx, dy = (mx - tx), (my - ty)
			local dist_sq = dx * dx + dy * dy
			local dist = (dist_sq) ^ 0.5

			if dist < select_rad then
				old_lovemousepressed(...)
				old_lovemousereleased(...)
				G.GAME.mf_forced_weird_route_state = 2
				G.GAME.mf_forced_weird_route = G.TIMERS.REAL - 0.55
			end
		end
		if G.GAME.mf_forced_weird_route_state == 2 then
			local tx, ty = FLUFF.get_card_pixel_pos(FLUFF.fwr_tobj)
			ty = ty + FLUFF.fwr_tobj.T.h * 0.55 * (G.TILESIZE * G.TILESCALE)
			local mx, my = love.mouse.getPosition()
			local dx, dy = (mx - tx), (my - ty)
			local dist_sq = dx * dx + dy * dy
			local dist = (dist_sq) ^ 0.5

			if dist < select_rad then
				old_lovemousepressed(...)
				old_lovemousereleased(...)
				G.GAME.mf_forced_weird_route_state = nil
				G.GAME.mf_forced_weird_route = nil
			end
		end
	else
		old_lovemousepressed(...)
	end
end

function love.mousereleased(...)
	if G.GAME and G.GAME.mf_forced_weird_route then
	else
		old_lovemousereleased(...)
	end
end

local old_lovekeypressed = love.keypressed
function love.keypressed(...)
	if G.GAME and G.GAME.mf_forced_weird_route then
	else
		old_lovekeypressed(...)
	end
end

local last_mx, last_my = 0, 0

local function inOutQuad(t)
	t = t * 2
	if t < 1 then
		return 1 / 2 * t * t
	else
		return -1 / 2 * ((t - 1) * (t - 3) - 1)
	end
end

local old_loveupdate = love.update
function love.update( dt )
	if G.GAME and G.GAME.mf_forced_weird_route then
		local mx, my = love.mouse.getPosition()
		local w,h = love.graphics.getDimensions()

		local tx, ty = w/2, h/2
		local old_tx, old_ty = w/2, h/2

		if G.GAME.mf_forced_weird_route_state == 0 and (G.TIMERS.REAL - G.GAME.mf_forced_weird_route > 3.7) then
			for _, card in pairs(G.shop_vouchers.cards) do
				if card.config.center_key == "v_mf_superboss_ticket" then
					FLUFF.fwr_tobj = card
					break
				end
			end
			G.GAME.mf_forced_weird_route_state = 1
		end
		if G.GAME.mf_forced_weird_route_state == 0 and (G.TIMERS.REAL - G.GAME.mf_forced_weird_route > .5) and (G.TIMERS.REAL - G.GAME.mf_forced_weird_route < 3.7) then
			tx, ty = last_mx, last_my
		end
		if G.GAME.mf_forced_weird_route_state == 1 then
			old_tx, old_ty = last_mx, last_my
			tx, ty = FLUFF.get_card_pixel_pos(FLUFF.fwr_tobj)

			tx = old_tx + (tx - old_tx) * inOutQuad(math.min(G.TIMERS.REAL - G.GAME.mf_forced_weird_route - 3.7, 1.))
			ty = old_ty + (ty - old_ty) * inOutQuad(math.min(G.TIMERS.REAL - G.GAME.mf_forced_weird_route - 3.7, 1.))
		end
		if G.GAME.mf_forced_weird_route_state == 2 then
			tx, ty = FLUFF.get_card_pixel_pos(FLUFF.fwr_tobj)
			old_tx, old_ty = tx, ty
			if (G.TIMERS.REAL - G.GAME.mf_forced_weird_route > 0.8) then
				ty = ty + FLUFF.fwr_tobj.T.h * 0.55 * (G.TILESIZE * G.TILESCALE)
				ty = old_ty + (ty - old_ty) * inOutQuad(math.min(G.TIMERS.REAL - G.GAME.mf_forced_weird_route - 0.8, 1.))
			end

		end

		if G.GAME.mf_forced_weird_route_state == 0 and (G.TIMERS.REAL - G.GAME.mf_forced_weird_route < 0.5) then
			last_mx, last_my = mx, my
			return old_loveupdate( dt )
		end

		local dx, dy = (mx - tx), (my - ty)

		local dist_sq = dx * dx + dy * dy
		local dist = (dist_sq) ^ 0.5

		if dist > select_rad then
			dx = 0
			dy = 0

			love.mouse.setPosition(tx + dx, ty + dy)
		end
	end

	return old_loveupdate( dt )
end

local game_start_run = Game.start_run
function Game:start_run(args)
    game_start_run(self, args)
    if self.GAME.mf_forced_weird_route then
		self.GAME.mf_forced_weird_route = self.TIMERS.REAL
		self.GAME.mf_forced_weird_route_state = 0
    end
end

local ld = love.draw
function love.draw(...)
	ld(...)
	if G.GAME and G.GAME.mf_forced_weird_route then
		local mx, my = love.mouse.getPosition()
		local w,h = love.graphics.getDimensions()

		local tx, ty = w/2, h/2
		local funnyoff = 0.
		tx, ty = mx, my

		if G.GAME.mf_forced_weird_route_state == 0 and (G.TIMERS.REAL - G.GAME.mf_forced_weird_route < .5) then
			funnyoff = 25. * (1 / ((G.TIMERS.REAL - G.GAME.mf_forced_weird_route) * 4.) - 0.5)
		end
		-- if G.GAME.mf_forced_weird_route_state == 1 then
		-- 	tx, ty = FLUFF.get_card_pixel_pos(FLUFF.fwr_tobj)
		-- end
		-- if G.GAME.mf_forced_weird_route_state == 2 then
		-- 	tx, ty = FLUFF.get_card_pixel_pos(FLUFF.fwr_tobj)
		-- 	if (G.TIMERS.REAL - G.GAME.mf_forced_weird_route > 0.8) then
		-- 		ty = ty + FLUFF.fwr_tobj.T.h * 0.55 * (G.TILESIZE * G.TILESCALE)
		-- 	end
		-- end

		local function draw_chain( x, y, scale, rot, offset )
			love.graphics.push()

			love.graphics.translate(x, y)
			love.graphics.scale(scale, scale)
			love.graphics.rotate(rot)
			for i = 1, 52 do
				love.graphics.draw(G.ASSET_ATLAS["mf_chain"].image, -32. + (i + funnyoff) * -144, -48)
			end

			love.graphics.pop()
		end

		love.graphics.setColor( 0.106, 0.149, 0.161, 0.3 )

		for i = 0,11 do
			draw_chain ( tx, ty, .2, G.TIMERS.REAL / 3. + math.pi / 6 * i + math.pi/16, 0. )
		end

		love.graphics.setColor( 0.106, 0.149, 0.161, 0.9 )

		for i = 0,3 do
			draw_chain ( tx, ty, .25, G.TIMERS.REAL / 4. + math.pi / 2 * i + math.pi/16, 0. )
		end
	end
end