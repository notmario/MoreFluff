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