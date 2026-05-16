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