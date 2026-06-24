SMODS.Joker({
	key = "farmmerge",
	name = "Joke Merge Valley",
	atlas = "mf_jokers",
	config = {},
	pos = { x = 8, y = 4 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "destroy_card", "discard", "modify_card", "perma_bonus", "position", },
	calculate = function(self, card, context)
		if context.pre_discard and context.cardarea == G.jokers then
			if #context.full_hand ~= 3 then
				return nil
			end

			local last_card = context.full_hand[3]

			local new_stats = {
				perma_bonus = 0,
				perma_mult = 0,
				perma_x_chips = 0,
				perma_x_mult = 0,

				perma_h_chips = 0,
				perma_h_mult = 0,
				perma_h_x_chips = 0,
				perma_h_x_mult = 0,

				perma_p_dollars = 0,
				perma_h_dollars = 0,
				
				perma_repetitions = 0,
				perma_score = 0,
				perma_h_score = 0,
				perma_x_score = 0,
				perma_h_x_score = 0,
				perma_blind_size = 0,
				perma_h_blind_size = 0,
				perma_x_blind_size = 0,
				perma_h_x_blind_size = 0,

				-- slib compat
				slib_perma_xlog_chips = 0,
				slib_perma_h_xlog_chips = 0,
				slib_perma_xlog_mult = 0,
				slib_perma_h_xlog_mult = 0,
				slib_perma_plus_asc = 0,
				slib_perma_h_plus_asc = 0,
				slib_perma_x_asc = 0,
				slib_perma_h_x_asc = 0,
				slib_perma_exp_asc = 0,
				slib_perma_h_exp_asc = 0,
				slib_perma_e_chips = 0,
				slib_perma_h_e_chips = 0,
				slib_perma_e_mult = 0,
				slib_perma_h_e_mult = 0,
			}

			local enhancement = nil
			local edition = nil
			local seal = nil

			for _, v in pairs(context.full_hand) do
				if v.base.value ~= last_card.base.value then
					return nil
				end

				for k, _ in pairs(new_stats) do -- the devious reverse iterator?
					new_stats[k] = new_stats[k] + (v.ability[k] or 0)
				end

				if v ~= last_card then
					new_stats.perma_bonus = new_stats.perma_bonus + v.base.nominal
				end

				if v.config.center ~= G.P_CENTERS.c_base then
					enhancement = v.config.center
				end
				if v.seal then
					seal = v.seal
				end
				if v.edition then
					edition = v.edition
				end
			end

			if enhancement and enhancement ~= last_card.config.center then
				last_card:set_ability(enhancement)
			end
			if edition and edition ~= last_card.edition then
				last_card:set_edition(edition)
			end
			if seal and seal ~= last_card.seal then
				last_card:set_seal(seal)
			end
			for k, _ in pairs(new_stats) do
				last_card.ability[k] = new_stats[k]
			end

			local destroyed_cards = {}

			for _, v in pairs(context.full_hand) do
				if v ~= last_card then
					destroyed_cards[#destroyed_cards + 1] = v
				end
			end

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					SMODS.destroy_cards ( destroyed_cards )
					return true
				end,
			}))

			return {
				message = localize("k_merged_ex"),
			}
		end
	end,
})
