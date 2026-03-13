SMODS.Shader {
    key="triangle_badge",
    path="triangle_badge.fs"
}

local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
    if obj and not obj.no_shader_on_modbadge then
        for i = 1, #badges do
            if badges[i].nodes[1].nodes[2].config.object.string == FLUFF.display_name then
                -- badges[i].nodes[1].config.minw = 2
                badges[i].nodes[1].config.shader = "mf_triangle_badge"
            end
        end
    end
end