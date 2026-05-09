-- prepared

function FLUFF.get_prepared_card(card)
	if not card.config.center.prepared_card then return "c_death" end
	if type(card.config.center.prepared_card) == "function" then
		return card.config.center.prepared_card(card)
	end
	return card.config.center.prepared_card
end

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
	local dummy_card = get_dummy(G.P_CENTERS[FLUFF.get_prepared_card(card)], G.consumeables, card)

	FLUFF.force_no_info_queue = true
	local prepared_card = Card.generate_UIBox_ability_table(dummy_card)
	FLUFF.force_no_info_queue = nil

	local card_type = localize('k_'..string.lower(dummy_card.ability.set))
	if card.config.center.force_prep_card_type then
		card_type = localize('k_'..string.lower(card.config.center.force_prep_card_type))
	end
	local card_type_colour = get_type_colour(dummy_card.config.center or dummy_card.config, dummy_card)
	local card_type_text_colour = SMODS.get_card_type_text_colour(prepared_card.card_type, dummy_card.config.center or dummy_card.config, dummy_card)
	if card.config.center.force_prep_card_type then
		card_type_colour = G.C.SECONDARY_SET[card.config.center.force_prep_card_type]
	end
	local card_type_background = 
		(card_type_colour and darken(G.C.BLACK, 0.1)) or
		G.C.SET[prepared_card.card_type]

	local prep_badge = create_badge(card_type, card_type_colour, card_type_text_colour, 1.2)

	local targets = {}
	local last_node = nil
	for i, node in ipairs(ret_val.nodes[1].nodes[1].nodes[1].nodes) do
		if i == #ret_val.nodes[1].nodes[1].nodes[1].nodes then
			last_node = node
		elseif i > 1 then
			targets[#targets+1] = node
		end
	end
	-- ret_val.nodes[1].nodes[1].nodes[1].nodes[2]

	-- ui by sleepy
	local new_nodes = {
		n = G.UIT.R,
		nodes = {
			{
				n = G.UIT.C,
				config={align = "cm", padding = 0.07, },
				nodes = targets
			},
			{
				n = G.UIT.C,
				config={align = "cm", padding = 0.07, emboss = 0.05, r = 0.1, colour = darken(card.ability.extra.is_prepared and card_type_colour or G.C.BLACK, card.ability.extra.is_prepared and 0.3 or 0.),},
				nodes = {
					-- {
					-- 	n = G.UIT.R,
					-- 	config={align = "cm",},
					-- 	nodes = {{
					-- 		n = G.UIT.T,
					-- 		config = {
					-- 			text = "Prepared:",
					-- 			colour = G.C.UI.TEXT_LIGHT,
					-- 			minw = 1,
					-- 			minh = 0.1,
					-- 			scale = 0.4,
					-- 			shadow = true,
					-- 			filler = true,
					-- 		},
					-- 	},}
					-- },
					name_from_rows(prepared_card.name),
					desc_from_rows(prepared_card.main),
					prep_badge,
					{
						n = G.UIT.R,
						config={align = "cm",},
						nodes = {{
							n = G.UIT.T,
							config = {
								text = localize(card.ability.extra.is_prepared and "k_prepared" or "k_not_prepared"),
								colour = G.C.UI.TEXT_LIGHT,
								minw = 1,
								minh = 0.1,
								scale = 0.3,
								shadow = true,
								filler = true,
							},
						},}
					},
				}
			},
		}
	}
	ret_val.nodes[1].nodes[1].nodes[1].nodes[2] = new_nodes
	local len = #ret_val.nodes[1].nodes[1].nodes[1].nodes
	for i = 3,len do
		ret_val.nodes[1].nodes[1].nodes[1].nodes[i] = nil
	end
	ret_val.nodes[1].nodes[1].nodes[1].nodes[3] = last_node
    -- table.insert(target, #target+1, name_from_rows(prepared_card.name))
    -- table.insert(target, #target+1, desc_from_rows(prepared_card.main))
    
	return ret_val
end

G.FUNCS["mf_can_use_prepared"] = function(e)
	local card = e.config.ref_table
	local dummy_card = get_dummy(G.P_CENTERS[FLUFF.get_prepared_card(card)], nil, card)
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
				key = FLUFF.get_prepared_card(card),
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

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.15,
		func = function()
			SMODS.calculate_context { mf_used_prepared = true, card = card }
			return true
		end,
	}))
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