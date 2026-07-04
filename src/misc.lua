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
    if card and card.area ~= G.mf_exile then
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
	FLUFF.exile_card(card)
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

function FLUFF.cascade(cost, times_left)
    if times_left <= 0 then return nil end
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
                    if G.shop_jokers.cards[1].cost < cost or cost == 0 then
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

                            -- continue
                            FLUFF.cascade(cost, times_left - 1)
                        else
                            FLUFF.cascade(cost, times_left)
                        end
                    else
                        FLUFF.cascade(cost, times_left)
                    end
                    return true
                end,
            }))
            return true
        end,
    }))
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