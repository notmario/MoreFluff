if RudeBuster then return nil end

function is_planeswalker(joker)
  if joker.config.center.planeswalker == true then
    return true
  elseif type(joker.config.center.planeswalker) == "function" then
    return joker.config.center.planeswalker(joker)
  end
  return false
end

G.mf_custom_loyalty = {}

SMODS.DrawStep({
	key = "walker_loyalty",
	order = 26,
	func = function(self)
    if not G.mf_loyalty_spr then
      G.mf_loyalty_spr = Sprite(
        0, 0, 71, 95, G.ASSET_ATLAS["mf_loyalty"], {x = 0, y = 0}
      ) -- im dumb and stupide
    end

    if not is_planeswalker(self) or self.config.center.suppress_loyalty_drawstep then
      return nil
    end

    local target_spr = G.mf_loyalty_spr

    if self.config.center.loyalty_atlas then
      local atlas = self.config.center.loyalty_atlas
      if not G.mf_custom_loyalty[atlas] then
        G.mf_custom_loyalty[atlas] = Sprite(
          0, 0, 71, 95, G.ASSET_ATLAS[atlas], {x = 0, y = 0}
        )
      end
      target_spr = G.mf_custom_loyalty[atlas]
    end

    target_spr.role.draw_major = self

    local shader = "dissolve"

    local loyalty = self.ability.extra.loyalty
    
    target_spr:set_sprite_pos({x=0, y=3})
    target_spr:draw_shader(shader, nil, nil, nil, self.children.center)

    if loyalty > 99 then
      target_spr:set_sprite_pos({x=1, y=3})
      target_spr:draw_shader(shader, nil, nil, nil, self.children.center)
    elseif loyalty <= 9 then
      target_spr:set_sprite_pos({x=loyalty, y=0})
      target_spr:draw_shader(shader, nil, nil, nil, self.children.center)
    else
      target_spr:set_sprite_pos({x=math.floor(loyalty/10), y=1})
      target_spr:draw_shader(shader, nil, nil, nil, self.children.center)
      target_spr:set_sprite_pos({x=loyalty%10, y=2})
      target_spr:draw_shader(shader, nil, nil, nil, self.children.center)
    end
	end,
	conditions = { vortex = false, facing = "front" },
})

function get_loyalty_costs(card)
  if type(card.config.center.planeswalker_costs) == "table" then
    return card.config.center.planeswalker_costs
  elseif type(card.config.center.planeswalker_costs) == "function" then
    return card.config.center.planeswalker_costs(card)
  end
  return {}
end

-- modified from entropy
-- how entropious
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local abc = G_UIDEF_use_and_sell_buttons_ref(card)
  if (card.area == G.jokers and G.jokers and is_planeswalker(card)) and not card.debuff then
    sell = {n=G.UIT.C, config={align = "cr"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = 'sell'}, nodes={
          {n=G.UIT.B, config = {w=0.1,h=0.6}},
          {n=G.UIT.C, config={align = "tm"}, nodes={
            {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
              {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
              {n=G.UIT.T, config={ref_table = card, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
            }}
          }}
        }},
      }}
      nodesthing = {
        {n=G.UIT.R, config={align = 'cl'}, nodes={
          sell
        }},
      }

      costs = get_loyalty_costs(card)
      
      for i, cost in ipairs(costs) do
        
        text = ""..cost
        if type(cost) == "number" and cost > 0 then text = "+"..cost end
        
        ability = {n=G.UIT.C, config={align = "cr"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cr",padding = 0.1, r=0.08, minw = 0.8, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'loyalty_'..i, func = 'can_loyalty_'..i}, nodes={
            
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = text,colour = G.C.WHITE, scale = 0.3, shadow = true}},
                
              }}
            }},
          }}
        nodesthing[#nodesthing + 1] = 
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            ability
          }}
        
      end
      
      return {
          n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
            {n=G.UIT.C, config={padding = 0, align = 'cl'}, nodes=nodesthing},
        }}
    end
  	return abc
end

function can_loyalty(joker, ability_number)
  if (G.play and #G.play.cards > 0) or
      (G.CONTROLLER.locked) or 
      (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) --or 
      --G.STATE == G.STATES.BLIND_SELECT 
      then return false end
  local can_pay_cost = true
  if type(joker.config.center.planeswalker_costs[ability_number]) == "number" then
    can_pay_cost = (joker.config.center.planeswalker_costs[ability_number] + joker.ability.extra.loyalty) >= 0
  end
  return
    can_pay_cost and
    (joker.ability.extra.uses ~= 0 or not joker.config.center.default_loyalty_effects) and
    joker.config.center.can_loyalty(joker, ability_number)
end

function loyalty(joker, ability_number)
  joker.config.center.loyalty(joker, ability_number)
  if joker.config.center.default_loyalty_effects then
    joker.ability.extra.uses = joker.ability.extra.uses - 1
    local cost = joker.config.center.planeswalker_costs[ability_number]
    if type(cost) == "number" then
      joker.ability.extra.loyalty = joker.ability.extra.loyalty + cost
    end
  end
end

-- i hate this but less
for i = 1,100 do
  G.FUNCS["can_loyalty_"..i] = function(e)
    if can_loyalty(e.config.ref_table, i) then
      e.config.colour = G.C.BLUE
      e.config.button = "loyalty_"..i
    else
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
    end
  end
  G.FUNCS["loyalty_"..i] = function(e)
    return loyalty(e.config.ref_table, i)
  end
end