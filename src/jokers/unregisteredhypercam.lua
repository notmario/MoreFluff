SMODS.Joker({
	key = "unregisteredhypercam",
	name = "Unregistered Hypercam 2",
	atlas = "mf_jokers",
	config = {
		val = 1.04,
	},
	pos = { x = 7, y = 6 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	immutable = true,
	attributes = { "hypermult", },
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.val } }
	end,
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			if FLUFF.should_talisman_key("eemult") then
				return {
					eemult = card.ability.val,
				}
			else
				return {
					message = "^^1.04 Mult",
					pre_func = function()
						mult = mod_mult(mult ^ (mult ^ 0.04))
					end,
					sound = "multhit2",
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
})

local game_drawref = Game.draw
function Game:draw()
	game_drawref(self)

	love.graphics.setColor(1, 1, 1, 1)

	if next(SMODS.find_card("j_mf_unregisteredhypercam")) then
		love.graphics.draw(G.ASSET_ATLAS["mf_watermark"].image, 0, 0)
	end
end

SMODS.ScreenShader {
	key = "hypercam_jpeg_kinda",
	path = "hypercam_jpeg_kinda.fs",
	send_vars = function(self)
		local w,h = love.graphics.getDimensions()
		return {
			wquant = 2 / w,
			hquant = 2 / h,
		}
	end,
    should_apply = function(self)
        return next(SMODS.find_card("j_mf_unregisteredhypercam"))
    end,
}
