SMODS.Shader({
	key = "triangle_badge",
	path = "triangle_badge.fs",
})

local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if obj then
		local add_lettergem_badge = false
		for i = 1, #badges do
			if badges[i].nodes[1].nodes[2].config.object.string == FLUFF.display_name then
				if obj.lettergem_badge then
					add_lettergem_badge = true
				end
				if not obj.no_shader_on_modbadge then
					-- badges[i].nodes[1].config.minw = 2
					badges[i].nodes[1].config.shader = "mf_triangle_badge"
				end
			end
		end

		if add_lettergem_badge then
			local mod_name = "Lettergem"
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(mod_name) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = 1
			-- calced_text_width > max_text_width and max_text_width/calced_text_width
			-- or 1
			badges[#badges + 1] = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = HEX("a9683b"),
							r = 0.1,
							minw = 2,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * size,
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = "Lettergem",
										colours = { G.C.WHITE },
										float = true,
										shadow = true,
										offset_y = -0.05,
										silent = true,
										spacing = 1 * scale_fac,
										scale = 0.33 * size * scale_fac,
										marquee = false,
										maxw = max_text_width,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
		end
	end
end
