SMODS.Joker({
	key = "halt",
	name = "Disintegration Loop",
	config = {
		extra = {
			power_cards = 3,
			bosses_left = 1,
		},
	},
	pos = { x = 8, y = 13 },
	atlas = "mf_jokers",
	rarity = 3,
	cost = 10,
    in_pool = function(self, args)
        return false
    end,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "enhancements" },
    no_collection = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_power
		return {
			vars = { card.ability.extra.power_cards, card.ability.extra.bosses_left },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra.bosses_left = card.ability.extra.bosses_left - 1
			if
				card.ability.extra.bosses_left <= 0
			then
                card:set_ability(G.P_CENTERS["j_mf_theshatteringcircle"])
                card:juice_up()
                G.jokers:unhighlight_all()

                return {
                    message = localize "k_transformed_ex"
                }
			end
			return {
				message = ""..card.ability.extra.bosses_left
			}
		end
	end,
})

SMODS.DrawStep {
    key = 'mf_power_entry',
    order = -9,
    func = function(self, layer)
        if (self.config.center.discovered or self.bypass_discovery_center) and _G.halt_timer and _G.halt_timer > 0 then
            if self.config.center.key ~= "j_mf_halt" then return nil end

            love.graphics.push()
            love.graphics.setColor( 1, 1, 0.118, _G.halt_timer / 3.5 )
            love.graphics.setShader()
            local scale = G.TILESCALE*G.TILESIZE*G.CANV_SCALE
            local x_pos = self.children.center.VT.x * scale + scale / self.children.center.T.scale
            local size_x = G.TILESCALE*G.TILESIZE * 4
        
            love.graphics.rectangle(
                "fill", x_pos - size_x / 2, -500, size_x, 1500
            )

            love.graphics.pop()
			self.children.center:set_sprite_pos({x = 1, y = 14})
            self.children.center:draw_shader('dissolve')
			self.children.center:set_sprite_pos({x = 8, y = 13})
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

local lu = love.update
function love.update(dt)
	lu(dt)
	if _G.halt_timer then
		_G.halt_timer = _G.halt_timer - dt
	end
end
SMODS.Enhancement({
	key = "power",
	atlas = "mf_enhancers",
	pos = { x = 3, y = 2 },
	config = {
		Xmult = 2,
	},
	replace_base_card = true,
	no_rank = true,
    any_suit = true,
	always_scores = true,
    no_collection = true,
    in_pool = function(self, args)
        return false
    end,
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card and card.ability.Xmult or self.config.Xmult,
		} }
	end,
})

local dc = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only, ...)
	local did_reshuffle = false
	if to == G.discard and card and SMODS.has_enhancement(card, "m_mf_power") then
		to = G.deck
		did_reshuffle = true
	end
	dc(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only, ...)
	if did_reshuffle then
		G.deck:shuffle()
	end
end