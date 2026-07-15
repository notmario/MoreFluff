local function reset_choices(card, rarities, forced_choice)
    local fuck = not G.playing_cards
    if fuck then G.playing_cards = {} end
    card.ability.extra.choices = {}
    local temp_map = {}

    card.ability.extra.choices[1] = forced_choice
    temp_map[forced_choice] = true

    for i = 2,5 do
        local obj = SMODS.poll_object {
            type = "Joker",
            rarities = { rarities[i] },
            filter = function ( pool )
                local new_pool = {}
                for k, v in pairs(pool) do
                    if not temp_map[v.key] then
                        table.insert(new_pool, v)
                    end
                end
                if #new_pool == 0 then return pool end
                return new_pool
            end,
        }
        card.ability.extra.choices[i] = obj
        temp_map[obj] = true
    end
    if fuck then G.playing_cards = nil end
end

SMODS.Joker({
	key = "nemesis",
	name = "Nemesis",
	atlas = "mf_jokers",
	config = {
		extra = {
            e_blind_size = 1.2,
            choices = {
                "j_mf_knuckleblaster", "j_mf_triangle", "j_mf_triangle", "j_mf_triangle", "j_mf_triangle"
            },
            defeated = false,
        },
	},
	pos = { x = 0, y = 14 },
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	attributes = { "generation", "joker", "boss_blind", "booster", },
	loc_vars = function(self, info_queue, card)
        local msg = "N/A"
        if G.GAME.blind and G.GAME.blind.boss then
            msg = G.GAME.blind.chips ^ card.ability.extra.e_blind_size
        end

        for _, other_key in ipairs(card.ability.extra.choices) do
            info_queue[#info_queue + 1] = G.P_CENTERS[other_key]
        end
		return {
			vars = { card.ability.extra.e_blind_size, msg },
		}
	end,
	set_ability = function(self, card, initial, delay_sprites)
        reset_choices(card, {nil, "Uncommon", "Uncommon", "Uncommon", "Uncommon"}, "j_mf_knuckleblaster")
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint and G.GAME.blind.boss then
			local req = G.GAME.blind.chips ^ card.ability.extra.e_blind_size

            if G.GAME.chips > req then
                FLUFF.nemesis_rewards = FLUFF.nemesis_rewards or {}
                FLUFF.nemesis_reward = FLUFF.nemesis_reward or 0
                FLUFF.nemesis_rewards[#FLUFF.nemesis_rewards + 1] = card.ability.extra.choices

                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function()
                        add_tag(Tag("tag_mf_nemesis"))
                        return true
                    end,
                }))

                if not card.ability.extra.defeated then
                    card.ability.extra.defeated = true
                    card.ability.extra.e_blind_size = 1.5
                    card:juice_up(0.3, 0.5)
                    reset_choices(card, {nil, "Rare", "Rare", "Rare", "Rare"}, "j_mf_whiplash")
                else
                    SMODS.destroy_cards { card }
                end
            end
		end
	end,

    -- based on aikoshen code
    -- :3
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if desc_nodes == full_UI_table.main then
            local cards = {}

            for _, card in ipairs(card.ability.extra.choices) do
                table.insert(cards, Card(0,0, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card]) )
            end

            G.mf_nemesis_area = CardArea(
                G.ROOM.T.x + 0.2 * G.ROOM.T.w, G.ROOM.T.h, G.CARD_W * 2.7, G.CARD_H * 0.01,
                { card_limit = #cards, type = "title", highlight_limit = 0, collection = true, temporary = true, no_shadow = true }
            )
            for i, card in ipairs(cards) do
                card.T.w = card.T.w * 0.6
                card.T.h = card.T.h * 0.6
                card.VT.h = card.T.h
                card.VT.h = card.T.h
                if(card.config.center) then
                    -- this properly sets the sprite size <3
                    card:set_sprites(card.config.center)
                end
                G.mf_nemesis_area:emplace(card)
            end
            local uiEX = {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.07, no_fill = true, minh = 2. },
                nodes = {
                    {n = G.UIT.O, config = { object = G.mf_nemesis_area }}
                }
            }
            if G.mf_nemesis_area then
                if desc_nodes then
                    desc_nodes[#desc_nodes+1] = {
                        uiEX
                    }
                end
            end
        end

    end,
})

SMODS.Tag({
	key = "nemesis",
	atlas = "mf_tags",
	pos = { x = 2, y = 1 },
	unlocked = true,
	discovered = true,
    no_collection = true,
	in_pool = function(self)
		return false
	end,
	loc_vars = function(self, info_queue)
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SECONDARY_SET.Code, function()
				local key = "p_mf_nemesis_normal_1"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
                FLUFF.nemesis_reward = (FLUFF.nemesis_reward or 0) + 1
				G.FUNCS.use_card({ config = { ref_table = card } })
				card:start_materialize()
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})

SMODS.Booster({
    key = "nemesis_normal_1",
    kind = "Nemesis",
    pos = { x = 2, y = 8 },
    config = { extra = 5, choose = 1, nemesis_pack = true },
    cost = 8,
    weight = 0.,
    unlocked = true,
    discovered = true,
    draw_hand = true,
    no_collection = true,
    in_pool = function (...) return false end,
    create_card = function(self, card, i)
        local reward = FLUFF.nemesis_rewards[FLUFF.nemesis_reward][i]
        local n_card = SMODS.create_card {
            key = reward
        }
        return n_card
    end,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return { vars = { cfg.choose, cfg.extra }, key = self.key:sub(1, -3) }
    end,
    group_key = "k_nemesis_pack",
})