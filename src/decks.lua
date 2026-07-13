SMODS.Back({
	key = "oldfluff",

	atlas = "mf_enhancers",
	pos = { x = 4, y = 0 },

	unlocked = true,
	discovered = true,

	apply = function(self, back)
		G.GAME.modifiers.mf_buffoon_pack_tax = (G.GAME.modifiers.mf_buffoon_pack_tax or 0) + 2
		G.GAME.modifiers.mf_bonus_scrapped = true
	end,

	loc_vars = function(self, info_queue, card)
		return {
			vars = { colours = { HEX("000000") } },
		}
	end,
})

local csc = Card.set_cost

function Card:set_cost(...)
	if G.GAME.modifiers.mf_buffoon_pack_tax and self.ability.set == "Booster" and self.config.center.kind == "Buffoon" then
		G.GAME.inflation = (G.GAME.inflation or 0) + G.GAME.modifiers.mf_buffoon_pack_tax
	end
	csc(self, ...)
	if G.GAME.modifiers.mf_buffoon_pack_tax and self.ability.set == "Booster" and self.config.center.kind == "Buffoon" then
		G.GAME.inflation = (G.GAME.inflation or 0) - G.GAME.modifiers.mf_buffoon_pack_tax
	end
end

SMODS.Back {
	key = "philosophical",
	config = { jokers = { "j_mf_philosophical", "j_mf_philosophical", "j_mf_philosophical", "j_mf_philosophical", "j_mf_philosophical" } },
	pos = { x = 1, y = 0 },
	atlas = "mf_enhancers",
	unlocked = true,
	discovered = true,
}

SMODS.Back {
    name = "Rainbow Deck",
    key = "rainbow",
    config = { voucher = 'v_mf_paintroller', consumables = {'c_mf_white'} },
    pos = { x = 2, y = 0 },
    atlas = "mf_enhancers",
    unlocked = true,
	discovered = true,
}

SMODS.Back {
    name = "Spellchaser's Deck",
    key = "spellchaser",
    config = { },
    pos = { x = 4, y = 2 },
    atlas = "mf_enhancers",
    unlocked = true,
	discovered = true,

	apply = function(self, back)
		G.GAME.modifiers.no_middle_changes = true
		G.E_MANAGER:add_event(Event({
			func = function()
				local blueprint = SMODS.add_card {
					key = "j_blueprint",
					no_edition = true,
				}
				FLUFF.exile_card(blueprint, nil, nil)
				blueprint.T.x = 49
				blueprint.VT.x = 49
				blueprint.T.y = 7
				blueprint.VT.y = 7
				blueprint.base_cost = 45
				blueprint:set_cost()
				blueprint.ability.mf_purchase_from_exile = true
				blueprint.ability.spellchase_reset_cost_lol = true
				return true
			end
		}))
	end,
	calculate = function(self, back, context)
		if context.buying_card and context.card.ability.spellchase_reset_cost_lol then
			G.E_MANAGER:add_event(Event({
				func = function()
					context.card.base_cost = G.P_CENTERS["j_blueprint"].cost
					context.card:set_cost()
					context.card.ability.spellchase_reset_cost_lol = nil
					return true
				end
			}))
		end
	end
}

local card_set_base = Card.set_base
function Card:set_base(card, initial, manual_sprites, ...)
	if not initial and G.GAME.modifiers and G.GAME.modifiers.no_middle_changes and not G.VIEWING_DECK then
		SMODS.calculate_effect(
			{ message = localize("k_prevented"), colour = G.C.RED },
			self
		)
		return nil
	end
	card_set_base(self, card, initial, manual_sprites, ...)
end