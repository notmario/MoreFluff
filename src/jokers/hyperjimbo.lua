SMODS.Joker({
	key = "hyperjimbo",
	name = "Hyperjimbo",
	atlas = "mf_hyperjimbo",
	config = {
		val = 1.04,
	},
	pos = { x = 0, y = 0 },
	display_size = { w = 95, h = 95 },
	-- pixel_size = { w = 95, h = 95 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = true, -- pretty important
	attributes = { "hyperchips", },
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.val } }
	end,
	calculate = function(self, card, context)
		if context.initial_scoring_step and #G.play.cards == 4 then
			if FLUFF.should_talisman_key("eechips") then
				return {
					eechips = card.ability.val,
				}
			else
				return {
					pre_func = function()
						hand_chips = mod_chips(hand_chips ^ (hand_chips ^ 0.04))
					end,
					message = "^^1.04 Chips",
					sound = "multhit2",
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
})

mf_hyperjimbo_dt = 0

local game_updateref = Game.update
function Game:update(dt)
	game_updateref(self, dt)

	mf_hyperjimbo_dt = mf_hyperjimbo_dt + dt
	if G.P_CENTERS and G.P_CENTERS.j_mf_hyperjimbo and mf_hyperjimbo_dt > 0.07 then
		mf_hyperjimbo_dt = mf_hyperjimbo_dt - 0.07
		local jimballobj = G.P_CENTERS.j_mf_hyperjimbo
		if jimballobj.pos.x == 5 and jimballobj.pos.y == 9 then
			jimballobj.pos.x = 0
			jimballobj.pos.y = 0
		elseif jimballobj.pos.x < 5 then
			jimballobj.pos.x = jimballobj.pos.x + 1
		elseif jimballobj.pos.y < 9 then
			jimballobj.pos.x = 0
			jimballobj.pos.y = jimballobj.pos.y + 1
		end
	end
end
