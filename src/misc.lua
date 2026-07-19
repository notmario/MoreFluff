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

FLUFF.artists = {}

FLUFF.artists["footlongdingledong"] = { colour = HEX "7ae047", name_scale = 0.22 } -- :p
FLUFF.artists["Multi"] = { colour = HEX "cc66ff" }
FLUFF.artists["marigold"] = { colour = HEX "e8a71c" }
FLUFF.artists["LFMoth"] = { colour = HEX "ec98f2" }
FLUFF.artists["Ice"] = { colour = HEX "9aede7" }
FLUFF.artists["Incognito"] = { colour = HEX "d0d0d0" }

local mf_art_credit_thingy = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
	local ret_val = mf_art_credit_thingy(card)
	local obj = card.config.center
	local target = ret_val.nodes[1].nodes

	if not FLUFF.artist_sprite then
		FLUFF.artist_sprite = SMODS.create_sprite(0, 0, 0.5, 0.5, "mf_artist", { x = 0, y = 0 })
	end

	if obj and obj.mf_art_credit then
		local dev = FLUFF.artists[obj.mf_art_credit]
		local str = {
			n = G.UIT.R,
			config = { colour = G.C.CLEAR, align = "cm", w = 0, padding = 0.05 },
			nodes = {
				{n=G.UIT.R, config={align = "cm", minh = 0.3, r = 0.12, padding = 0.05, colour = HEX "f24f4f", emboss = 0.07}, nodes={
					{n=G.UIT.R, config={align = "cm", minh = 0.3, r = 0.1, minw = 2.5, padding = 0.04, colour = HEX "563737"}, nodes={
						{
							n = G.UIT.R,
							config = { colour = G.C.CLEAR, align = "cm", w = 0, padding = 0.08 },
							nodes = {
								{
									n = G.UIT.O,
									config = {
										object = FLUFF.artist_sprite,
									},
								},
								{
									n = G.UIT.C,
									config = { align = "cl" },
									nodes = {
										{n=G.UIT.R, config={align = "cl"}, nodes={{
											n = G.UIT.T,
											config = { text = "art by ", shadow = true, colour = G.C.UI.BACKGROUND_WHITE, scale = 0.27 },
										}}},
										{n=G.UIT.R, config={align = "cl"}, nodes={{
											n = G.UIT.O,
											config = {
												object = DynaText({
													string = obj.mf_art_credit,
													colours = { dev and dev.colour or G.C.UI.BACKGROUND_WHITE },
													scale = dev and dev.name_scale or 0.27,
													silent = true,
													shadow = true,
												}),
											},
										}}},
									}
								},
							}
						},
					}},
				}}
			}
		}
		if str then
			table.insert(target, str)
		end
	end
	return ret_val
end

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
	local in_pack = card.area == G.pack_cards
    ref(e, mute, nosave)
	G.E_MANAGER:add_event(Event{
		trigger = "after",
		delay = 0.,
		blocking = false,
		blockable = true,
		func = function()
			if (card.config.center.set == "Rotarot" or card.config.center.set == "Colour") and not card.config.center.hidden then
				if not (card.config.center.set == "Colour" and in_pack) then
 					G.GAME.last_rot_tarot_colour = card.config.center.key
				end
			end
			return true
		end
	})
end

-- -- title screen ace
-- SMODS.Shader {
--     key = "titlescreenace",
--     path = "titlescreenace.fs",
-- }

-- SMODS.Edition {
--     key = "titlescreenace",
--     shader = "titlescreenace",
-- 	atlas = "mf_jokers",
-- 	pos = { x = 9, y = 4 },
-- 	-- soul_pos = { x = 9, y = 5 },
-- 	in_pool = function (...) return false end,
-- 	no_collection = true,
-- 	loc_vars = function(self, info_queue, card)
--         return { }
-- 	end,
--     calculate = function(self, card, context)
--     end
-- }

-- FLUFF.menu_cards = function()
-- 	return {
-- 		func = function()
-- 			if #G.title_top.cards < 1 then return nil end
-- 			G.title_top.cards[1]:set_edition("e_mf_titlescreenace", true)
-- 		end
-- 	}
-- end

-- exile zone

FLUFF.custom_card_areas = function(game)
	game.mf_exile = CardArea(
		game.deck.T.x, game.deck.T.y - game.deck.T.h * 2.1,
        game.deck.T.w, game.deck.T.h * 2.,
        { card_limit = 9999, type = 'joker', mf_exile = true, highlight_limit = 0, no_card_count = true, }
	)
	game.mf_exile.ARGS = game.mf_exile.ARGS or {}
	game.mf_exile.ARGS.invisible_area_types = { joker = 1 }
end

local ca_rfh = CardArea.remove_from_highlighted
function CardArea:remove_from_highlighted(card, force)
    if card then
        ca_rfh(self, card, force)
    end
end

local ca_ath = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if card and not (card.area == G.mf_exile and not card.ability.mf_purchase_from_exile) then
        ca_ath(self, card, silent)
    end
end

local ca_align = CardArea.align_cards

function CardArea:align_cards()
    ca_align(self)
    if self.config.type == 'joker' and self.config.mf_exile then
        for k, card in ipairs(self.cards) do
            if not card.states.drag.is then 
				card.T.r = 0.
                local max_cards = math.max(#self.cards, 1)
                card.T.y = self.T.y + (self.T.h-G.CARD_H)*((k-1)/math.max(max_cards-1, 1) - 0.5*(#self.cards-max_cards)/math.max(max_cards-1, 1)) + 0.5*(G.CARD_H - card.T.h)
                if #self.cards > 2 or (#self.cards > 1 and self == G.consumeables) or (#self.cards > 1 and self.config.spread) then
                    card.T.y = self.T.y + (self.T.h-G.CARD_H)*((k-1)/(#self.cards-1)) + 0.5*(G.CARD_H - card.T.h)
                elseif #self.cards > 1 and self ~= G.consumeables then
                    card.T.y = self.T.y + (self.T.h-G.CARD_H)*((k - 0.5)/(#self.cards)) + 0.5*(G.CARD_H - card.T.h)
                else
                    card.T.y = self.T.y + self.T.h/2 - G.CARD_H/2 + 0.5*(G.CARD_H - card.T.h)
                end
				local mid_ind_thingy = (k-max_cards / 2 - 0.5) / 2
				if #self.cards >= 8 then
					mid_ind_thingy = math.fmod(k-1, 540 / 137) - (270 / 137) + 0.5
				end
                card.T.x = self.T.x + self.T.w/2 - card.T.w/2 + G.CARD_W * mid_ind_thingy / 4.2
            end
        end
    end
end


-- modified from entropy
-- how entropious
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local abc = G_UIDEF_use_and_sell_buttons_ref(card)
	if (card.area == G.mf_exile and G.jokers and card.ability.mf_purchase_from_exile) and not card.debuff then
		buy = {
			n = G.UIT.C,
			config = { align = "cr" },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "tm",
						padding = 0.1,
						r = 0.08,
						hover = true,
						shadow = true,
						colour = G.C.ORANGE,
						one_press = true,
						button = "buy_from_exile",
						func = "can_buy_from_exile",
					},
					nodes = {
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
												text = localize('b_buy'),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.5,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = { align = "cm", maxw = 1.25 },
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize('$'),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
										{
											n = G.UIT.T,
											config = {
												text = ''..card.cost,
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
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
				buy,
			} },
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

G.FUNCS.can_buy_from_exile = function(e)
    if (e.config.ref_table.cost > G.GAME.dollars - G.GAME.bankrupt_at) and (e.config.ref_table.cost > 0) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.ORANGE
        e.config.button = 'buy_from_exile'
    end
end

G.FUNCS.buy_from_exile = function(e)
    local c1 = e.config.ref_table
    if c1 and c1:is(Card) then
		if e.config.id ~= 'buy_and_use' then
			if not G.FUNCS.check_for_buy_space(c1) then
				e.disable_button = nil
				return false
			end
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
			c1.from_area = c1.area
			c1.area:remove_card(c1)
			c1.T.scale = c1.T.scale / FLUFF.exile_scale
			c1:add_to_deck()
			if c1.children.price then c1.children.price:remove() end
			c1.children.price = nil
			if c1.children.buy_button then c1.children.buy_button:remove() end
			c1.children.buy_button = nil
			remove_nils(c1.children)
			if c1.ability.set == 'Default' or c1.ability.set == 'Enhanced' then
				inc_career_stat('c_playing_cards_bought', 1)
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				G.deck:emplace(c1)
				c1.playing_card = G.playing_card
				playing_card_joker_effects({c1})
				table.insert(G.playing_cards, c1)
			elseif e.config.id ~= 'buy_and_use' then
				if c1.ability.consumeable then
				G.consumeables:emplace(c1)
				else
				G.jokers:emplace(c1)
				end
				G.E_MANAGER:add_event(Event({func = function()
					local eval, post = eval_card(c1, {buying_card = true, buying_self = true, card = c1}) -- buying_card left for back compat, buying_self recommended to use
					SMODS.trigger_effects({eval, post}, c1)
					return true
					end}))
			end
			--Tallies for unlocks
			G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
			if c1.ability.consumeable then
				if c1.config.center.set == 'Planet' then
				inc_career_stat('c_planets_bought', 1)
				elseif c1.config.center.set == 'Tarot' then
				inc_career_stat('c_tarots_bought', 1)
				end
			elseif c1.ability.set == 'Joker' then
				G.GAME.current_round.jokers_purchased = G.GAME.current_round.jokers_purchased + 1
			end

			SMODS.calculate_context({buying_card = true, card = c1})

			if G.GAME.modifiers.inflation then 
				G.GAME.inflation = G.GAME.inflation + 1
				G.E_MANAGER:add_event(Event({func = function()
				for k, v in pairs(G.I.CARD) do
					if v.set_cost then v:set_cost() end
				end
				return true end }))
			end

			play_sound('card1')
			inc_career_stat('c_shop_dollars_spent', c1.cost)
			if c1.cost ~= 0 then
				ease_dollars(-c1.cost)
			end
			G.CONTROLLER:save_cardarea_focus('jokers')
			G.CONTROLLER:recall_cardarea_focus('jokers')

			if e.config.id == 'buy_and_use' then 
				G.FUNCS.use_card(e, true)
			end
			return true
			end
		}))
    end
end

-- from aquilarri
function FLUFF.get_card_pixel_pos(card, real)
    return 
        (G.ROOM.T.x * (real or 1) + card.T.x + card.T.w * 0.5) * (G.TILESIZE * G.TILESCALE),
        (G.ROOM.T.y * (real or 1) + card.T.y + card.T.h * 0.5) * (G.TILESIZE * G.TILESCALE)
end

local exile_alpha = 0

local lu = love.update
function love.update(dt)
	lu(dt)

	if G.mf_exile then
		if #G.mf_exile.cards >= 1 then
			exile_alpha = math.min(exile_alpha + 3 * dt, 1)
		else
			exile_alpha = math.max(exile_alpha - 3 * dt, 0)
		end
	end
end

local ca_draw = CardArea.draw
function CardArea:draw(...)
    if not self.states.visible then return end

	if self == G.mf_exile then
		love.graphics.push()

		local x, y = FLUFF.get_card_pixel_pos(G.mf_exile, 0)
		local w,h = love.graphics.getDimensions()
		love.graphics.translate(x, y)

		love.graphics.scale( h / 1080, h / 1080 )

		love.graphics.setColor( 0.082, 0.082, 0.267, 0.1 * exile_alpha )

		for i = 1, 25 do
			love.graphics.push()
			love.graphics.scale( 0.5 - i * 0.02, 0.5 - i * 0.02 )
			love.graphics.rotate((G.TIMERS.REAL + i + 1000) / (11 - i / 3))
			love.graphics.translate(-256., -256.)

			love.graphics.draw(G.ASSET_ATLAS["mf_exile_spiral"].image, 0., 0.)

			love.graphics.pop()
		end

		love.graphics.setColor( 0.106, 0.149, 0.161, 0.03 * exile_alpha )
		for i = 1, 25 do
			love.graphics.push()
			love.graphics.scale( 0.5 - i * 0.02, 0.5 - i * 0.02 )
			love.graphics.rotate((G.TIMERS.REAL + i + 1000) / (16 - i / 3))
			love.graphics.translate(-256., -256.)

			love.graphics.draw(G.ASSET_ATLAS["mf_exile_spiral"].image, 0., 0.)

			love.graphics.pop()
		end
		
		love.graphics.pop()
	end

	ca_draw(self, ...)
end

FLUFF.exile_scale = 0.4

FLUFF.draw_to_exile = function(temp, percent, delay, func)
	percent = percent or 0.5
	delay = delay or 0.1
	if temp == true then temp = "mf_unexile_eor" end
	if temp == "ante" then temp = "mf_unexile_eoa" end
	G.E_MANAGER:add_event(Event({
		trigger = 'before',
		delay = delay,
		func = function()
			local has_cards = {}
			if temp then
				for _, card in pairs(G.mf_exile.cards) do
					has_cards[card.sort_id] = true
				end
			end
			local bef_length = #G.mf_exile.cards
			G.mf_exile:draw_card_from(G.deck, nil, nil)
			if #G.mf_exile.cards > bef_length then
				for i = 1, #G.mf_exile.cards do
					local real_ind = #G.mf_exile.cards - i + 1
					local card = G.mf_exile.cards[real_ind]
					if not has_cards[card.sort_id] then
						-- card.T.w = card.T.w * FLUFF.exile_scale
						-- card.T.h = card.T.h * FLUFF.exile_scale
						card.T.scale = card.T.scale * FLUFF.exile_scale
						if temp then
							card.ability[temp] = true
						end
						if func then func(card) end
						break
					end
				end
				play_sound('card1', 0.55 + percent*0.2, 0.6)
			end
			return true
		end
	}))
end

FLUFF.exile_card = function(card, percent, temp, func)
	if card.mf_being_exiled then return nil end
	card.mf_being_exiled = true
	if temp == true then temp = "mf_unexile_eor" end
	if temp == "ante" then temp = "mf_unexile_eoa" end
	G.E_MANAGER:add_event(Event({
		trigger = 'before',
		delay = 0.1,
		func = function()
			if card.area then
				card.area:remove_card(card)
			end
			if card.added_to_deck then
				card:remove_from_deck(false)
			end
			G.mf_exile:emplace(card)
			-- card.T.w = card.T.w * FLUFF.exile_scale
			-- card.T.h = card.T.h * FLUFF.exile_scale
			card.T.scale = card.T.scale * FLUFF.exile_scale
			card.mf_being_exiled = false
			if temp then
				card.ability[temp] = true
			end
			if func then func(card) end
			if percent then
				play_sound('card1', 0.55 + percent*0.2, 0.6)
			end
			return true
		end
	}))
end

FLUFF.suspend_card = function(card, rounds)
	card.suspending = true
	FLUFF.exile_card(card, nil, false, function (_card) _card.suspending = false end )
	card.ability.mf_suspended = {
		rounds = rounds,
	}
end

FLUFF.create_and_suspend_card = function(parameters, rounds)
	local card = SMODS.add_card(parameters)
	FLUFF.suspend_card(card, rounds)
end

-- lemniscate   ty alexi
local mju = Moveable.juice_up
function Moveable:juice_up(amount, rot_amt, ...)
    local ret = mju(self, amount, rot_amt, ...)

    if G.SETTINGS.reduced_motion then return end
    if self.area and self.area == G.mf_exile then
        self.VT.scale = self.VT.scale * self.T.scale
    end
    return ret
end

local game_start_run = Game.start_run
function Game:start_run(args)
    game_start_run(self, args)
    if G.mf_exile then
        for _, card in ipairs(G.mf_exile.cards) do
			card.T.scale = card.T.scale * FLUFF.exile_scale
        end
    end
end
function FLUFF.can_cascade_obtain(card)
    -- skip these for now
	-- because it no space!s and thats annoying
    if card.ability.set == 'elle_Resident' then
        return #G.elle_resident_area.cards < 1
    end

    -- im sure theres some other unc mod that has another card area
    -- reverie goes to consumeables first
    -- so uhh
    -- janky ass patch target ??

    return true
end

function FLUFF.cascade_obtain(card)

    if card.ability.consumeable then
        G.consumeables:emplace(card)
    else
        G.jokers:emplace(card)
    end
end

local gfcfbs = G.FUNCS.check_for_buy_space 
G.FUNCS.check_for_buy_space = function(card)
	if FLUFF.fuck_you_i_can_buy_this_shit then return true end
	return gfcfbs(card)
end

FLUFF.cascade_acceleration = 1

FLUFF.cascade_queue = {}
function FLUFF.cascade(source, cost, times_left, funcs)
	if not (G.shop_jokers and G.shop_jokers.cards) then
		if source then
			card_eval_status_text(source, "extra", nil, nil, nil, {
				message = localize("k_no_shop"),
				colour = G.C.RED,
				card = source,
			})
		end
		return nil
	end
	local actually_cascade = #FLUFF.cascade_queue == 0
	for _ = 1, (times_left or 1) do
		FLUFF.cascade_queue[#FLUFF.cascade_queue + 1] = { source = source, cost = cost, funcs = (funcs or {}), times_triggered = 0 }
	end
	if actually_cascade then
		FLUFF.cascade_real()
	end
end

function FLUFF.cascade_real(times_triggered)
	if #FLUFF.cascade_queue == 0 then
		FLUFF.cascade_acceleration = 1
		return nil
	end
	times_triggered = times_triggered or 0
	FLUFF.cascade_acceleration = 1.04 ^ times_triggered
	G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.15,
        func = function()
            G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls + 1, 0)
            calculate_reroll_cost(true)
            G.FUNCS.reroll_shop()
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
					local next_cascade = FLUFF.cascade_queue[1]
					if next_cascade.source then next_cascade.source:juice_up(0.3, 0.4) end
					local cost = next_cascade.cost
					next_cascade.times_triggered = next_cascade.times_triggered + 1
                    if G.shop_jokers.cards[1].cost < cost or cost == 0 and (not next_cascade.funcs.filter or next_cascade.funcs.filter(G.shop_jokers.cards[1])) then
                        local c1 = G.shop_jokers.cards[1]

                        local doit = FLUFF.can_cascade_obtain(c1)
                        if doit then
							c1.ability.couponed = true
							c1:set_cost()

							FLUFF.fuck_you_i_can_buy_this_shit = true
							G.FUNCS.buy_from_shop {
								config = { ref_table = c1 }
							}
							FLUFF.fuck_you_i_can_buy_this_shit = nil

							-- remove start of cascade queue
							table.remove(FLUFF.cascade_queue, 1)
							times_triggered = 0
                        end
                    elseif next_cascade.times_triggered >= 100 then
						-- failed to find
						table.remove(FLUFF.cascade_queue, 1)
						if next_cascade.source then
							card_eval_status_text(next_cascade.source, "extra", nil, nil, nil, {
								message = localize("k_failed_to_find"),
								colour = G.C.RED,
								card = next_cascade.source,
							})
						end
						times_triggered = 0
					end
					FLUFF.cascade_real(times_triggered + 1)
                    return true
                end,
            }))
            return true
        end,
    }))
end

local lu = love.update
function love.update(dt, ...)
	local acc = 1
	if FLUFF and FLUFF.cascade_acceleration then
		acc = FLUFF.cascade_acceleration
	end
	lu(dt * acc, ...)
end

local cc = copy_card
function copy_card(...)
	local copy = cc(...)

	if copy.ability.mf_exile_until_id then
		copy.ability.mf_exile_until_id = math.random(1000000000000)
	end

	return copy
end

local cas = CardArea.shuffle
function CardArea:shuffle(...)
    if self == G.deck and G.deck then
        SMODS.calculate_context { mf_deck_shuffled = true }
    end

    cas(self, ...)
end

FLUFF.shuffle_when_pack_opened = {
	"j_mf_purple_economy_joker"
}

FLUFF.should_shuffle_on_pack = function()
	for _, card in pairs(FLUFF.shuffle_when_pack_opened) do
		if next(SMODS.find_card(card)) then return true end
	end
	return false
end
-- technically bft shit but i think it might get put into slib anyways ?? so who knows
-- it appears in book of shadows too so :shrug:
function FLUFF.parse_string(text)
    for i, v in pairs(text) do
        if type(v) == "table" then
            FLUFF.parse_string(v)
        else
            text[i] = loc_parse_string(v)
        end
    end
end

function FLUFF.create_vtext(vtext, AUT, nodes, vars, lines, num)
    local localize_args = {
        AUT = AUT,
        nodes = nodes,

        vars = vars
    }
    -- taken from localize; adds the multibox
    localize_args.AUT.multi_box = localize_args.AUT.multi_box or {}
    local i = num + 1 -- fucking janky ass method
    G.AUT = AUT
    for j, line in ipairs(lines) do
        local final_line = SMODS.localize_box(line, localize_args)
        if i == 1 or next(AUT.info) then
            nodes[#nodes+1] = final_line -- Sends main box to AUT.main
            if not next(AUT.info) then nodes.main_box_flag = true end
        elseif not next(AUT.info) then 
            nodes.main_box_flag = true
            AUT.multi_box[i-1] = AUT.multi_box[i-1] or {}
            AUT.multi_box[i-1][#AUT.multi_box[i-1]+1] = final_line
        end
        if not next(AUT.info) and vars.box_colours then AUT.box_colours[i] = vars.box_colours and vars.box_colours[i] or G.C.UI.BACKGROUND_WHITE end
    end
end

function FLUFF.generate_ui_multiboxes(args2)
    return function(center, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        -- if not full_UI_table.box_colours then return end
        local num = full_UI_table.multi_box and #full_UI_table.multi_box + 1 or 1
        for i, args in pairs(args2) do
            if not args.func or args:func(card) then
                local keys = type(args.key) == "table" and args.key or {args.key}
                for _, k in pairs(keys) do
                    local vars = args.loc_vars and (args:loc_vars({}, card) or {}).vars or {}
                    local lines = SMODS.shallow_copy(G.localization.misc.v_dictionary_parsed[k] or {})
                    local vtext = localize{ type = "variable", key = k, vars = vars } -- the var doesn't matter here
                    FLUFF.create_vtext(vtext, full_UI_table, desc_nodes, vars, lines, num)
                    if args.seperate_boxes then
                        num = num + 1
                    end
                end
                local texts = type(args.localized_text) == "table" and args.localized_text or {args.localized_text}
                for _, k in pairs(texts) do
                    local vars = args.loc_vars and (args:loc_vars({}, card) or {}).vars or {}
                    local vtext = type(k) == "string" and {k} or k or {}
                    FLUFF.parse_string(vtext)
                    FLUFF.create_vtext(nil, full_UI_table, desc_nodes, vars, vtext, num)
                    if args.seperate_boxes then
                        num = num + 1
                    end
                end
                if not args.seperate_boxes then
                    num = num + 1
                end
            end
        end
    end
end

function FLUFF.add_extra_multiboxes(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability)
	-- hookable and shii
end

function FLUFF.calculate_extra_effects(card, context, jokers, triggered)
	-- hookable and shii 2
	return jokers, triggered
end

local card_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context, ...)
	local jokers, triggered = card_calculate_joker(self, context, ...)
	return FLUFF.calculate_extra_effects(self, context, jokers, triggered)
end

function FLUFF.poisonous(other_ret, poisonous_value)
	-- local new_poisons = {}
	-- local ret = other_ret
	-- while ret do
	-- 	new_poisons[#new_poisons + 1] = {
	-- 		score = G.GAME.blind.chips / 100 * poisonous_value,
	-- 		colour = darken(G.C.GREEN, 0.2),
	-- 		sound = "mf_poison"..math.random(2),
	-- 	}
	-- 	ret = ret.extra
	-- end
	-- return SMODS.merge_effects(new_poisons)
	return {
		score = G.GAME.blind.chips / 100 * poisonous_value,
		colour = darken(G.C.GREEN, 0.2),
		sound = "mf_poison"..math.random(2),
	}
end