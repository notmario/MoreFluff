SMODS.Joker({
	key = "lessfluff",
	name = "Less Fluff",
	atlas = "mf_jokers",
	config = {
		extra = {
			x_mult = 1,
			x_mult_per = 0.2,
		},
	},
	pos = { x = 9, y = 7 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	attributes = { "xmult", "scaling", "destroy_card", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_mult, center.ability.extra.x_mult_per },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra.x_mult,
			}
		end
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
			local safe_jokers = {
				"j_joker",
				"j_greedy_joker",
				"j_lusty_joker",
				"j_wrathful_joker",
				"j_gluttenous_joker",
				"j_jolly",
				"j_zany",
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
				"j_mf_lessfluff",
			}

			local gained_xmult_times = 0

			for _, other_jkr in pairs(G.jokers.cards) do
				if other_jkr.getting_sliced then
					goto continue
				end

				for _, key in pairs(safe_jokers) do
					if key == other_jkr.config.center.key then
						goto continue
					end
				end

				gained_xmult_times = gained_xmult_times + 1
				other_jkr.getting_sliced = true
				G.E_MANAGER:add_event(Event({
					func = function()
						other_jkr:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))

				::continue::
			end

			if gained_xmult_times > 0 then
				-- card.ability.extra.x_mult = card.ability.extra.x_mult + gained_xmult
				for i = 1, gained_xmult_times do
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "x_mult",
						scalar_value = "x_mult_per",
					})
				end
				play_sound("slice1", 0.96 + math.random() * 0.08)
				return {
					message = localize({ type = "variable", key = "x_mult", vars = { card.ability.extra.x_mult } }),
					colour = G.C.RED,
				}
			end
		end
	end,
})
