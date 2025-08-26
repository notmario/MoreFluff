-- nota: Traducción al español hecha por Profesor Oak 56.

local art_credit = function (name)
  if mf_config["Programmer Art"] then return nil end
  if mf_config["Disable Art Credits"] then return nil end
  return "{s:0.8,C:inactive}Arte por: "..name
end

local loc_stuff = {
  descriptions = {
    Joker = {
      j_mf_badlegaldefence = {
        name = "Mala defensa legal",
        text = {
          "Crea una {C:tarot}carta de Tarot{},",
          "{C:attention}La muerte{}, cuando se",
          "selecciona la {C:attention}ciega de jefe{}",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_basepaul_card = {
        name = "Carta Basepaul",
        text = {
          "{X:mult,C:white} X#1# {} Mult. {X:mult,C:white} X#2# {} Mult",
          "en lugar de {C:red}Paul{}",
          "{C:inactive}(¿Quién es Paul?)"
        }
      },
      j_mf_bladedance = {
        name = "Danza Filo",
        text = {
          "Añade {C:attention}#1#{} {C:attention}carta de{}",
          "{C:attention}acero{} a tu mazo",
          "al seleccionar ciega",
        },
      },
      j_mf_blasphemy = {   
        name = "Blasfemia",
        text = {
          "{X:red,C:white} X#1# {} Mult",
          "{C:blue}-#2#{} menos",
          "al jugar la mano",
        },
      },
      j_mf_bloodpact = {
        name = "Pacto de sangre",
        text = {
          "{X:mult,C:white} X#1# {} Mult",
          "Se {C:red}autodestruye{} si juegas",
          "una carta que no sea {C:hearts}Corazones{}",
          art_credit("footlongdingledong"),
        }
      },
      j_mf_bowlingball = {
        name = "Bola de bolera",
        text = {
          "Los {C:attention}3s{} jugados",
          "dan {C:chips}+#1#{} Chips",
          "y {C:mult}+#2#{} Mult",
          "al puntuar",
          art_credit("footlongdingledong"),
        }
      },
      j_mf_cba = {
        name = "Mejorador de Cartas Avanzado",
        text = {
          "{C:attention}Reactiva{} tu primer",
          "comodín {C:dark_edition}mejorado{}",
          "{C:inactive}(excluyendo MdCA){}"
        }
      },
      j_mf_clipart = {
        name = "Comodín artístico",
        text = {
          "Crea una carta de {C:colourcard}color{}",
          "al seleccionar {C:attention}ciega{}",
          "{C:inactive}(Debe tener espacio)"
        },
      },
      j_mf_colorem = {
        name = "Coloreador",
        text = {
          "Cuando una carta de {C:colourcard}color{} es usada,",
          "hay un {C:green}#1# de #2#{} de probabilidad de",
          "añadirla a tus consumibles",
          "{C:inactive}(Debe haber espacio)",
        },
      },
      j_mf_coupon_catalogue = {
        name = "Catálogo de cupones",
        text = {
          "{C:mult}+#1#{} Mult por cada",
          "{C:attention}vale{} comprado",
          "durante esta partida",
          "{C:inactive}(Por ahora {C:mult}+#2#{C:inactive} Mult)",
        }
      },
      j_mf_css = {
        name = "CSS",
        text = {
          "Crea una carta de {C:colourcard}color",
          "al azar cuando la mano",
          "contiene un {C:attention}Color",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_dramaticentrance = {    
        name = "Entrada dramática",
        text = {
          "{C:chips}+#1#{} Chips",
          "en la primera mano",
          "de cada jugada",
        },
      },
      j_mf_dropkick = {
        name = "Dropkick",
        text = {
          "{C:blue}+#1#{} manos cuando la mano",
          "contiene una {C:attention}Escalera",
        },
      },
      j_mf_expansion_pack = {
        name = "Pase de expansión",
        text = {
          "Al seleccionar {C:attention}ciega{},",
          "crea un {C:attention}comodín {C:attention}#1#",
	  "{C:dark_edition}introducido en este mod",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_fleshprison = {
        name = "Prisión de carne",
        text = {
          "{C:red}X#1#{} tamaño de {C:attention}ciega de jefe{}",
          "Al derrotar la {C:attention}ciega de jefe{},",
          "se {C:red}autodestruye{}, y crea",
          "una carta de {C:spectral}Alma{} {C:dark_edition}negativa{}",
        }
      },
      j_mf_fleshpanopticon = {
        name = "Panóptico de carne",
        text = {
          "{C:red}X#1#{} tamaño de {C:attention}ciega de jefe{}",
          "Al derrotar la {C:attention}ciega de jefe{},",
          "se {C:red}autodestruye{}, y crea",
          "una carta de {C:spectral}Portal{} {C:dark_edition}negativa{}",
        }
      },
      j_mf_globe = {
        name = "Globo",
        text = {
          "Crea #1# carta de{C:planet}planeta{}",
          "al {C:attention}actualizar{} en la tienda",
        }
      },
      j_mf_goldencarrot = {
        name = "Zanahoria dorada",
        text = {
          "Gana {C:money}$#1#{} al",
          "final de la ronda.",
          "{C:money}-$#2#{} dados",
          "por mano jugada",
        }
      },
      j_mf_hallofmirrors = {
        name = "Sala de espejos",
        text = {
          "{C:attention}+#2#{} tamaño de mano",
          "para cada {C:attention}6{} anotado",
          "en esta ronda",
          "{C:inactive}(Actualmente {C:attention}+#1#{C:inactive} cartas)"
        }
      },
      j_mf_hollow = {
        name = "Comodín hueco",
        text = {
          "{C:attention}#1#{} tamaño de mano",
          "{C:mult}+#2#{} Mult por tamaño de",
          "mano menor que {C:attention}#3#"
        }
      },
      j_mf_hyperbeam = {
        name = "Hiperrayo",
        text = {
          "{X:red,C:white} X#1# {} Mult",
          "{C:attention}Pierde los descartes",
          "al seleccionar {C:attention}ciega{}",
        },
      },
      j_mf_impostor = {
        name = "Impostor",
        text = {
          "{X:mult,C:white} X#1# {} Mult si la",
          "amno jugada tiene",
          "exactamente una carta {C:red}roja{}"
        }
      },
      j_mf_jankman = {
        name = "Basurhombre",
        text = {
          "Todos los comodines {C:dark_edition}de mods{}",
          "{C:inactive}(y también el Comodín contento){}",
          "dan cada uno {X:chips,C:white} X#1# {} Fichas",
        }
      },
      j_mf_jester = {
        name = "Arlequín",
        text = {
          "{C:chips,s:1.1}+#1#{} Fichas"
        }
      },
      j_mf_loadeddisk = {
        name = "Disco cargado",
        text = {
          "Crea cartas de color {C:colourcard}rosa{}",
          "y {C:colourcard}amarillo{} {C:colourcard}Colour{}",
          "al ser vendida",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_lollipop = {
        name = "Piruleta",
        text = {
          "{X:mult,C:white} X#1# {} Mult",
          "{X:mult,C:white} -X#2# {} Mult por",
          "ronda jugada",
        }
      },
      j_mf_luckycharm = {
        name = "Amuleto suerte",
        text = {
          "{C:green}#1# de #3#{} de probabilidad",
          "de {C:mult}+#2#{} Mult",
          "{C:green}#1# de #5#{} de probabilidad",
          "de ganar {C:money}$#4#",
          "al final de la ronda"
        }
      },
      j_mf_mashupalbum = {
        name = "Recopilación",
        text = {
          "Gana {C:mult}+#3#{} Mult si la mano",
          "jugada contiene color {C:hearts}rojo{}",
          "Gana {C:chips}+#4#{} Fichas si la mano",
          "jugada contiene un color {C:spades}negro{}",
          "{C:inactive}(Actualmente {C:mult}+#1#{C:inactive} y {C:chips}+#2#{C:inactive})"
        },
      },
      j_mf_mspaint = {
        name = "Comodín MS Paint",
        text = {
          "{C:attention}+#1#{} tamaño de mano",
          "para la primera mano",
          "de cada ciega"
        },
      },
      j_mf_paintcan = {
        name = "Lata de pintura",
        text = {
          "{C:green}#1# de #2#{} de probabilidad de",
          "añadir una ronda a {C:colourcard}Cartas de color{}",
          "cuando anotan en una ronda",
        },
      },
      j_mf_pixeljoker = {
        name = "Comodín pixel",
        text = {
          "Los {C:attention}ases{},",
          "{C:attention}4s{} y {C:attention}9s{} jugados dan",
          "{X:mult,C:white} X#1# {} Mult al anotar"
        },
      },
      j_mf_philosophical = {
        name = "Comodín filósofo",
        text = {
          "{C:dark_edition}+#1#{} ranura de comodín"
        },
      },
      j_mf_rainbowjoker = {
        name = "Comodín arco iris",
        text = {
          "Las cartas de {C:colourcard}color{} dan",
          "{X:mult,C:white} X#1#{} Mult",
          art_credit("footlongdingledong"),
        },
      },
      j_mf_recycling = {
        name = "Reciclaje",
        text = {
          "Crea una carta de {C:planet}planeta{}",
          "o {C:tarot}tarot{} al azar",
          "al saltarse {C:attention}paquetes{}",
          "{C:attention}de mejora{}",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_rosetinted = {
        name = "Gafas de rosa",
        text = {
          "Si la {C:attention}primera mano{} de ronda",
          "contiene un solo {C:attention}2{}, destrúyelo y",
          "crea una etiqueta {C:attention}doble{} gratis",
        }
      },
      j_mf_simplified = {
        name = "Comodín simplificado",
        text = {
          "Todos los comodines {C:blue}comunes{}",
          "dan {C:mult}+#1#{} Mult por cada uno",
        }
      },
      j_mf_spiral = {
        name = "Comodín espiral",
        text = {
          "{C:mult}+(#1#+#2#cos(pi/#3# x {C:attention}$${C:mult})){} Mult",
          "{C:inactive}({C:attention}$${C:inactive} es tu dinero actual)",
          "{C:inactive}(Daría {C:mult}+#4#{C:inactive} Mult)"
        }
      },
      j_mf_stylemeter = {
        name = "Medidor estilizado",
        text = {
          "Gana {C:money}$#1#{} al final",
          "de cada ronda por cada",
          "{C:attention}ciega{} saltada esta partida",
          "{C:inactive}(Actualmente {C:money}$#2#{C:inactive})"
        }
      },
      j_mf_teacup = {
        name = "Taza de té",
        text = {
          "Mejora el nivel de cada",
          "{C:attention}mano jugada{} en las",
          "siguientes {C:attention}#1#{} manos",
        },
      },
      j_mf_the_solo = {
        name = "El Solitario",
        text = {
          "Gana {X:mult,C:white} X#2# {} Mult si la mano",
          "jugada solo tiene {C:attention}1{} carta",
          "{C:inactive}(Actualmente {X:mult,C:white} X#1# {C:inactive} Mult)",
        }
      },
      j_mf_tonersoup = {
        name = "Sopa de Tóner",
        text = {
          "Crea una carta de {C:tarot}tarot{}",
          "al jugar una mano",
          "Se destruye al derrotar",
          "la ciega de jefe.",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_treasuremap = {
        name = "Mapa del tesoro",
        text = {
          "Después de {C:attention}#2#{} rondas,",
          "vende esta carta para",
          "ganar {C:money}$#3#{}",
          "{C:inactive}(Actualmente {C:attention}#1#{C:inactive}/#2#)"
        },
      },
      j_mf_triangle = {
        name = "Triángulo",
        text = {
          "Las cartas jugadas dan",
          "{X:mult,C:white} X#1# {} Mult al anotar",
          "si la mano jugada es",
          "un {C:attention}trío"
        },
      },
      j_mf_virtual = { 
        name = "Comodín virtual",
        text = {
          "{X:red,C:white} X#1# {} Mult",
          "Mueve y baraja todos los",
          "comodines al",
          "seleccionar ciega"
        },
      },
      j_mf_marigold = {
        name = "Marigold",
        text = {
          "{C:attention}Reactiva{} las cartas {C:attention}Marigold{}",
          "jugadas y sostenidas #1# veces"
        },
      },
      j_mf_yuckyrat = { 
        name = "Rata Yucky",
        text = {
          "Las cartas jugadas {C:attention}sin mejora{}",
          "se convierten en {C:attention}cartas Yucky{}.",
          "Gana {X:red,C:white} X#1# {} Mult por",
          "cada carta convertida",
          "{C:inactive}(Currently {X:red,C:white} X#2# {C:inactive} Mult)"
        },
      },
      j_mf_hyperjimbo = { 
        name = "Híperjimbo",
        text = {
          "{X:dark_edition,C:white,s:1.4} ^^#1# {s:1.4} Fichas",
          "antes de anotar si la {C:attention}mano jugada",
          "contiene exactamente {C:attention}4{} cartas"
        },
      },
      j_mf_brass = {
        name = "Comodín quemado",
        text = {
          "{C:attention}Reactiva{} el comodín",
          "a la derecha por cada",
          "{C:attention}#4# cartas quemadas{} destruidas",
          "{C:inactive}(Actualmente {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        }
      },
      j_mf_allicantdo = {
        name = "Lo Imposible",
        text = {
          "{C:red}Debilita{} la primera mano robada",
          "Gana {X:red,C:white} X#1# {} Mult por cada",
          "carta {C:red}debilitada{} jugada",
          "{C:inactive}(Actualmente {X:red,C:white} X#2# {C:inactive})"
        }
      },
      j_mf_tealjoker = {
        name = "Comodín turquesa",
        text = {
          "Gives {X:chips,C:white} X#1# {} Fichas",
          "por cada {C:attention}carta turquesa",
          "en tu {C:attention}mazo completo",
          "{C:inactive}(Actualmente {X:chips,C:white} X#2# {C:inactive} Chips)",
        }
      },
      j_mf_gemstonejoker = {
        name = "Comodín precioso",
        text = {
          "Gana {C:money}$#1#{} al final de la ciega",
          "por cada {C:attention}carta preciosa{}",
          "en tu {C:attention}mazo completo{}",
          "{C:inactive}(Actualmente {C:money}$#2#{C:inactive})"
        }
      },
      j_mf_top10 = {
        name = "Top 10 Comodines (del 1 al 10)",
        text = {
          "Gana {C:money}$#1#{} al final de la ronda",
          "por cada {C:green}dígito único{} en las cifras",
          "del número de {C:attention}dinero actual{}",
          "{C:inactive}(Son 0, 1, 2, 3, 4, 5, 6, 7, 8 y 9.)",
        }
      },
      j_mf_junkmail = {
        name = "Correo basura",
        text = {
          "Crea un {C:attention}vale{} que",
          "cuesta {C:money}#1#x{} más de lo que",
          "costaría en la tienda",
        }
      },
      j_mf_stonejokerjoker = {
        name = "Comodín de caliza",
        text = {
          "Crea un {C:attention}comodín de mármol{}",
          "{C:dark_edition}negativo{} y {C:spectral}eterno{} ",
          "al final de cada tienda",
        }
      },
      j_mf_flintandsteel = {
        name = "Pedernal",
        text = {
          "Sube el nivel de cada{C:attention}mano jugada{}",
          "si al anotar contiene una {C:attention}carta de",
          "{C:attention}piedra{} y una {C:attention}carta de acero{}",
        }
      },
      j_mf_talljoker = {
        name = "Comodín alto",
        text = {
          "{C:mult,s:1.1}+#1#{} Mult",
        },
      },
      j_mf_complexitycreep = {
        name = "Discrepancia compleja",
        text = {
          "Gana un efecto al azar",
          "cuando aparece y al",
          "seleccionar {C:attention}ciega de jefe{}"
        },
      },
      j_mf_selfinsert = {
        name = "Comodín personalizado",
        text = {
          "El efecto lo decides tú (Ajustes)..."
        }
      },
      j_mf_missingjoker = {
        name = "Textura faltante",
        text = {
          "Se transforma en un",
          "{C:dark_edition}comodín al azar{}",
          "durante la ciega",
          "al seleccionar ciega"
        }
      },
      j_mf_rot_cartomancer = {
        name = "¡Cartomancia!",
        text = {
          "Crea una carta {C:rotarot}de tarot girada 45º{}",
          "al seleccionar {C:attention}ciega{}",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_widejoker = {
        name = "Comodín ancho",
        text = {
          "{X:dark_edition,C:white}^#1#{} Mult",
        },
      },
      j_mf_monochrome = {
        name = "Comodín monocromático",
        text = {
          "{C:mult}+#1#{} Mult por ronda",
          "sin {C:colourcard}cartas de color",
          "{C:inactive}(Actualmente {C:mult}+#2#{C:inactive})",
          art_credit("footlongdingledong"),
        }
      },
      j_mf_farmmerge = {
        name = "Valle Fusión",
        text = {
          "Al descartar {C:attention}3 cartas",
          "de misma categoría se {C:dark_edition}fusionan",
          "todas con la carta descartada",
          "{C:attention}de más a la derecha"
        },
      },
      j_mf_broomcloset = {
        name = "The Broom Closet",
        text = {
          "{X:mult,C:white}X#1#{} Mult if no purchases",
          "were made in the last {C:attention}Shop{}",
          "{C:inactive}(Currently #2#)"
        },
      },
      j_mf_unregisteredhypercam = { 
        name = "Unregistered Hypercam 2",
        text = {
          "{X:dark_edition,C:white,s:1.4} ^^#1# {s:1.4} Mult",
          "antes de anotar",
        },
      },
      j_mf_blahaj = { 
        name = "Blåhaj",
        text = {
          "Intercambia las {C:chips}Chips{} con el {C:mult}Mult{}"
        },
      },
      j_mf_wilddrawfour = { 
        name = "Chupa 4",
        text = {
          "{C:attention}+#2#{} tamaño de mano por",
          "cada {C:attention}carta variable{} anotada",
          "en la ronda actual",
          "{C:inactive}(Actualmente {C:attention}+#1#{C:inactive} cards)"
        },
      },
      j_mf_unpleasantcard = { 
        name = "Carta incómoda",
        text = {
          "{X:chips,C:white} X#1# {} Ficha",
          "Los {C:attention}paquetes de mejora",
          "se saltan automáticamente"
        },
      },
      j_mf_slotmachine = { 
        name = "Tragaperras",
        text = {
          "{C:green}#1# de #2#{} de probabilidad de reactivar",
          "cartas de {C:attention}7{} anotadas {C:attention}#3#{} veces",
        },
      },
      j_mf_snake = {
        name = "Serpiente",
        text = {
          "Tras {C:attention}jugar{} o {C:attention}descartar{},",
          "roba siempre {C:attention}#1#{} carta"
        }
      },
      j_mf_bookmove = {
        name = "Jugada de libro",
        text = {
          "Tras {C:attention}#2#{} rondas,",
          "vende esta carta para crear un",
          "{C:attention}papel perforado{} y {C:attention}fotografía",
          "{C:inactive}(Actualmente {C:attention}#1#{C:inactive}/#2#, debe haber espacio)"
        },
      },
      j_mf_cueball = {
        name = "Bola de billar",
        text = {
          "{C:green}#1# de #2#{} de probabilidad de que",
          "al jugar {C:attention}cartas sin rango{} se cree una",
          "carta {C:rotarot}de tarot girada 45º{} al anotar",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_blunder = {
        name = "Obstáculo",
        text = {
          "{X:mult,C:white} X#1# {} Mult",
          "Fuerza a seleccionar",
          "una carta"
        },
      },
      j_mf_brilliant = {
        name = "Brillante",
        text = {
          "Si la ciega se venció",
          "en una mano, crea una",
          "carta {C:spectral}espectral{} al azar",
          "{C:inactive}(Debe haber espacio)"
        },
      },
      j_mf_lessfluff = {
        name = "Menos relleno",
        text = {
          "Destruye todos los {C:attention}comodines{} {C:dark_edition}de mods{}",
          "al inicio de cada {C:attention}ciega{}", 
          "y gana {X:mult,C:white} X#2# {} Mult por cada",
          "{C:attention}comodín{} destruido",
          "{C:inactive}(Actualmente {X:red,C:white} X#1# {C:inactive})"
        },
      },
      j_mf_sudoku = {
        name = "Comodín sudoku",
        text = {
          "{X:mult,C:white} X#1# {} Mult si cada categoría de {C:attention}A-9{}",
          "{C:attention}anotó{}, se reinicia al",
          "{C:red}derrotar{} la {C:attention}ciega de jefe{}",
          "{C:inactive}(Actualmente {V:1}A{C:inactive}, {V:2}2{C:inactive}, {V:3}3{C:inactive}, {V:4}4{C:inactive}, {V:5}5{C:inactive}, {V:6}6{C:inactive}, {V:7}7{C:inactive}, {V:8}8{C:inactive}, {V:9}9{C:inactive})"
        },
      },
      j_mf_sapling = {
        name = "Árbol creciente con prisas",
        text = {
          "Tras {C:attention}#3#{} rondas,",
          "vende esta carta para cambiar la",
          "{C:attention}puntuación de ronda{} a {s:1.1,C:spectral}ÁRBOL(3){}",
          "{C:inactive}(Actualmente #4#, {}[{C:attention}#1#{C:inactive}#2#{}]{C:inactive})",
        }
      },
      j_mf_onesliptoolate = {
        name = "Un tropezón tardío",
        text = {
          "{X:mult,C:white} xN {} Mult si {C:attention}la mano de póker{} contiene",
          "exactamente {C:attention}N{} cartas, donde {C:attention}N{} es el",
          "número de manos jugadas esta ronda",
          "{C:inactive}(N actualmente equivale a {C:attention}#1#{C:inactive})",
        }
      },
      j_mf_lightningstrikesthrice = {
        name = "El rayo golpea 3 veces",
        text = {
          "Reactiva {C:attention}al descartar",
          "los efectos {C:attention}#1#{} veces",
        }
      },
      j_mf_friendinsideme = {
        name = "Friend Inside Me",
        text = {
          "Once per {C:attention}ante{}, selling a {C:common}Common{}",
          "or {C:uncommon}Uncommon{} joker creates",
          "a joker of the next rarity",
          "{C:inactive}(Currently #1#)"
        }
      },
      j_mf_thewayhome = {
        name = "the way home",
        text = {
          "When {C:attention}blind{} is {C:attention}selected{};",
          "{C:green}#1# in #2#{} chance to",
          "gain {C:blue}#3#{} hands"
        }
      },
      -- ORTALAB SWAPS
      j_mf_clintcondition = {
        name = "Condición Clerfecta",
        text = {
          "{X:chips,C:white} X#1# {} Chips. {X:chips,C:white} X#2# {} Chips",
          "en lugar de {C:chips}Clerfecto{}",
          "{C:inactive}(¿Quién es Clerfecto?)"
        }
      },
      j_mf_sheetsuggestion = {
        name = "Sugerencia de hojierda",
        text = {
          "{C:mult,s:1.1}+#1#{} Mult",
          "{C:inactive}(texto predeterminado gracioso)"
        }
      },

      j_mf_devilsknife = {
        name = "Cuchillo demoníaco",
        text = {
          "Crea una carta {C:colourcard}azul{} y",
          "una carta {C:colourcard}de color{} {C:colourcard}lila{}",
          "al venderse",
          "{C:inactive}(Debe haber espacio)"
        },
      },

      j_mf_twotrucks = {
        name = "Dos camiones",
        text = {
          "Gana {X:chips,C:white} X#1# {} Fichas por",
          "cada par único en la mano jugada",
          "{C:inactive}(Actualmente {X:chips,C:white} X#2# {} {C:inactive}Fichas)",
        },
      },

      -- FAMILIAR SWAPS
      j_mf_jimbojjoker = {
        name = "Comodín Jimbo J.",
        text = {
          "{X:mult,C:white} X#1# {} Mult"
        }
      },

      -- FINITY CROSSMOD
      j_mf_theneedle = {
        name = "La aguja",
        text = {
          "Al seleccionar {C:attention}ciega{},",
          "convierte todas salvo una {C:blue}mano{}",
          "en {C:red}#1# descartes{}"
        }
      },
    },
    Colour = {
      c_mf_black = {
        name = "Negro",
        text = {
          "Añade {C:dark_edition}negativo{} a un",
          "{C:attention}comodín{} aleatorio por cada",
          "{C:attention}#4#{} rondas mantenidas",
          "{C:inactive}(Actualmente {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_deepblue = {
        name = "Deep Blue",
        text = {
          "Converts a random card in",
          "hand to {C:spades}Spades{} for every",
          "{C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_crimson = {
        name = "Crimson",
        text = {
          "Create a {C:red}Rare Tag{} for",
          "every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_seaweed = {
        name = "Seaweed",
        text = {
          "Converts a random card in",
          "hand to {C:clubs}Clubs{} for every",
          "{C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_brown = {
        name = "Brown",
        text = {
          "Destroys a random card in",
          "hand and gives {C:attention}$#5#{} for every",
          "{C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_grey = {
        name = "Grey",
        text = {
          "Create a {C:attention}Double Tag{} for",
          "every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_silver = {
        name = "Silver",
        text = {
          "Create a {C:dark_edition}Polychrome Tag{} for",
          "every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_white = {
        name = "White",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:colourcard}Colour{} card for every",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_red = {
        name = "Red",
        text = {
          "Converts a random card in",
          "hand to {C:hearts}Hearts{} for every",
          "{C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_orange = {
        name = "Orange",
        text = {
          "Converts a random card in",
          "hand to {C:diamonds}Diamonds{} for every",
          "{C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_yellow = {
        name = "Yellow",
        text = {
          "Gains {C:money}$#5#{} of",
          "{C:attention}sell value{}",
          "every {C:attention}#4# rounds",
          "{C:inactive}({}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_green = {
        name = "Green",
        text = {
          "Create a {C:dark_edition}Negative{}",
          "{C:green}Oops! All 6s{} for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_blue = {
        name = "Blue",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:planet}Planet{} card for every",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_lilac = {
        name = "Lilac",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:tarot}Tarot{} card for every",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_pink = {
        name = "Pink",
        text = {
          "Add {C:attention}1{} round to a random",
          "{C:colourcard}Colour{} card. Triggers once for",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_peach = {
        name = "Peach",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:rotarot}45 Degree Rotated Tarot{} card for",
          "every {C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_new_gold = {
        name = "Gold",
        text = {
          "Create a {C:dark_edition}Negative{} {C:spectral}Soul{}",
          "card for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      
      c_mf_purple = {
        name = "Magenta",
        text = {
          "Create an {C:cry_epic}Epic Tag{} for",
          "every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_moonstone = {
        name = "Moonstone",
        text = {
          "Create a {C:dark_edition}Jolly Joker{}",
          "card for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_gold = {
        name = "Mutare Basi Ludum",
        text = {
          "Create a {C:dark_edition}Negative{} {C:cry_exotic}Gateway{}",
          "card for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_ooffoo = {
        name = "00FF00",
        text = {
          "Create a {C:dark_edition}Negative{} {C:cry_code}Code{}",
          "card for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_wordlegreen = {
        name = "Wordle Green",
        text = {
          "Create a {C:dark_edition}Negative{} {C:green}Alphabet{}",
          "card for every {C:attention}#4#{}",
          "round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_pastelpink = {
        name = "Pastel Pink",
        text = {
          "Create a {C:dark_edition}Negative{} {V:1}Silly{}",
          "card for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_royalblue = {
        name = "Royal Blue",
        text = {
          "Create a {C:dark_edition}Negative{} {C:spectral}Seal Spectral{}",
          "card for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_teal = {
        name = "Teal",
        text = {
          "Create a {C:dark_edition}Negative{} {C:spectral}Splash{}",
          "for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_blank = {
        name = "Blank",
        text = {
          "Create a {C:dark_edition}Negative{}",
          "{C:spectral}Joker Studio: Basic{}",
          "for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_amber = {
        name = "Amber",
        text = {
          "Create a {C:dark_edition}Negative{} {C:G.SP.C.travel_1}Travel{}",
          "card for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_respiceperprisma = {
        name = "Respice Per Prisma",
        text = {
          "Create a {C:dark_edition}Negative{}",
          "{C:spectral}Ringularity{} for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("astralightsky")
        },
      },
      c_mf_moss = {
        name = "Moss",
        text = {
          "Create a {C:dark_edition}Negative{} {C:myth_light}Myth{}",
          "card for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_caramel = {
        name = "Caramel",
        text = {
          "Create a {C:dark_edition}Negative{} {C:bakery}Bakery{}",
          "good for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_violet = {
        name = "Violet",
        text = {
          "Create a {C:dark_edition}Negative{} {C:spectral}Finity{}",
          "card for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
    },
    Rotarot = {
      c_mf_rot_fool = {
        name = "The Fool!",
        text = {
          "Creates the last",
          "{C:rotarot}45 Degree Rotated Tarot{} or {C:colourcard}Colour{} ",
          "card used during this run",
          "{s:0.8,C:rotarot}The Fool!{s:0.8} excluded"
        }
      },
      c_mf_rot_magician = {
        name = "The Magician!",
        text = {
          "Enhances {C:attention}#1#{}",
          "selected cards to",
          "{C:attention}#2#s"
        }
      },
      c_mf_rot_high_priestess = {
        name = "The High Priestess!",
        text = {
          "Creates up to {C:attention}#1#",
          "random {C:colourcard}Colour{} cards",
          "{C:inactive}(Must have room)"
        }
      },
      c_mf_rot_empress = {
        name = "The Empress!",
        text = {
          "Enhances {C:attention}#1#",
          "selected cards to",
          "{C:attention}#2#s"
        }
      },
      c_mf_rot_emperor = {
        name = "The Emperor!",
        text = {
          "Creates up to {C:attention}#1#{} random",
          "{C:rotarot}45 Degree Rotated Tarot{} cards",
          "{C:inactive}(Must have room)"
        },
      },
      c_mf_rot_heirophant = {
        name = "The Hierophant!",
        text = {
          "Enhances {C:attention}#1#",
          "selected cards to",
          "{C:attention}#2#s"
        }
      },
      c_mf_rot_lovers = {
        name = "The Lovers!",
        text = {
          "Enhances {C:attention}#1#{}",
          "selected cards to",
          "{C:attention}#2#s"
        }
      },
      c_mf_rot_chariot = {
        name = "The Chariot!",
        text = {
          "Enhances {C:attention}#1#{} selected",
          "card into a",
          "{C:attention}#2#"
        }
      },
      c_mf_rot_justice = {
        name = "Justice!",
        text = {
          "Enhances {C:attention}#1#{} selected",
          "card into a",
          "{C:attention}#2#"
        }
      },
      c_mf_rot_hermit = {
        name = "The Hermit!",
        text = {
          "Sets money to next",
          "multiple of {C:money}$#1#",
          "{C:inactive}(No effect on multiples of {C:money}$#1#{C:inactive})"
        },
      },
      c_mf_rot_wheel = {
        name = "The Wheel of Fortune!",
        text = {
          "{C:green}#1# in #2#{} chance to add",
          "a random {C:negative}edition",
          "to a random {C:attention}Joker",
          "{C:inactive}All editions are weighted equally...{}"
        }
      },
      c_mf_rot_strength = {
        name = "Strength!",
        text = {
          "Randomises rank of up to",
          "{C:attention}#1#{} selected cards",
        },
      },
      c_mf_rot_hanged_man = {
        name = "The Hanged Man!",
        text = {
          "Destroys {C:attention}#1#{} random",
          "cards in hand",
        },
      },
      c_mf_rot_death = {
        name = "Death!",
        text = {
          "Select {C:attention}#1#{} cards,",
          "convert {C:attention}all{} selected cards",
          "into a {C:attention}random{} selected card"
        }
      },
      c_mf_rot_temperance = {
        name = "Temperance!",
        text = {
          "Add {C:money}$#1#{} of {C:attention}sell value",
          "to every {C:attention}Joker{} and",
          "{C:attention}Consumable{} card",
        },
      },
      c_mf_rot_devil = {
        name = "The Devil!",
        text = {
          "Enhances {C:attention}#1#{}",
          "selected cards to",
          "{C:attention}#2#s"
        }
      },
      c_mf_rot_tower = {
        name = "The Tower!",
        text = {
          "Enhances {C:attention}#1#{} selected",
          "card into a",
          "{C:attention}#2#"
        }
      },
      c_mf_rot_star = {
        name = "The Star!",
        text = {
          "Add {C:attention}#1#{} random {C:attention}Enhanced",
          "{C:diamonds}Diamonds{} to your hand"
        }
      },
      c_mf_rot_moon = {
        name = "The Moon!",
        text = {
          "Add {C:attention}#1#{} random {C:attention}Enhanced",
          "{C:clubs}Clubs{} to your hand"
        }
      },
      c_mf_rot_sun = {
        name = "The Sun!",
        text = {
          "Add {C:attention}#1#{} random {C:attention}Enhanced",
          "{C:hearts}Hearts{} to your hand"
        }
      },
      c_mf_rot_judgement = {
        name = "Judgement!",
        text = {
          "Creates a random",
          "{C:dark_edition}modded{C:attention} Joker",
          "{C:inactive}(Must have room)"
        },
      },
      c_mf_rot_world = {
        name = "The World!",
        text = {
          "Add {C:attention}#1#{} random {C:attention}Enhanced",
          "{C:spades}Spades{} to your hand"
        }
      },
    },
    Shape = {
      c_mf_cloud = {
        name = "Cloud",
        text = {
          "Create a {C:dark_edition}Negative{}",
          "{C:spectral}Philosophical Joker{} for every",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_spade = {
        name = "Spade",
        text = {
          "Converts a random card in {C:dark_edition}full deck{}",
          "to {C:spades}Spades{}. If it was already {C:spades}Spades{},",
          "{C:red}destroy{} the card instead. Triggers {C:attention}twice",
          "for every {C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_omega = {
        name = "Omega",
        text = {
          "Create an {C:dark_edition}Absolute Tag{} for",
          "every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_club = {
        name = "Club",
        text = {
          "Converts a random card in {C:dark_edition}full deck{}",
          "to {C:club}Clubs{}. If it was already {C:club}Clubs{},",
          "{C:red}destroy{} the card instead. Triggers {C:attention}twice",
          "for every {C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_rectangle = {
        name = "Rectangle",
        text = {
          "Adds a random {C:dark_edition}playing{}",
          "{C:dark_edition}card{} to hand for every",
          "{C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_squircle = {
        name = "Squircle",
        text = {
          "Create a {C:dark_edition}random{} {C:attention}Tag{} for",
          "every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_arrow = {
        name = "Arrow",
        text = {
          "Create a {C:dark_edition}Solar Tag{} for",
          "every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_circle = {
        name = "Circle",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:shape}Shape{} card for every",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_heart = {
        name = "Heart",
        text = {
          "Converts a random card in {C:dark_edition}full deck{}",
          "to {C:hearts}Hearts{}. If it was already {C:hearts}Hearts{},",
          "{C:red}destroy{} the card instead. Triggers {C:attention}twice",
          "for every {C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_diamond = {
        name = "Diamond",
        text = {
          "Converts a random card in {C:dark_edition}full deck{}",
          "to {C:diamond}Diamonds{}. If it was already {C:diamond}Diamonds{},",
          "{C:red}destroy{} the card instead. Triggers {C:attention}twice",
          "for every {C:attention}#4#{} round this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_dollar = {
        name = "Dollar",
        text = {
          "{C:red}Forcefully{} {C:money}sell{} a random {C:attention}Joker{} or",
          "{C:attention}consumable{} for {C:money}#1#x sell value{},",
          "increases by {C:money}1x{} every {C:attention}#4#{} round",
          "{C:inactive}(Forcefully selling bypasses Eternal){}",
          "{C:inactive}({}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_green = {
        name = "Green",
        text = {
          "Create a {C:dark_edition}Negative{}",
          "{C:green}Oops! All 6s{} for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_star = {
        name = "Star",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:rplanbet}Star?{} card for every",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_lilac = {
        name = "Lilac",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:tarot}Tarot{} card for every",
          "{C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_pause = {
        name = "Pause",
        text = {
          "Add {C:attention}1{} round to a all {C:colourcard}Colour{}",
          "cards for every {C:attention}#4#{} rounds this",
          "has been held, then {C:red}Halt{} them all",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_peach = {
        name = "Peach",
        text = {
          "Create a random {C:dark_edition}Negative{}",
          "{C:rotarot}45 Degree Rotated Tarot{} card for",
          "every {C:attention}#4#{} rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_gem = {
        name = "Gem",
        text = {
          "Create a {C:dark_edition}Negative{} {C:spectral}Fervour{}",
          "card for every {C:attention}#4#{} rounds",
          "this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
        },
      },
      
      c_mf_house = {
        name = "House",
        text = {
          "Create a {C:dark_edition}Reference{}",
          "{C:dark_edition}Tag{} for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_loss = {
        name = "Loss",
        text = {
          "Create a {C:dark_edition}Loss{}",
          "for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_prism = {
        name = "Prism",
        text = {
          "Create a {C:dark_edition}Negative{} {C:cry_exotic}Beyond{}",
          "card for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_brackets = {
        name = "Brackets",
        text = {
          "Create a {C:dark_edition}Negative{} {C:cry_code}Code?{}",
          "card for every {C:attention}#4#{}",
          "rounds this has been held",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
    },
    Spectral = {
      c_mf_soul2 = {
        name = "{s:2,E:4}The Soul {s:2,C:red,E:4}2",
        text = {
          "Creates a",
          "{C:dark_edition,s:3,E:1}Superlegendary{}",
          "Joker....",
        }
      }
    },
    Enhanced = {
      m_mf_yucky = {
        name = "Yucky Card",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"be {C:red}destroyed{}",
					"after being scored",
				},
      },
      m_mf_teal = {
        name = "Teal Card",
        text = {
          "{X:chips,C:white} X#1# {} Chips",
          "while this card",
          "stays in hand"
        }
      },
      m_mf_styled = {
        name = "Styled Card",
        text = {
          "Gains a random {C:attention}Seal{}",
          "when drawn to hand"
        }
      },
      m_mf_monus = {
        name = "Monus Card",
        text = {
          "{C:chips}+#1#{} Chips",
          "per hand level"
        }
      },
      m_mf_cult = {
        name = "Cult Card",
        text = {
          "{C:mult}+#1#{} Mult",
          "per hand level"
        }
      },
      m_mf_marigold = {
        name = "Marigold Card",
        text = {
          "Earn {C:money}$#1#{} at",
          "end of round, plus",
          "{C:money}$#1#{} for each other",
          "{C:attention}Marigold Card{} in hand",
        }
      },
      m_mf_brass = {
        name = "Brass Card",
        text = {
          "{C:attention}Retriggers{} #1# additional",
          "times when scored",
					"{C:green}#2# in #3#{} chance to be",
					"{C:red}destroyed{} after being scored",
        }
      },
      m_mf_gemstone = {
        name = "Gemstone Card",
        text = {
          "{C:attention}+$#1#{} when scored",
          "no rank or suit"
        }
      },
    },
    Oddity = {
      c_mf_jimbophone = {
        name = "JimboPhone",
        text = {
          "Create {C:attention}#1#{} {C:mult}Joker{},",
          "does not need room",
          "{C:inactive}(Joker: +4 Mult)"
        },
      },
    },
    Voucher = {
      v_mf_paintroller = {
        name = "Paint Roller",
        text = {
          "{C:green}#1# in 2{} chance to add",
          "{C:attention}1{} round to {C:colourcard}Colour Cards{}",
          "when they gain a round"
        },
      },
      v_mf_colourtheory = {
        name = "Colour Theory",
        text = {
          "Some {C:colourcard}Colour{} cards in",
          "packs are {C:dark_edition}Polychrome{}",
        },
      },
      v_mf_artprogram = {
        name = "Art Program",
        text = {
          "Some {C:colourcard}Colour{} cards in",
          "packs are {C:dark_edition}Negative{}",
        },
      },
      v_mf_superboss_ticket = {
        name = "The Ticket",
        text = {
          "Upgrades {C:attention}Ante #1#{}",
          "{C:inactive,s:0.8}Good luck!{}"
        },
      },
    },
    Back = {
      b_mf_grosmichel = {
        name = "Gros Michel Deck",
        text = {
          "Start run with {C:attention}Gros Michel"
        }
      },
      b_mf_philosophical = {
        name = "Philosophical Deck",
        text = {
          "Start run with 5",
          "{C:attention}Philosophical Jokers"
        }
      },
      b_mf_rainbow = {
        name = "Rainbow Deck",
        text = {
          "Start run with a {C:colourcard}White",
          "{C:colourcard}Colour{} card and the",
          "{C:tarot,T:v_mf_paintroller}Paint Roller{} Voucher",
        }
      },
      b_mf_blasphemy = {
        name = "Blasphemous Deck",
        text = {
          "Start run with a {C:dark_edition}Negative{}",
          "{C:spectral}Eternal{} {C:attention}Blasphemy"
        }
      },
    },
    Other = {
      undiscovered_colour = {
        name = "Not Discovered",
        text = {
          "Purchase or use",
          "this card in an",
          "unseeded run to",
          "learn what it does"
        }
      },
      p_mf_colour_normal_1 = {
        name = "Colour Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:colourcard} Colour{} cards to",
          "add to your consumeables"
        }
      },
      p_mf_colour_normal_2 = {
        name = "Colour Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:colourcard} Colour{} cards to",
          "add to your consumeables"
        }
      },
      p_mf_colour_jumbo_1 = {
        name = "Jumbo Colour Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:colourcard} Colour{} cards to",
          "add to your consumeables"
        }
      },
      p_mf_colour_mega_1 = {
        name = "Mega Colour Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:colourcard} Colour{} cards to",
          "add to your consumeables"
        }
      },
      p_mf_rotarot_normal_1 = {
        name = "45 Degree Rotated Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_rotarot_normal_2 = {
        name = "45 Degree Rotated Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_rotarot_normal_3 = {
        name = "45 Degree Rotated Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_rotarot_normal_4 = {
        name = "45 Degree Rotated Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_rotarot_jumbo_1 = {
        name = "45 Degree Rotated Jumbo Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_rotarot_jumbo_2 = {
        name = "45 Degree Rotated Jumbo Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_rotarot_mega_1 = {
        name = "45 Degree Rotated Mega Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_rotarot_mega_2 = {
        name = "45 Degree Rotated Mega Arcana Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:rotarot}45 Degree Rotated Tarot{}",
          "cards to be used immediately"
        }
      },
      p_mf_modded_normal_1 = {
        name = "Modded Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:dark_edition} Modded Joker{} cards",
        }
      },
      p_mf_modded_normal_2 = {
        name = "Modded Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:dark_edition} Modded Joker{} cards",
        }
      },
      p_mf_modded_jumbo_1 = {
        name = "Jumbo Modded Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:dark_edition} Modded Joker{} cards",
        }
      },
      p_mf_modded_mega_1 = {
        name = "Mega Modded Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:dark_edition} Modded Joker{} cards",
        }
      },
      tetr_explainer = {
        name = "Explanation",
        text = {
          "{X:dark_edition,C:white}^^n{} represents {C:attention}Tetration",
          "In this case, {X:dark_edition,C:white}n^^#1#{} can be",
          "calculated using {X:dark_edition,C:white}n^^#1# = n^n^#2#{}"
        }
      },
			mf_halted = {
				name = "Halted",
				text = {
					"Cannot gain any more {C:attention}Rounds{}"
				},
			},
    },
    Blind = {
      bl_mf_bigger_blind = {
        name = "Bigger Blind",
      },
      bl_mf_violet_vessel_dx = {
        name = "Violet Vessel DX",
        text = {
          "EXTREMELY large blind"
        }
      },
      bl_mf_cerulean_bell_dx = {
        name = "Cerulean Bell DX",
        text = {
          "Forces 3 cards to",
          "always be selected"
        }
      },
      bl_mf_needle_dx = {
        name = "The Needle DX",
        text = {
          "Play only 1 hand,",
          "start with 1 discard"
        }
      },
      bl_mf_manacle_dx = {
        name = "The Manacle DX",
        text = {
          "-3 Hand Size"
        }
      },
      bl_mf_pillar_dx = {
        name = "The Pillar DX",
        text = {
          "Half of all cards played",
          "this run are debuffed"
        }
      },
      bl_mf_serpent_dx = {
        name = "The Serpent DX",
        text = {
          "Only redraw cards when",
          "hand is empty"
        }
      },
      bl_mf_club_dx = {
        name = "The Club DX",
        text = {
          "All non-Club cards",
          "are debuffed"
        }
      },
      bl_mf_goad_dx = {
        name = "The Goad DX",
        text = {
          "All non-Spades cards",
          "are debuffed"
        }
      },
      bl_mf_window_dx = {
        name = "The Window DX",
        text = {
          "All non-Diamonds cards",
          "are debuffed"
        }
      },
      bl_mf_head_dx = {
        name = "The Head DX",
        text = {
          "All non-Hearts cards",
          "are debuffed"
        }
      },
      bl_mf_arm_dx = {
        name = "The Arm DX",
        text = {
          "Set level of played",
          "poker hand to 0"
        }
      },
      bl_mf_wheel_dx = {
        name = "The Wheel DX",
        text = {
          "Only one card is",
          "drawn face up"
        }
      },
      bl_mf_house_dx = {
        name = "The House DX",
        text = {
          "First drawn hand",
          "is discarded"
        }
      },
      bl_mf_psychic_dx = {
        name = "The Psychic DX",
        text = {
          "Must not play 5 cards"
        }
      },
      bl_mf_hook_dx = {
        name = "The Hook DX",
        text = {
          "After hand is played,",
          "discard hand after draw"
        }
      },
    },
    Sleeve = {
      sleeve_mf_grosmichel = {
        name = "Gros Michel Sleeve",
        text = {
          "Start run with {C:attention}Gros Michel"
        }
      },
      sleeve_mf_grosmichel_alt = {
        name = "Gros Michel Sleeve",
        text = {
          "Start run with {C:attention}Cavendish"
        }
      },
      sleeve_mf_philosophical = {
        name = "Philosophical Sleeve",
        text = {
          "Start run with 5",
          "{C:attention}Philosophical Jokers"
        }
      },
      sleeve_mf_philosophical_alt = {
        name = "Philosophical Sleeve",
        text = {
          "Start run with 10",
          "{C:attention}Philosophical Jokers"
        }
      },
      sleeve_mf_rainbow = {
        name = "Rainbow Sleeve",
        text = {
          "Start run with a {C:colourcard}White",
          "{C:colourcard}Colour{} card and the",
          "{C:tarot}Paint Roller{} Voucher",
        }
      },
      sleeve_mf_rainbow_alt = {
        name = "Rainbow Sleeve",
        text = {
          "Start run with the",
          "{C:tarot}Colour Theory{} Voucher",
        }
      },
      sleeve_mf_blasphemy = {
        name = "Blasphemous Sleeve",
        text = {
          "Start run with a {C:dark_edition}Negative{}",
          "{C:spectral}Eternal{} {C:attention}Blasphemy"
        }
      },
      sleeve_mf_blasphemy_alt = {
        name = "Blasphemous Sleeve",
        text = {
          "Start run with a",
          "{C:dark_edition}Negative{} {C:attention}Blasphemy"
        }
      },
    },
    Tag = {
      tag_mf_colour = {
        name = "Painter's Tag",
        text = {
          "Gives a free",
          "{C:colourcard}Jumbo Colour Pack"
        }
      },
      tag_mf_rotarot = {
        name = "Rotarot Tag",
        text = {
          "Gives a free",
          "{C:rotarot}45 Degree Rotated Mega Arcana Pack"
        }
      },
      tag_mf_moddedpack = {
        name = "Modded Tag",
        text = {
          "Gives a free",
          "{C:dark_edition}Jumbo Modded Pack"
        }
      },
      tag_mf_clutch = {
        name = "Clutch Tag",
        text = {
          "{X:mult,C:white}X#1#{} Mult",
          "for the next {C:attention}Blind"
        }
      },
      tag_mf_absolute = {
        name = "Absolute Tag",
        text = {
          "Next shop Joker is free",
          "and becomes {C:dark_edition}Absolute"
        }
      },
      tag_mf_eclutch = {
        name = "{C:gold}Clutch Tag{}",
        text = {
          "{X:dark_edition,C:white}^#1#{} Mult",
          "for the next {C:attention}Blind"
        }
      },
      tag_mf_eabsolute = {
        name = "{C:gold}Absolute Tag{}",
        text = {
          "All shop items are {C:dark_edition}Absolute"
        }
      },
			tag_mf_emoddedpack = {
				name = "{C:gold}Modded Tag{}",
				text = { "Gives a free Editioned", "{C:dark_edition}Jumbo Modded Pack" },
			},
    },
    ComplexityCreep = { -- look having two versions is kind of annoying. oh well
      cc_plusmult = {
        name = "Effect",
        text = {
          "{C:mult}+#1#{} Mult",
          "#2#",
        }
      },
      cc_plusmult_if = {
        name = "Effect",
        text = {
          "{C:mult}+#1#{} Mult",
          "#2#",
          "#3#",
        }
      },
      cc_pluschips = {
        name = "Effect",
        text = {
          "{C:chips}+#1#{} Chips",
          "#2#",
        }
      },
      cc_pluschips_if = {
        name = "Effect",
        text = {
          "{C:chips}+#1#{} Chips",
          "#2#",
          "#3#",
        }
      },
      cc_xmult = {
        name = "Effect",
        text = {
          "{X:mult,C:white}X#1#{} Mult",
          "#2#",
        }
      },
      cc_xmult_if = {
        name = "Effect",
        text = {
          "{X:mult,C:white}X#1#{} Mult",
          "#2#",
          "#3#",
        }
      },
      cc_xchips = {
        name = "Effect",
        text = {
          "{X:chips,C:white}X#1#{} Chips",
          "#2#",
        }
      },
      cc_xchips_if = {
        name = "Effect",
        text = {
          "{X:chips,C:white}X#1#{} Chips",
          "#2#",
          "#3#",
        }
      },
      cc_emult = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^#1#{} Mult",
          "#2#",
        }
      },
      cc_emult_if = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^#1#{} Mult",
          "#2#",
          "#3#",
        }
      },
      cc_echips = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^#1#{} Chips",
          "#2#",
        }
      },
      cc_echips_if = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^#1#{} Chips",
          "#2#",
          "#3#",
        }
      },
      cc_eemult = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^^#1#{} Mult",
          "#2#",
        }
      },
      cc_eemult_if = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^^#1#{} Mult",
          "#2#",
          "#3#",
        }
      },
      cc_eechips = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^^#1#{} Chips",
          "#2#",
        }
      },
      cc_eechips_if = {
        name = "Effect",
        text = {
          "{X:dark_edition,C:white}^^#1#{} Chips",
          "#2#",
          "#3#",
        }
      },
      cc_dollars = {
        name = "Effect",
        text = {
          "Gives {C:money}$#1#{}",
          "#2#",
        }
      },
      cc_dollars_if = {
        name = "Effect",
        text = {
          "Gives {C:money}$#1#{}",
          "#2#",
          "#3#",
        }
      },
      cc_swapchipmult = {
        name = "Effect",
        text = {
          "Swaps {C:chips}Chips{} and {C:mult}Mult{}",
          "#2#",
        }
      },
      cc_swapchipmult_if = {
        name = "Effect",
        text = {
          "Swaps {C:chips}Chips{} and {C:mult}Mult{}",
          "#2#",
          "#3#",
        }
      },
      cc_createtarot = {
        name = "Effect",
        text = {
          "Creates a {C:tarot}Tarot Card",
          "#2#",
        }
      },
      cc_createtarot_if = {
        name = "Effect",
        text = {
          "Creates a {C:tarot}Tarot Card",
          "#2#",
          "#3#",
        }
      },
      cc_createplanet = {
        name = "Effect",
        text = {
          "Creates a {C:planet}Planet Card",
          "#2#",
        }
      },
      cc_createplanet_if = {
        name = "Effect",
        text = {
          "Creates a {C:planet}Planet Card",
          "#2#",
          "#3#",
        }
      },
      cc_copyconsumeable = {
        name = "Effect",
        text = {
          "Creates a {C:dark_edition}Negative{} copy of",
          "{C:attention}1{} random {C:attention}consumable{}",
          "card in your possession",
          "#2#",
        }
      },
      cc_copyconsumeable_if = {
        name = "Effect",
        text = {
          "Creates a {C:dark_edition}Negative{} copy of",
          "{C:attention}1{} random {C:attention}consumable{}",
          "card in your possession",
          "#2#",
          "#3#",
        }
      },
    },
  },
  misc = {
    v_dictionary = { -- uh is this right
      cc_mf_joker_trigger = { "every hand" },
      cc_mf_card_trigger = { "when a card is scored" },
      cc_mf_first_card_trigger = { "when the first card is scored" },
      cc_mf_face_card_trigger = { "when a face card is scored" },
      cc_mf_endofround = { "at end of round" },
      cc_mf_cardsold = { "when a card is sold" },
      cc_mf_shoproll = { "when shop is rerolled" },

      cc_mf_handtype = { "if hand contains a #3#" },
      cc_mf_odds = { "if a #4# in #3# chance passes" },
    },
    v_text = {
      ch_c_mf_superboss_active = { "Superboss is always active" },
    },
    dictionary = {
      k_colour = "Colour",
      b_colour_cards = "Colour Cards",
      k_colour_pack = "Colour Pack",
      k_plus_colour = "+1 Colour",
      k_plus_rotarot = "+1 45 Degree Rotated Tarot Card",
      b_take = "TAKE",
      k_death_caps = "DEATH",
      k_effect_added_ex = "Effect added!",
      k_merged_ex = "Merged!",
      k_swap_ex = "Swap!",
      k_noted_ex = "Noted!",
      k_equals_tree_three = "=TREE(3)",
      k_correct_ex = "Correct!",
      
      k_shape = "Shape?",
      b_shape_cards = "Shape? Cards",
      
      k_rotarot = "45 Degree Rotated Tarot",
      b_rotarot_cards = "45 Degree Rotated Tarot Cards",
      k_rotarot_pack = "45 Degree Rotated Arcana Pack",
      
      k_modded_pack = "Modded Pack",
      
      k_plus_voucher = "+1 Voucher",

      k_display_for_paul = "(for Paul)",
      k_display_for_paul_ex = "(for Paul!)",
      k_display_steel_cards = "Steel Cards",
      k_display_per_round = "per round",
      k_display_lose_all_hands = "(-9999 hands)",
      k_display_only_hearts = "(Only Hearts!)",
      k_display_enhanced = "(Enhanced)",
      k_display_per_voucher = "per Voucher",
      k_display_first_hand = "(first hand)",
      k_display_straight = "(Straight)",
      k_display_modded_joker = "Modded Joker",
      k_display_on_reroll = "(on reroll)",
      k_display_per_hand = "per hand",
      k_display_one_red_card = "(1 red card)",
      k_display_modded = "Modded",
      k_display_hand_size = "Hand Size",
      k_display_joker_slot = "Joker Slot",
      k_display_pack_skipped = "(Pack skipped)",
      k_display_play_debuffed = "(Play debuffed)",
      k_display_flint_and_steel = "(Flint and Steel!)",
      k_display_inactive = "(inactive)",
      k_display_upgrade_ex = "Upgrade!",
      k_display_four_cards = "(Four cards)",
      k_display_marigold_card = "(Marigold cards)",
      k_display_yucky = "(Yucky.)",

      mf_config_features = "Features",

      mf_config_progart = "Art Pack (requires restart)",
      mf_config_disablecred = "Disable Art Credits on cards",
      mf_config_jokers = "Jokers",
      mf_config_music = "Music",
      mf_config_colour_cards = "Colour Cards",
      mf_config_rotarot_cards = "45 Degree Rotated Tarot Cards",
      mf_config_achievements = "Achievements",
      mf_config_unfinished = "Unfinished Content",
      mf_config_huger_joker = "Huger Joker",
      mf_config_superboss = "Superboss",
      mf_config_other_tags = "Other Tags",
      mf_config_other_packs = "Other Packs",
      
      mf_credits = "Credits",
      
      mf_config_maj = "My Awesome Joker",
    },
    labels = {
      colour = "Colour",
      shape = "Shape",
      mf_halted = "Halted",
    },
    achievement_names = {
      ach_mf_ten_colour_rounds = "10-ted",
      ach_mf_whos_paul = "Who's Paul?",
      ach_mf_jank_it_up = "Love that Janker",
      ach_mf_dropkick_ten_hands = "Going Infinite",
      ach_mf_negative_philosophical = "Deux Pipes",
      ach_mf_huge_and_pixel = "Anti-Aliased Allies",
    },
    achievement_descriptions = {
      ach_mf_ten_colour_rounds = 'Have a Colour Card with 10 triggers',
      ach_mf_whos_paul = "Trigger Basepaul Card's stronger effect",
      ach_mf_jank_it_up = "Have three copies of Jankman",
      ach_mf_dropkick_ten_hands = "Trigger Dropkick 5 times in one round",
      ach_mf_negative_philosophical = "Have a Negative Philosophical Joker",
      ach_mf_huge_and_pixel = "Have a Pixel Joker and a Huge Joker",
    },
    challenge_names = {
      c_mf_superboss_always = "Better Balatro II",
    },
  }
}

return loc_stuff