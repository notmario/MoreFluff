to_big = to_big or function(n)
	return n
end
to_number = to_number or function(n)
	return n
end

local function update_exp_colour(self, _)
	local interp = math.cos(G.TIMERS.REAL * 2 * math.pi / self.cycle) * 0.5 + 0.5

	for i = 1, 4 do
		self[i] = self.colours[1][i] * (1 - interp) + self.colours[2][i] * interp
	end
end

-- from spectralib but whatever
FLUFF.eechips = SMODS.Gradient({
	key = "eechips",
	colours = {
		HEX("41bed9"),
		HEX("5674e9"),
	},
	cycle = 4,
	update = update_exp_colour,
})

FLUFF.eemult = SMODS.Gradient({
	key = "eemult",
	colours = {
		HEX("ff73ad"),
		HEX("db005f"),
	},
	cycle = 4,
	update = update_exp_colour,
})

local lc = loc_colour
function loc_colour(_c, _default, ...)
	if _c == "mf_eemult" then
		_c = "mf_eemult"
	end
	if _c == "mf_eechips" then
		_c = "mf_eechips"
	end
	return lc(_c, _default, ...)
end

SMODS.Attribute { key = "emult" }
SMODS.Attribute { key = "eemult" }
SMODS.Attribute { key = "eechips" }