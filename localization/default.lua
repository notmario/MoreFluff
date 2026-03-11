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
        },
    },
    misc = {
        dictionary = {
            k_swap_ex = "Swap!",
        },
        v_dictionary = {
            a_plus_hand = { "+#1# Hand "},
        }
    },
}