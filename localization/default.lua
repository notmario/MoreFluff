return {
    descriptions = {
        Joker = {
            j_mf_basepaul_card = {
                name = "Basepaul Card",
                text = {
                    "{X:mult,C:white} X#1# {} Mult. {X:mult,C:white} X#2# {} Mult",
                    "instead for {C:red}Paul{}",
                    "{C:inactive}(Who's Paul?)"
                },
            },
            j_mf_blahaj = { 
                name = "Blåhaj",
                text = {
                    "Swaps {C:chips}Chips{} and {C:mult}Mult{}"
                },
            },
            j_mf_clownfish = {
                name = "Clownfish",
                text = {
                    "{C:attention}Enhanced{} cards",
                    "score {C:chips}+#1#{} more Chips",
                    "and {C:mult}+#2#{} more Mult",
                    "when scored"
                }
            },
            j_mf_expansion_pack = {
                name = "Expansion Pack",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "create {C:attention}#1# {C:dark_edition}modded{C:attention} Joker",
                    "{C:inactive}(Must have room)"
                },
            },
            j_mf_hollow = {
                name = "Hollow Joker",
                text = {
                    "{C:attention}#1#{} hand size",
                    "{C:mult}+#2#{} Mult per hand",
                    "size below {C:attention}#3#"
                }
            },
            j_mf_jackofalltrades = {
                name = "Jack of All Trades",
                text = {
                    "Each {C:attention}Jack{} held",
                    "in hand gives {C:mult}+#1#{} Mult,",
                    "{C:chips}+#2#{} Chips, and {C:money}$#3#"
                },
            },
            j_mf_jester = {
                name = "Jester",
                text = {
                    "{C:chips,s:1.1}+#1#{} Chips"
                }
            },
            j_mf_lollipop = {
                name = "Lollipop",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "{X:mult,C:white} -X#2# {} Mult per",
                    "round played",
                }
            },
            j_mf_luckycharm = {
                name = "Lucky Charm",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance",
                        "for {C:mult}+#3#{} Mult",
                    },
                    {
                        "{C:green}#4# in #5#{} chance",
                        "to win {C:money}$#6#",
                        "at end of round"
                    },
                }
            },
            j_mf_mspaint = {
                name = "MS Paint Joker",
                text = {
                    "{C:attention}+#1#{} hand size",
                    "for the first hand",
                    "of each blind"
                },
            },
            j_mf_philosophical = {
                name = "Philosophical Joker",
                text = {
                    "{C:dark_edition}+#1#{} Joker Slot"
                },
            },
            j_mf_simplified = {
                name = "Simplified Joker",
                text = {
                    "All {C:common}Common{} Jokers",
                    "each give {C:mult}+#1#{} Mult",
                }
            },
            j_mf_spiral = {
                name = "Spiral Joker",
                text = {
                    "{C:mult}+(#1#+#2#cos(pi/#3# x {C:attention}$${C:mult})){} Mult",
                    "{C:inactive}({C:attention}$${C:inactive} is your current money)",
                    "{C:inactive}(Currently gives {C:mult}+#4#{C:inactive} Mult)"
                }
            },
            j_mf_treasuremap = {
                name = "Treasure Map",
                text = {
                    "After {C:attention}#2#{} rounds,",
                    "sell this card to",
                    "earn {C:money}$#3#{}",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)"
                },
            },
            j_mf_unregisteredhypercam = { 
                name = "Unregistered Hypercam 2",
                text = {
                    "{X:mf_eemult,C:white,s:1.4} ^^#1# {s:1.4} Mult",
                    "before scoring",
                },
            },
            j_mf_dropkick = {
                name = "Dropkick",
                text = {
                    "{C:blue}+#1#{} hand when hand",
                    "contains a {C:attention}Straight",
                },
            },
            j_mf_bladedance = {
                name = "Blade Dance",
                text = {
                    "Adds {C:attention}#1#{} temporary",
                    "{C:attention}Steel Cards{}",
                    "to your deck when",
                    "blind is selected",
                },
            },
            j_mf_hyperbeam = {
                name = "Hyper Beam",
                text = {
                    "{X:red,C:white} X#1# {} Mult",
                    "{C:attention}Lose all discards",
                    "when {C:attention}Blind{} is selected",
                },
            },
            j_mf_blasphemy = {   
                name = "Blasphemy",
                text = {
                    "{X:red,C:white} X#1# {} Mult",
                    "{C:blue}-#2#{} hands",
                    "when hand is played",
                },
            },
            j_mf_dramaticentrance = {    
                name = "Dramatic Entrance",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "for the first hand",
                    "of each round",
                },
            },
            j_mf_bonussheet = {    
                name = "Bonus Sheet",
                text = {
                    "{C:attention}Buffoon Packs{} contain an",
                    "additional {V:1}Scrapped{} {C:attention}Joker{}"
                },
            },
            j_mf_triangle = {
                name = "Triangle",
                text = {
                    "Other {C:attention}Scaling Jokers{} scale at a",
                    "{X:purple,C:white}X#1#{} rate, increases by {X:purple,C:white}X#2#{} if",
                    "played hand is a {C:attention}Three of a Kind",
                },
            },
            j_mf_triangle_lame = {
                name = "Triangle",
                text = {
                    "Other {C:attention}Scaling Jokers{} scale at a",
                    "{X:purple,C:white}X#1#{} rate, increases by {X:purple,C:white}X#2#{} if",
                    "played hand is a {C:attention}Three of a Kind",
                    "{C:inactive,s:0.8}(Does not modify other copies of Triangle)"
                },
            },

            -- oldfluff
            j_mf_brainrot = {
                name = "Brainrot",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "destroy the leftmost Joker",
                    "and permanently add {C:attention}#2#x",
                    "its sell value to these {C:blue}Chips",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            j_mf_triangular = {
                name = "Triangular Joker",
                text = {
                    "Gains {C:chips}+#2#{} Chips and",
                    "increase {C:chips}Chips{} gained",
                    "by {C:chips}#3#{} if played hand has",
                    "exactly {C:attention}3{} cards",
                    "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)"
                }
            },
            j_mf_boxofhands = {
                name = "Box of Hands",
                text = {
                    "Sell this card to gain {C:blue}5{} hands",
                    "only for the current round",
                    "{C:inactive}(No effect outside of a round)"
                }
            },
            j_mf_rosetinted = {
                name = "Rose-Tinted Glasses",
                text = {
                    "If {C:attention}first hand{} of round is",
                    "a single {C:attention}2{}, destroy it and",
                    "create a free {C:attention}Double Tag{}",
                }
            },
            j_mf_glitterbomb = {
                name = "Glitter Bomb",
                text = {
                    "Sell this card to",
                    "give all held cards",
                    "a random {C:attention}Enhancement{}"
                }
            },
            j_mf_moneyprinter = {
                name = "Money Printer",
                text = {
                    "Earn {C:money}$2{} for each",
                    "played numbered card",
                    "that is a digit of",
                    "your current money",
                    "{C:inactive}(Ace = 1, 10 = 0)"
                }
            },
            j_mf_sealthedeal = {
                name = "Seal the Deal",
                text = {
                    "After you play a winning hand,",
                    "add a random {C:attention}Seal{} to",
                    "one of the played cards",
                }
            },
            j_mf_particleaccelerator = {
                name = "Particle Accelerator",
                text = {
                    "Gains {X:mult,C:white} X#2# {} Mult if played",
                    "hand has only {C:attention}1{} card,",
                    "otherwise gives {X:mult,C:white} X#1# {} Mult",
                    "and resets to {X:mult,C:white} X1 {} Mult"
                }
            },
            j_mf_balatromods = {
                name = "Balatro Mods (Working 2024)",
                text = {
                    "If {C:attention}first hand{} of round",
                    "has only {C:attention}1{} card, spend",
                    "{C:attention}$#1#{} to give it a",
                    "random {C:attention}Enhancement{}",
                }
            },
            j_mf_fived = {
                name = "5D Joker with Multiverse Time Travel",
                text = {
                    "{C:attention}-#1#{} Ante and is destroyed if",
                    "you defeat the {C:attention}Blind",
                    "by {X:purple,C:white}X#2#{} or more"
                },
            },
            j_mf_whiteboard = {
                name = "Whiteboard",
                text = {
                    "{X:red,C:white} X#1# {} Mult for each",
                    "empty hand space",
                    "after {C:attention}#2#{} cards"
                },
            },
            j_mf_miner = {
                name = "Miner",
                text = {
                    "Gain a {C:green}D6 Tag{}",
                    "when {C:attention}Boss Blind",
                    "is selected",
                },
            },
            j_mf_blackmarket = {
                name = "Black Market",
                text = {
                    "When {C:attention}Boss Blind{}",
                    "is selected, spend {C:attention}$10",
                    "to summon an {C:spectral}Ankh{} card"
                },
            },
            j_mf_thejester = {
                name = "The Jester",
                text = {
                    "{X:mult,C:white} X#1# {} Mult for",
                    "each unique played pair"
                }
            },
            j_mf_aceupthesleeve = {
                name = "Ace Up The Sleeve",
                text = {
                    "Add a random {C:attention}Enhanced",
                    "{C:attention}Ace{} to your hand",
                    "when you have {C:blue}1{}",
                    "hand left"
                }
            },
            j_mf_burnerphone = {
                name = "Burner Phone",
                text = {
                    "Shows the rank and suit",
                    "of the top two cards",
                    "of the deck",
                    "{C:inactive}(Currently {V:1}#1#{V:2}#2#{V:3}#3#{C:inactive}",
                    "{C:inactive}and {V:4}#4#{V:5}#5#{V:6}#6#{C:inactive})"
                },
            },
            j_mf_bigshot = {
                name = "[[BIG SHOT]]",
                text = {
                    "Played {C:attention}Aces{},",
                    "{C:attention}9s{}, and {C:attention}7s{} earn",
                    "{C:money}$#1#{} when scored",
                    "Retrigger all played {C:attention}9s{}",
                },
            },
            j_mf_mrloans = {
                name = "Mr. Loans",
                text = {
                    "Prevents death if",
                    "not in debt, but you",
                    "lose {C:money}${} equal to remaining",
                    "required chips"
                },
            },
            j_mf_monochrome = {
                name = "Monochrome Joker",
                text = {
                    "{C:mult}+#1#{} Mult per round",
                    "without a {C:attention}Colour Card",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive})",
                }
            },
            j_mf_wilddrawfour = { 
                name = "Wild Draw Four",
                text = {
                    "{C:attention}+#2#{} hand size for",
                    "each {C:attention}Wild Card{} scored",
                    "in the current round",
                    "{C:inactive}(Currently {C:attention}+#1#{C:inactive} cards)"
                },
            },
            j_mf_fleshprison = {
                name = "Flesh Prison",
                text = {
                    "{X:purple,C:white}X#1#{} {C:attention}Boss Blind{} size",
                    "When {C:attention}Boss Blind{} is defeated,",
                    "{C:red}self destructs{}, and creates",
                    "a {C:dark_edition}Negative{} {C:spectral}The Soul{} card",
                }
            },
            j_mf_mashupalbum = {
                name = "Mashup Album",
                text = {
                    "Gains {C:mult}+#3#{} Mult if played",
                    "hand contains a {C:hearts}red{} flush",
                    "Gains {C:chips}+#4#{} Chips if played",
                    "hand contains a {C:spades}black{} flush",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} and {C:chips}+#2#{C:inactive})"
                },
            },
            j_mf_badlegaldefence = {
                name = "Bad Legal Defence",
                text = {
                    "Create a {C:attention}Death{} {C:tarot}Tarot{}",
                    "when {C:attention}Boss Blind{}",
                    "is selected",
                    "{C:inactive}(Must have room)"
                },
            },
            j_mf_flintandsteel = {
                name = "Flint and Steel",
                text = {
                    "Upgrade the level of each",
                    "{C:attention}played hand{} if scored hand contains",
                    "a {C:attention}Stone Card{} and {C:attention}Steel Card{}",
                }
            },
            j_mf_sudoku = {
                name = "Sudoku Joker",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if each rank from {C:attention}A-9{}",
                    "has been {C:attention}scored{}, resets when",
                    "a {C:attention}Boss Blind{} is {C:red}defeated",
                    "{C:inactive}(Currently {V:1}A{C:inactive}, {V:2}2{C:inactive}, {V:3}3{C:inactive}, {V:4}4{C:inactive}, {V:5}5{C:inactive}, {V:6}6{C:inactive}, {V:7}7{C:inactive}, {V:8}8{C:inactive}, {V:9}9{C:inactive})"
                },
            },
            j_mf_talljoker = {
                name = "Tall Joker",
                text = {
                    "{C:mult,s:1.1}+#1#{} Mult",
                },
            },
        },
    },
    misc = {
        dictionary = {
            k_swap_ex = "Swap!",
            k_sealed_ex = "Sealed!",
            k_reset_ex = "Sealed!",
            k_timetravel_ex = "Time travel!",
            k_plus_ankh = "+Ankh",
            k_rankless = "rankless",
            k_suitless = "suitless",
            k_saved_mrloans = "Saved by Mr. Loans",
            k_added_ex = "Added!",
            k_death_caps = "DEATH",
            k_noted_ex = "Noted!",
        },
        v_dictionary = {
            a_plus_hand = { "+#1# Hand "},
            a_plus_pluschips = { "++#1# Chips" },
        }
    },
}