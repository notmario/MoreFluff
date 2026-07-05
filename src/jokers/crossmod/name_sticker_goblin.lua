SMODS.Joker({
	key = "name_sticker_goblin",
	name = "Mind Goblin",
	config = {
        extra = {
            name_sticker = "______",
			vowel_xmult = 0.5,
        }
    },
	atlas = "mf_crossmod",
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", },
	loc_vars = function(self, info_queue, card)
		local vowel_count = 0
		for i = 1, #card.ability.extra.name_sticker do
			local c = string.lower(card.ability.extra.name_sticker:sub(i,i))
			if c == "a" or c == "e" or c == "i" or c == "o" or c == "u" or c == "y" then
				vowel_count = vowel_count + 1
			end
		end
		return { vars = { card.ability.extra.name_sticker, card.ability.extra.vowel_xmult, card.ability.extra.vowel_xmult * vowel_count + 1 } }
	end,
	calculate = function(self, card, context)
		if context.before and G.GAME.aiko_current_word and card.ability.extra.name_sticker == "______" then
			local new_word = ""
			for i = 1, #G.GAME.aiko_current_word do
				local c = string.lower(G.GAME.aiko_current_word:sub(i,i))
				if i == 1 then c = string.upper(c) end
				new_word = new_word .. c
			end
			card.ability.extra.name_sticker = new_word
			return {
				message = localize "k_stickered_ex"
			}
		end
		if context.joker_main then
			local vowel_count = 0
			for i = 1, #card.ability.extra.name_sticker do
				local c = string.lower(card.ability.extra.name_sticker:sub(i,i))
				if c == "a" or c == "e" or c == "i" or c == "o" or c == "u" or c == "y" then
					vowel_count = vowel_count + 1
				end
			end
			return { xmult = card.ability.extra.vowel_xmult * vowel_count + 1 }
		end
	end,
    akyrs_is_letter = true,
    in_pool = function (self, args)
        return G.GAME.akyrs_character_stickers_enabled and G.GAME.akyrs_wording_enabled or false
    end,
	set_badges = function (self, card, badges)
		SMODS.create_mod_badges({ mod = SMODS.find_mod("aikoyorisshenanigans")[1] }, badges)
	end
})
