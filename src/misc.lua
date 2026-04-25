-- quantum enhancements and post triggers are for lettergem ...
FLUFF.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
	quantum_enhancements = true,
	object_weights = true,
}

-- sts mana value
SMODS.DrawStep({
	key = "spire_mv",
	order = 25,
	func = function(self)
		if not FLUFF.mv_spr then
			FLUFF.mv_spr = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["mf_mv"], { x = 0, y = 0 })
		end
		local my_key = self.config.center.key

		if
			my_key ~= "j_mf_dramaticentrance"
			and my_key ~= "j_mf_dropkick"
			and my_key ~= "j_mf_bladedance"
			and my_key ~= "j_mf_hyperbeam"
			and my_key ~= "j_mf_blasphemy"
		then
			return nil
		end

		FLUFF.mv_spr.role.draw_major = self

		local cost = math.floor(self.cost + (self.ability.extra_value or 0) * 2 + 0.5)

		local base_cost = ({
			j_mf_dramaticentrance = 6,
			j_mf_dropkick = 8,
			j_mf_bladedance = 8,
			j_mf_hyperbeam = 8,
			j_mf_blasphemy = 5,
		})[my_key]

		local shader = "dissolve"

		if cost > 99 then
			FLUFF.mv_spr:set_sprite_pos({ x = 0, y = 3 })
			FLUFF.mv_spr:draw_shader("dissolve", nil, nil, nil, self.children.center)
		elseif cost <= 9 then
			FLUFF.mv_spr:set_sprite_pos({ x = cost, y = 0 })
			FLUFF.mv_spr:draw_shader("dissolve", nil, nil, nil, self.children.center)
		else
			FLUFF.mv_spr:set_sprite_pos({ x = math.floor(cost / 10), y = 1 })
			FLUFF.mv_spr:draw_shader("dissolve", nil, nil, nil, self.children.center)
			FLUFF.mv_spr:set_sprite_pos({ x = cost % 10, y = 2 })
			FLUFF.mv_spr:draw_shader("dissolve", nil, nil, nil, self.children.center)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

-- temporary
-- pulled from Entropy. thanks ruby!
local e_round = end_round
function end_round()
	e_round()
	local remove_temp = {}
	for i, v in pairs({ G.jokers, G.hand, G.consumeables, G.discard, G.deck }) do
		for ind, card in pairs(v.cards) do
			if card.ability then
				if card.ability.mf_temporary then
					if
						card.area ~= G.hand
						and card.area ~= G.play
						and card.area ~= G.jokers
						and card.area ~= G.consumeables
					then
						card.states.visible = false
					end
					card:remove_from_deck()
					card:start_dissolve()
					if card.ability.mf_temporary then
						remove_temp[#remove_temp + 1] = card
					end
				end
			end
		end
	end
	if #remove_temp > 0 then
		SMODS.calculate_context({ remove_playing_cards = true, removed = remove_temp })
	end
end

local mf_art_credit_thingy = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
	local ret_val = mf_art_credit_thingy(card)
	local obj = card.config.center
	local target = ret_val.nodes[1].nodes[1].nodes[1].nodes
	if obj and obj.mf_art_credit then
		local str = {
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						{
							n = G.UIT.T,
							config = { text = "art by ", shadow = true, colour = G.C.UI.BACKGROUND_WHITE, scale = 0.27 },
						},
						{
							n = G.UIT.O,
							config = {
								object = DynaText({
									string = obj.mf_art_credit,
									colours = { dev and dev.colour or G.C.UI.BACKGROUND_WHITE },
									scale = 0.27,
									silent = true,
									shadow = true,
								}),
							},
						},
					},
				},
			},
		}
		if str then
			table.insert(target, str)
		end
	end
	return ret_val
end

FLUFF.vanilla_jokers = {
	"j_joker",
	"j_greedy_joker",
	"j_lusty_joker",
	"j_wrathful_joker",
	"j_gluttenous_joker",
	"j_zany",
	"j_jolly",
	"j_mad",
	"j_crazy",
	"j_droll",
	"j_sly",
	"j_wily",
	"j_clever",
	"j_devious",
	"j_crafty",
	"j_half",
	"j_stencil",
	"j_four_fingers",
	"j_mime",
	"j_credit_card",
	"j_ceremonial",
	"j_banner",
	"j_mystic_summit",
	"j_marble",
	"j_loyalty_card",
	"j_8_ball",
	"j_misprint",
	"j_dusk",
	"j_raised_fist",
	"j_chaos",
	"j_fibonacci",
	"j_steel_joker",
	"j_scary_face",
	"j_abstract",
	"j_delayed_grat",
	"j_hack",
	"j_pareidolia",
	"j_gros_michel",
	"j_even_steven",
	"j_odd_todd",
	"j_scholar",
	"j_business",
	"j_supernova",
	"j_ride_the_bus",
	"j_space",
	"j_egg",
	"j_burglar",
	"j_blackboard",
	"j_runner",
	"j_ice_cream",
	"j_dna",
	"j_splash",
	"j_blue_joker",
	"j_sixth_sense",
	"j_constellation",
	"j_hiker",
	"j_faceless",
	"j_green_joker",
	"j_superposition",
	"j_todo_list",
	"j_cavendish",
	"j_card_sharp",
	"j_red_card",
	"j_madness",
	"j_square",
	"j_seance",
	"j_riff_raff",
	"j_vampire",
	"j_shortcut",
	"j_hologram",
	"j_vagabond",
	"j_baron",
	"j_cloud_9",
	"j_rocket",
	"j_obelisk",
	"j_midas_mask",
	"j_luchador",
	"j_photograph",
	"j_gift",
	"j_turtle_bean",
	"j_erosion",
	"j_reserved_parking",
	"j_mail",
	"j_to_the_moon",
	"j_hallucination",
	"j_fortune_teller",
	"j_juggler",
	"j_drunkard",
	"j_stone",
	"j_golden",
	"j_lucky_cat",
	"j_baseball",
	"j_bull",
	"j_diet_cola",
	"j_trading",
	"j_flash",
	"j_popcorn",
	"j_trousers",
	"j_ancient",
	"j_ramen",
	"j_walkie_talkie",
	"j_selzer",
	"j_castle",
	"j_smiley",
	"j_campfire",
	"j_ticket",
	"j_mr_bones",
	"j_acrobat",
	"j_sock_and_buskin",
	"j_swashbuckler",
	"j_troubadour",
	"j_certificate",
	"j_smeared",
	"j_throwback",
	"j_hanging_chad",
	"j_rough_gem",
	"j_bloodstone",
	"j_arrowhead",
	"j_onyx_agate",
	"j_glass",
	"j_ring_master",
	"j_flower_pot",
	"j_blueprint",
	"j_wee",
	"j_merry_andy",
	"j_oops",
	"j_idol",
	"j_seeing_double",
	"j_matador",
	"j_hit_the_road",
	"j_duo",
	"j_trio",
	"j_family",
	"j_order",
	"j_tribe",
	"j_stuntman",
	"j_invisible",
	"j_brainstorm",
	"j_satellite",
	"j_shoot_the_moon",
	"j_drivers_license",
	"j_cartomancer",
	"j_astronomer",
	"j_burnt",
	"j_bootstraps",
	"j_caino",
	"j_triboulet",
	"j_yorick",
	"j_chicot",
	"j_perkeo",
}

-- for talisman check
FLUFF.has_calc_key = function(key)
	for _, k in pairs(SMODS.scoring_parameter_keys) do
		if k == key then return true end
	end
	return false
end

FLUFF.should_talisman_key = function(key)
	return FLUFF.has_calc_key(key) and not not (SMODS.Mods.Talisman or SMODS.Mods.cdataman or {}).can_load
end

FLUFF.has_attribute = function (card, key)
	local card_key = card
	if Object.is(card, Card) then card_key = card.config.center.key end
	local pool = SMODS.get_attribute_pool(key)
	for _, c in pairs(pool) do
		if c == card_key then return true end
	end
	return false
end

-- from entr
local ref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local card = e.config.ref_table
    ref(e, mute, nosave)
    G.E_MANAGER:add_event(Event{
        trigger = "after",
        delay = 0.,
        blocking = false,
        blockable = true,
        func = function()
			if (card.config.center.set == "Rotarot" or card.config.center.set == "Colour") and not card.config.center.hidden then
				G.GAME.last_rot_tarot_colour = card.config.center.key
			end
			return true
		end
    })
end

-- prepared

-- kms but whatever
-- heavily stripped down slib function
local function get_dummy(center, area, self, silent)
    local abil = copy_table(center.config) or {}
    -- abil.max_highlighted = abil.max_highlighted
    -- abil.min_highlighted = abil.min_highlighted
    -- abil.mod_num = abil.mod_num
    abil.consumeable = copy_table(abil)
    abil.name = center.name or center.key
    abil.set = center.set
    abil.t_mult = abil.t_mult or 0
    abil.t_chips = abil.t_chips or 0
    abil.x_mult = abil.x_mult or abil.Xmult or 1
    abil.extra_value = abil.extra_value or 0
    abil.d_size = abil.d_size or 0
    abil.mult = abil.mult or 0
    abil.effect = center.effect
    abil.h_size = abil.h_size or 0
    -- abil.card_limit = abil.card_limit or 1
    abil.extra_slots_used = abil.extra_slots_used or 0
	if abil.consumeable.max_highlighted then
		abil.consumeable.mod_num = math.min(5, abil.consumeable.max_highlighted)
	end
    local eligible_editionless_jokers = {}
    for i, v in pairs(G.jokers and G.jokers.cards or {}) do
        if not v.edition then
            eligible_editionless_jokers[#eligible_editionless_jokers + 1] = v
        end
    end
    local tbl = {
        ability = abil,
        config = {
            center = center,
            center_key = center.key
        },
        juice_up = function(_, ...)
            return self:juice_up(...)
        end,
        start_dissolve = function(_, ...)
            if not _.silent then
                return self:start_dissolve(...)
            end
        end,
        remove = function(_, ...)
            return self:remove(...)
        end,
        flip = function(_, ...)
            return self:flip(...)
        end,
        can_use_consumeable = function(self, ...)
            return Card.can_use_consumeable(self, ...)
        end,
        calculate_joker = function(self, ...)
            return Card.calculate_joker(self, ...)
        end,
        can_calculate = function(self, ...)
            return Card.can_calculate(self, ...)
        end,
        set_cost = function(self, ...)
            Card.set_cost(self, ...)
        end,
        calculate_sticker = function(self, ...)
            Card.calculate_sticker(self, ...)
        end,
        base_cost = 1,
        extra_cost = 0,
        original_card = self,
        area = area,
        added_to_deck = added_to_deck,
        cost = self.cost,
        sell_cost = self.sell_cost,
        eligible_strength_jokers = eligible_editionless_jokers,
        eligible_editionless_jokers = eligible_editionless_jokers,
        T = self.T,
        VT = self.VT,
        CT = self.CT,
        silent = silent
    }
    for i, v in pairs(Card) do
        if type(v) == "function" and i ~= "flip_side" then
            tbl[i] = function(_, ...)
                return v(self, ...)
            end
        end
    end
    tbl.set_edition = function(s, ed, ...)
        Card.set_edition(s, ed, ...)
    end
    tbl.get_chip_h_x_mult = function(s, ...)
        local ret = SMODS.multiplicative_stacking(s.ability.h_x_mult or 1,
            (not s.ability.extra_enhancement and s.ability.perma_h_x_mult) or 0)
        return ret
    end
    tbl.get_chip_x_mult = function(s, ...)
        local ret = SMODS.multiplicative_stacking(s.ability.x_mult or 1,
            (not s.ability.extra_enhancement and s.ability.perma_x_mult) or 0)
        return ret
    end
    tbl.use_consumeable = function(self, ...)
        self.bypass_echo = true
        local ret = Card.use_consumeable(self, ...)
        self.bypass_echo = nil
    end
    return tbl
end

local guidefcardhpopup = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
	local ret_val = guidefcardhpopup(card)
	if not card.config.center or not card.config.center.prepared_card then return ret_val end
	local dummy_card = get_dummy(G.P_CENTERS[card.config.center.prepared_card], G.consumeables, card)
	local prepared_card = Card.generate_UIBox_ability_table(dummy_card)
	local target = ret_val.nodes[1].nodes[1].nodes[1].nodes[2]

	local card_type = localize('k_'..string.lower(dummy_card.ability.set))
	local card_type_colour = get_type_colour(dummy_card.config.center or dummy_card.config, dummy_card)
	local card_type_text_colour = SMODS.get_card_type_text_colour(prepared_card.card_type, dummy_card.config.center or dummy_card.config, dummy_card)
	local card_type_background = 
		(card_type_colour and darken(G.C.BLACK, 0.1)) or
		G.C.SET[prepared_card.card_type]

	local prep_badge = create_badge(card_type, card_type_colour, card_type_text_colour, 1.2)

	-- ui by sleepy
	local new_nodes = {
		n = G.UIT.R,
		nodes = {
			{
				n = G.UIT.C,
				config={align = "cm", padding = 0.07,},
				nodes = {
					target -- jonkler
				}
			},
			{
				n = G.UIT.C,
				config={align = "cm", padding = 0.07,},
				nodes = {
					name_from_rows(prepared_card.name),
					desc_from_rows(prepared_card.main),
					prep_badge
				}
			},
		}
	}
	ret_val.nodes[1].nodes[1].nodes[1].nodes[2] = new_nodes
    -- table.insert(target, #target+1, name_from_rows(prepared_card.name))
    -- table.insert(target, #target+1, desc_from_rows(prepared_card.main))
	return ret_val
end

G.FUNCS["mf_can_use_prepared"] = function(e)
	local card = e.config.ref_table
	local dummy_card = get_dummy(G.P_CENTERS[card.config.center.prepared_card], G.consumeables, card)
	if card.ability.extra.is_prepared and Card.can_use_consumeable(dummy_card) then
		e.config.colour = G.C.PURPLE
		e.config.button = "mf_use_prepared"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end
G.FUNCS["mf_use_prepared"] = function(e)
	local card = e.config.ref_table
	card.area:remove_from_highlighted(card)

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.15,
		func = function()
			SMODS.add_card {
				key = card.config.center.prepared_card,
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

	card.ability.extra.is_prepared = false
end

-- modified from entropy
-- how entropious
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local abc = G_UIDEF_use_and_sell_buttons_ref(card)
	if (card.area == G.jokers and G.jokers and card.config.center.prepared_card) and not card.debuff then
		sell = {
			n = G.UIT.C,
			config = { align = "cr" },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						one_press = true,
						button = "sell_card",
						func = "can_sell_card",
						handy_insta_action = "sell",
					},
					nodes = {
						{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
						{
							n = G.UIT.C,
							config = { align = "tm" },
							nodes = {
								{
									n = G.UIT.R,
									config = { align = "cm", maxw = 1.25 },
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_sell"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
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
												text = localize("$"),
												colour = G.C.WHITE,
												scale = 0.4,
												shadow = true,
											},
										},
										{
											n = G.UIT.T,
											config = {
												ref_table = card,
												ref_value = "sell_cost_label",
												colour = G.C.WHITE,
												scale = 0.55,
												shadow = true,
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
		nodesthing = {
			{ n = G.UIT.R, config = { align = "cl" }, nodes = {
				sell,
			} },
			{ n = G.UIT.R, config = { align = "cl" }, nodes = {
				{
					n = G.UIT.C,
					config = { align = "cr" },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "cr",
								padding = 0.1,
								r = 0.08,
								minw = 1.25,
								hover = true,
								shadow = true,
								colour = G.C.UI.BACKGROUND_INACTIVE,
								button = "mf_use_prepared",
								func = "mf_can_use_prepared",
							},
							nodes = {

								{
									n = G.UIT.R,
									config = { align = "cm" },
									nodes = {
										{
											n = G.UIT.T,
											config = { text = localize "b_use", colour = G.C.WHITE, scale = 0.4, shadow = true },
										},
									},
								},
							},
						},
					},
				}
			} }
		}

		return {
			n = G.UIT.ROOT,
			config = { padding = 0, colour = G.C.CLEAR },
			nodes = {
				{ n = G.UIT.C, config = { padding = 0, align = "cl" }, nodes = nodesthing },
			},
		}
	end
	return abc
end