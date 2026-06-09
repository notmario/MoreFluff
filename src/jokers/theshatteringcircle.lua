local is_8_or_3 = function(card)
	return (card:get_id() == 8) or (card:get_id() == 3)
end
SMODS.Joker({
	key = "theshatteringcircle",
	name = "Disintegration Loop",
	config = {
		extra = {
            rotation = 0,
			rotations = 0,
            chips = 50,
            mult = 20,
			bosses_left = 1,
		},
	},
	pos = { x = 9, y = 13 },
	atlas = "mf_jokers",
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    no_collection = true,
	attributes = { "chips", "mult", "rank", "eight", "three", },
	loc_vars = function(self, info_queue, card)
        local chips = math.floor(card.ability.extra.chips * math.abs(math.cos(card.ability.extra.rotations * math.pi * 1 / 4)))
        local mult = math.floor(card.ability.extra.mult * math.abs(math.sin(card.ability.extra.rotations * math.pi * 1 / 4)))

        local alt_key = nil
        if mult == 0 then
            alt_key = "j_mf_theshatteringcircle_chips"
        elseif chips == 0 then
            alt_key = "j_mf_theshatteringcircle_mult"
        end

        return {
            key = alt_key,
            vars = { chips, mult, card.ability.extra.bosses_left }
        }
	end,
	calculate = function(self, card, context)
		if context.after and G.GAME.chips + SMODS.calculate_round_score() > G.GAME.blind.chips and not context.repetition and not context.blueprint and G.GAME.blind.boss then	
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				delay = 0.,
        		func = function()
					G.GAME.mf_fake_score = number_format(G.GAME.chips)
					G.GAME.chips = 0
					-- G.GAME.round_resets.lost = true
					-- G.STATE = 1
					-- G.STATE_COMPLETE = false
					card.ability.extra.bosses_left = card.ability.extra.bosses_left - 1
					if
						card.ability.extra.bosses_left <= 0
					then
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.01,
							func = function()
								card:set_ability(G.P_CENTERS["j_mf_eventhorizon"])
								ease_background_colour{new_colour = HEX "282848", contrast = 1}
								if not G.GAME.blind.disabled then
									G.GAME.blind:disable()
								end
								local was_superboss = (G.GAME.blind.debuff or {}).superboss
								G.GAME.blind:set_blind(G.P_BLINDS["bl_mf_space"])
								if was_superboss then
									G.GAME.blind.debuff = G.GAME.blind.debuff or {}
									G.GAME.blind.debuff.superboss = true
								end
								G.GAME.mf_fake_score = nil
								return true
							end,
						}))
						card:juice_up()
						G.jokers:unhighlight_all()
						FLUFF.disintegration_loop_jumpscare()
						G.GAME.blind:juice_up()
						ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
						ease_discard(
							math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards) - G.GAME.current_round.discards_left
						)
						G.FUNCS.draw_from_discard_to_deck()

						-- return {
						-- 	message = localize "k_transformed_ex"
						-- }
					end
					return true
				end
			})
		end
        if (context.setting_blind or (context.pre_discard and context.cardarea == G.jokers and #context.full_hand == 5)) and not context.blueprint then
            play_sound("mf_jokerrotate")
            card.ability.extra.rotations = card.ability.extra.rotations + 1

            return {
                message = localize "k_rotated_ex"
            }
        end

		if context.individual and context.cardarea == G.play then
			if is_8_or_3(context.other_card) then
                local chips = math.floor(card.ability.extra.chips * math.abs(math.cos(card.ability.extra.rotations * math.pi * 1 / 4)))
                local mult = math.floor(card.ability.extra.mult * math.abs(math.sin(card.ability.extra.rotations * math.pi * 1 / 4)))
                return {
                    chips = chips,
                    mult = mult,
                }
            end
        end
	end,
    update = function(self, card, dt)
        if card.ability and card.ability.extra and card.ability.extra.rotations then
            local mix_fac = 0.27 ^ dt
			local target_rotation = math.pi * (card.ability.extra.rotations * 9 / 4 + 2)
            card.ability.extra.rotation = mix_fac * (card.ability.extra.rotation or 0) + (1 - mix_fac) * target_rotation
        end
    end,
})

-- rotate hook
local card_draw = Card.draw
function Card:draw(layer, ...)
	if self.config and self.config.center.key == "j_mf_theshatteringcircle" then
		self.VT.r = self.VT.r + self.ability.extra.rotation
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r + self.ability.extra.rotation
		end
	end

	card_draw(self, layer, ...)

	if self.config and self.config.center.key == "j_mf_theshatteringcircle" then
		self.VT.r = self.VT.r - self.ability.extra.rotation
		for k, v in pairs(self.children) do
			v.VT.r = v.VT.r - self.ability.extra.rotation
		end
	end
end

local ncwp = Node.collides_with_point
function Node:collides_with_point(point, ...)
	if self.config and self.config.center and self.config.center.key == "j_mf_theshatteringcircle" then
		self.VT.r = self.VT.r + self.ability.extra.rotation
	end

	local res = ncwp(self, point, ...)

	if self.config and self.config.center and self.config.center.key == "j_mf_theshatteringcircle" then
		self.VT.r = self.VT.r - self.ability.extra.rotation
	end

	return res
end

function FLUFF.disintegration_loop_jumpscare()
	love.graphics.captureScreenshot( function ( data )
		FLUFF.door_image = love.graphics.newImage( data )
		FLUFF.door_timer = 4.3
		play_sound("mf_spacejumpscare")
	end )
end

local ld = love.draw
function love.draw()
	ld()
	if FLUFF and FLUFF.door_image and FLUFF.door_timer > 0.0 then
		love.graphics.push()
		love.graphics.setShader()
		love.graphics.setColor( 1, 1, 1, 1 )
		local _, h = love.graphics.getDimensions()
		local y_scale = 1 - (1 - (FLUFF.door_timer / 4.3)) ^ 4
		love.graphics.translate(0, h * (1 - y_scale))
		love.graphics.scale(1.0, y_scale)
		love.graphics.draw(FLUFF.door_image, 0, 0)
		love.graphics.pop()
	end
end

local lu = love.update
function love.update(dt)
	lu(dt)
	if FLUFF and FLUFF.door_timer and FLUFF.door_timer > 0.0 then
		FLUFF.door_timer = FLUFF.door_timer - dt
	end
end

SMODS.Blind({
	key = "space",
	name = "The Event Horizon",

	atlas = "mf_blinds",
	pos = { x = 0, y = 16 },

	dollars = 10,
	mult = 4,

	boss = {
		event_horizon = true
	},
	boss_colour = HEX("282848"),

	no_collection = true,

	in_pool = function(self)
		return false
	end,

	disable = function(self)
		G.GAME.blind.chips = G.GAME.blind.chips / 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	end,
})