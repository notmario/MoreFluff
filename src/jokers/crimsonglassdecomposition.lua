SMODS.Joker({
	key = "crimsonglassdecomposition",
	name = "Disintegration Loop",
	config = {
		extra = {
			fakeout_sprite = 0,
		},
	},
	pos = { x = 7, y = 13 },
	atlas = "mf_jokers",
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { },
	loc_vars = function(self, info_queue, card)
		if card.area == G.jokers or card.ability.extra.fakeout_sprite == 5 then

		else
        	return { key = "j_mf_fraud_fakeout_"..card.ability.extra.fakeout_sprite }
		end
	end,
	calculate = function(self, card, context)
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.fakeout_sprite = math.random(4)
	end,
    draw = function(self, card, layer)
        if (card.config.center.discovered or card.bypass_discovery_center) then
			local x_pos = card.ability.extra.fakeout_sprite + 2
			if card.area == G.jokers then x_pos = 7 end
			card.children.center:set_sprite_pos({x = x_pos, y = 13})
        end
    end,
})
