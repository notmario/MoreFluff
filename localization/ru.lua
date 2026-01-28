-- note: while this is technically listed under the "en-us"
-- language, they will still be called "Colour" cards.
-- ha ha ha.

local art_credit = function (name, forced)
  if mf_config["Programmer Art"] and not forced then return nil end
  if mf_config["Disable Art Credits"] then return nil end
  return "{s:0.8,C:inactive}Арт от: "..name
end

local loc_stuff = {
  descriptions = {
    Joker = {
      j_mf_hugejoker = {
        name = "Огромный джокер",
        text = {
          "{X:red,C:white} X#1# {} множ.",
          "{C:attention}#2#{} к размеру руки"
        },
      },
      j_mf_clownfish = {
        name = "Рыба-клоун",
        text = {
          "{C:attention}Улучшенные{} карты",
          "дают доп. {C:chips}+#1#{} фишек",
          "и {C:mult}+#2#{} множ.",
          "при подсчёте"
        },
      },
      j_mf_badlegaldefence = {
        name = "Никудышная защита",
        text = {
          "Создаёт карту {C:attention}Смерть{} {C:tarot}Таро{},",
          "когда выбран {C:attention}Босс-блайнд{}",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_basepaul_card = {
        name = "Карта Бэйспола",
        text = {
          "{X:mult,C:white} X#1# {} множ. {X:mult,C:white} X#2# {} множ.",
          "вместо этого для {C:red}Пола{}",
          "{C:inactive}(Кто такой Пол?)"
        }
      },
      j_mf_bladedance = {
        name = "Танец клинков",
        text = {
          "Добавляет {C:attention}#1#{} временных",
          "{C:attention}Стальных карт{}",
          "в колоду при выборе",
          "блайнда",
        },
      },
      j_mf_blasphemy = {   
        name = "Богохульство",
        text = {
          "{X:red,C:white} X#1# {} множ.",
          "{C:blue}-#2#{} руки,",
          "когда рука сыграна",
        },
      },
      j_mf_bloodpact = {
        name = "Кровавый пакт",
        text = {
          "{X:mult,C:white} X#1# {} множ.",
          "{C:red}Самоуничтожается{}, если вы играете",
          "карту не масти {C:hearts}Червы{}",
          art_credit("footlongdingledong"),
        }
      },
      j_mf_bowlingball = {
        name = "Шар для боулинга",
        text = {
          "Сыгранные {C:attention}3-ки{}",
          "дают {C:chips}+#1#{} фишек",
          "и {C:mult}+#2#{} множ.",
          "при подсчёте",
          art_credit("footlongdingledong"),
        }
      },
      j_mf_cba = {
        name = "Продвинутый буфер карт",
        text = {
          "Ваш первый джокер с {C:dark_edition}Изданием{}",
          "{C:attention}срабатывает повторно{}",
          "{C:inactive}(ПБК исключён){}"
        }
      },
      j_mf_clipart = {
        name = "Клипарт Джокер",
        text = {
          "Создаёт {C:colourcard}Цветную{} карту,",
          "когда выбран {C:attention}Блайнд{}",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_colorem = {
        name = "Колорем",
        text = {
          "При использовании {C:colourcard}Цветной{} карты,",
          "шанс {C:green}#1# к #2#{} добавить копию",
          "в зону расходников",
          "{C:inactive}(Должно быть место)",
        },
      },
      j_mf_coupon_catalogue = {
        name = "Каталог купонов",
        text = {
          "{C:mult}+#1#{} множ. за каждый",
          "{C:attention}Купон{}, купленный",
          "в этой партии",
          "{C:inactive}(Сейчас {C:mult}+#2#{C:inactive} множ.)",
        }
      },
      j_mf_css = {
        name = "CSS",
        text = {
          "Создаёт случайную {C:colourcard}Цветную",
          "карту, если сыгранная рука",
          "содержит {C:attention}Флеш",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_dramaticentrance = {    
        name = "Эффектное появление",
        text = {
          "{C:chips}+#1#{} фишек",
          "для первой руки",
          "в каждом раунде",
        },
      },
      j_mf_dropkick = {
        name = "Дропкик",
        text = {
          "{C:blue}+#1#{} рука, если рука",
          "содержит {C:attention}Стрит",
        },
      },
      j_mf_expansion_pack = {
        name = "Пакет расширения",
        text = {
          "Когда выбран {C:attention}Блайнд{},",
          "создаёт {C:attention}#1# {C:dark_edition}модифицированного{C:attention} Джокера",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_fleshprison = {
        name = "Тюрьма из плоти",
        text = {
          "{C:red}X#1#{} к размеру {C:attention}Босс-блайнда{}",
          "Когда {C:attention}Босс-блайнд{} побеждён,",
          "{C:red}самоуничтожается{} и создаёт",
          "{C:dark_edition}Негативную{} карту {C:spectral}Душа{}",
        }
      },
      j_mf_fleshpanopticon = {
        name = "Паноптикум из плоти",
        text = {
          "{C:red}X#1#{} к размеру {C:attention}Босс-блайнда{}",
          "Когда {C:attention}Босс-блайнд{} побеждён,",
          "{C:red}самоуничтожается{} и создаёт",
          "{C:dark_edition}Негативную{} карту {C:spectral}Врата{}"
        }
      },
      j_mf_globe = {
        name = "Глобус",
        text = {
          "Создаёт #1# карту {C:planet}Планеты{},",
          "когда вы {C:attention}обновляете{} магазин",
        }
      },
      j_mf_goldencarrot = {
        name = "Золотая морковка",
        text = {
          "Даёт {C:money}$#1#{} в",
          "конце раунда",
          "{C:money}-$#2#{} даётся",
          "за каждую сыгранную руку",
        }
      },
      j_mf_hallofmirrors = {
        name = "Зеркальный зал",
        text = {
          "{C:attention}+#2#{} к размеру руки за",
          "каждую {C:attention}6-ку{}, подсчитанную",
          "в текущем раунде",
          "{C:inactive}(Сейчас {C:attention}+#1#{C:inactive} карт)"
        }
      },
      j_mf_hollow = {
        name = "Полый джокер",
        text = {
          "{C:attention}#1#{} к размеру руки",
          "{C:mult}+#2#{} множ. за каждую карту",
          "в руке ниже размера {C:attention}#3#"
        }
      },
      j_mf_hyperbeam = {
        name = "Гиперлуч",
        text = {
          "{X:red,C:white} X#1# {} множ.",
          "{C:attention}Отнимает все сбросы,",
          "когда выбран {C:attention}Блайнд{}",
        },
      },
      j_mf_impostor = {
        name = "Предатель",
        text = {
          "{X:mult,C:white} X#1# {} множ., если",
          "в сыгранной руке есть",
          "ровно одна {C:red}красная{} карта"
        }
      },
      j_mf_jankman = {
        name = "Джанкмен",
        text = {
          "Все {C:dark_edition}модифицированные{} Джокеры",
          "{C:inactive}(а также Весёлый джокер){}",
          "дают {X:chips,C:white} X#1# {} фишек каждый",
        }
      },
      j_mf_jester = {
        name = "Шут",
        text = {
          "{C:chips,s:1.1}+#1#{} фишек"
        }
      },
      j_mf_loadeddisk = {
        name = "Загруженный диск",
        text = {
          "Создаёт {C:colourcard}Розовую{} и",
          "{C:colourcard}Жёлтую{} {C:colourcard}Цветную{} карту",
          "при продаже",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_lollipop = {
        name = "Леденец",
        text = {
          "{X:mult,C:white} X#1# {} множ.",
          "{X:mult,C:white} -X#2# {} множ. за",
          "каждый сыгранный раунд",
        }
      },
      j_mf_luckycharm = {
        name = "Талисман удачи",
        text = {
          "Шанс {C:green}#1# к #3#{}",
          "дать {C:mult}+#2#{} множ.",
          "Шанс {C:green}#6# к #5#{}",
          "получить {C:money}$#4#",
          "в конце раунда"
        }
      },
      j_mf_mashupalbum = {
        name = "Мэшап-альбом",
        text = {
          "Получает {C:mult}+#3#{} множ., если сыгранная",
          "рука содержит {C:hearts}красный{} флеш",
          "Получает {C:chips}+#4#{} фишек, если сыгранная",
          "рука содержит {C:spades}чёрный{} флеш",
          "{C:inactive}(Сейчас {C:mult}+#1#{C:inactive} и {C:chips}+#2#{C:inactive})"
        },
      },
      j_mf_mspaint = {
        name = "MS Paint Джокер",
        text = {
          "{C:attention}+#1#{} к размеру руки",
          "для первой руки",
          "каждого блайнда"
        },
      },
      j_mf_paintcan = {
        name = "Банка с краской",
        text = {
          "Шанс {C:green}#1# к #2#{} добавить",
          "раунд к {C:colourcard}Цветным картам{},",
          "когда они получают раунд",
        },
      },
      j_mf_pixeljoker = {
        name = "Пиксельный джокер",
        text = {
          "Сыгранные {C:attention}Тузы{},",
          "{C:attention}4-ки{} и {C:attention}9-ки{} дают",
          "{X:mult,C:white} X#1# {} множ. каждая при подсчёте"
        },
      },
      j_mf_philosophical = {
        name = "Философский джокер",
        text = {
          "{C:dark_edition}+#1#{} слот джокера"
        },
      },
      j_mf_rainbowjoker = {
        name = "Радужный джокер",
        text = {
          "{C:colourcard}Цветные{} карты дают",
          "{X:mult,C:white} X#1#{} множ.",
          art_credit("footlongdingledong"),
        },
      },
      j_mf_recycling = {
        name = "Переработка",
        text = {
          "Создаёт случайную карту {C:planet}Планеты{}",
          "или {C:tarot}Таро{},",
          "когда любой {C:attention}Бустерный{}",
          "{C:attention}набор{} пропущен",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_rosetinted = {
        name = "Розовые очки",
        text = {
          "Если {C:attention}первая рука{} раунда —",
          "одиночная {C:attention}2-ка{}, уничтожает её и",
          "создаёт бесплатный {C:attention}Жетон-дубль{}",
        }
      },
      j_mf_simplified = {
        name = "Упрощённый джокер",
        text = {
          "Все {C:blue}Обычные{} джокеры",
          "дают по {C:mult}+#1#{} множ.",
        }
      },
      j_mf_spiral = {
        name = "Спиральный джокер",
        text = {
          "{C:mult}+(#1#+#2#cos(pi/#3# x {C:attention}$${C:mult})){} множ.",
          "{C:inactive}({C:attention}$${C:inactive} — ваши текущие деньги)",
          "{C:inactive}(Сейчас даёт {C:mult}+#4#{C:inactive} множ.)"
        }
      },
      j_mf_stylemeter = {
        name = "Счётчик стиля",
        text = {
          "Даёт {C:money}$#1#{} в конце",
          "раунда за каждый",
          "{C:attention}Блайнд{}, пропущенный в партии",
          "{C:inactive}(Сейчас {C:money}$#2#{C:inactive})"
        }
      },
      j_mf_teacup = {
        name = "Чашка чая",
        text = {
          "Повышает уровень",
          "каждой {C:attention}сыгранной руки{}",
          "следующие {C:attention}#1#{} рук",
        },
      },
      j_mf_the_solo = {
        name = "Соло",
        text = {
          "Получает {X:mult,C:white} X#2# {} множ., если в сыгранной",
          "руке только {C:attention}1{} карта",
          "{C:inactive}(Сейчас {X:mult,C:white} X#1# {C:inactive} множ.)",
        }
      },
      j_mf_tonersoup = {
        name = "Я пью суп из тонера",
        text = {
          "Создаёт карту {C:tarot}Таро{},",
          "когда сыграна рука",
          "Уничтожается при победе",
          "над блайндом",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_treasuremap = {
        name = "Карта сокровищ",
        text = {
          "Спустя {C:attention}#2#{} раундов,",
          "продайте эту карту,",
          "чтобы получить {C:money}$#3#{}",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}/#2#)"
        },
      },
      j_mf_triangle = {
        name = "Треугольник",
        text = {
          "Каждая сыгранная карта даёт",
          "{X:mult,C:white} X#1# {} множ. при подсчёте,",
          "если сыгранная рука —",
          "{C:attention}Сет"
        },
      },
      j_mf_virtual = { 
        name = "Виртуальный джокер",
        text = {
          "{X:red,C:white} X#1# {} множ.",
          "Переворачивает и тасует все",
          "карты Джокеров, когда",
          "выбран блайнд"
        },
      },
      j_mf_marigold = {
        name = "Бархатцы",
        text = {
          "{C:attention}Повторно активирует{} сыгранные и удерживаемые",
          "{C:attention}Карты Бархатцев{} #1# раз(а)",
          art_credit("marigold"),
        },
      },
      j_mf_yuckyrat = { 
        name = "Мерзкая крыса",
        text = {
          "Сыгранные {C:attention}неулучшенные{} карты",
          "превращаются в {C:attention}Мерзкие карты{}.",
          "Получает {X:red,C:white} X#1# {} множ. за",
          "каждую превращённую карту",
          "{C:inactive}(Сейчас {X:red,C:white} X#2# {C:inactive} множ.)"
        },
      },
      j_mf_hyperjimbo = { 
        name = "Гиперджимбо",
        text = {
          "{X:dark_edition,C:white,s:1.4} ^^#1# {s:1.4} фишек",
          "перед подсчётом, если {C:attention}сыгранная рука",
          "содержит ровно {C:attention}4{} карты"
        },
      },
      j_mf_brass = {
        name = "Латунный джокер",
        text = {
          "{C:attention}Повторно активирует{} джокера",
          "справа один раз за каждые",
          "{C:attention}#4# Латунных карт{}, уничтоженных",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        }
      },
      j_mf_allicantdo = {
        name = "Всё, что я не могу",
        text = {
          "{C:red}Ослабляет{} первую взятую руку",
          "Получает {X:red,C:white} X#1# {} множ. за",
          "каждую сыгранную {C:red}ослабленную{} карту",
          "{C:inactive}(Сейчас {X:red,C:white} X#2# {C:inactive})"
        }
      },
      j_mf_tealjoker = {
        name = "Бирюзовый джокер",
        text = {
          "Даёт {X:chips,C:white} X#1# {} фишек",
          "за каждую {C:attention}Бирюзовую карту",
          "в вашей {C:attention}полной колоде",
          "{C:inactive}(Сейчас {X:chips,C:white} X#2# {C:inactive} фишек)",
        }
      },
      j_mf_gemstonejoker = {
        name = "Самоцветный джокер",
        text = {
          "Даёт {C:money}$#1#{} в конце раунда",
          "за каждую {C:attention}Самоцветную карту{}",
          "в вашей {C:attention}полной колоде{}",
          "{C:inactive}(Сейчас {C:money}$#2#{C:inactive})"
        }
      },
      j_mf_top10 = {
        name = "Топ 10 джокеров с первого по десятый",
        text = {
          "Даёт {C:money}$#1#{} в конце раунда",
          "за каждую {C:green}уникальную цифру{}",
          "в ваших {C:attention}текущих деньгах{}",
          "{C:inactive}(Это 0, 1, 2, 3, 4, 5, 6, 7, 8 и 9.)",
        }
      },
      j_mf_junkmail = {
        name = "Спам",
        text = {
          "Создаёт {C:attention}Купон{}, который",
          "стоит в {C:money}#1#x{} дороже в",
          "начале каждого магазина",
        }
      },
      j_mf_stonejokerjoker = {
        name = "Джокер Каменного джокера",
        text = {
          "Создаёт {C:dark_edition}Негативного{}",
          "{C:spectral}Вечного{} {C:attention}Мраморного джокера{}",
          "в конце каждого магазина",
        }
      },
      j_mf_flintandsteel = {
        name = "Огниво",
        text = {
          "Повышает уровень каждой",
          "{C:attention}сыгранной руки{}, если подсчитанная рука содержит",
          "{C:attention}Каменную карту{} и {C:attention}Стальную карту{}",
        }
      },
      j_mf_talljoker = {
        name = "Высокий джокер",
        text = {
          "{C:mult,s:1.1}+#1#{} множ.",
        },
      },
      j_mf_complexitycreep = {
        name = "Ползучая сложность",
        text = {
          "Получает случайный эффект",
          "при появлении и когда",
          "выбран {C:attention}Босс-блайнд"
        },
      },
      j_mf_selfinsert = {
        name = "Камео автора",
        text = {
          "эффект настраивается в параметрах..."
        }
      },
      j_mf_missingjoker = {
        name = "Отсутствующая текстура",
        text = {
          "Превращается в",
          "{C:dark_edition}случайного джокера{} на",
          "время блайнда,",
          "когда выбран блайнд"
        }
      },
      j_mf_rot_cartomancer = {
        name = "Картомант!",
        text = {
          "Создаёт {C:rotarot}Повёрнутую на 45° карту Таро{},",
          "когда выбран {C:attention}Блайнд{}",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_widejoker = {
        name = "Широкий джокер",
        text = {
          "{X:dark_edition,C:white}^#1#{} множ.",
        },
      },
      j_mf_monochrome = {
        name = "Монохромный джокер",
        text = {
          "{C:mult}+#1#{} множ. за каждый раунд",
          "без {C:colourcard}Цветной карты",
          "{C:inactive}(Сейчас {C:mult}+#2#{C:inactive})",
          art_credit("footlongdingledong"),
        }
      },
      j_mf_farmmerge = {
        name = "Долина слияния шуток",
        text = {
          "Сброс ровно {C:attention}3 карт",
          "одного достоинства {C:dark_edition}Сливает",
          "их всех с {C:attention}самой правой",
          "сброшенной картой"
        },
      },
      j_mf_broomcloset = {
        name = "Кладовка",
        text = {
          "{X:mult,C:white}X#1#{} множ., если в последнем",
          "{C:attention}Магазине{} не было покупок",
          "{C:inactive}(Сейчас #2#)"
        },
      },
      j_mf_unregisteredhypercam = { 
        name = "Unregistered Hypercam 2",
        text = {
          "{X:dark_edition,C:white,s:1.4} ^^#1# {s:1.4} множ.",
          "перед подсчётом",
        },
      },
      j_mf_blahaj = { 
        name = "Блохэй",
        text = {
          "Меняет местами {C:chips}Фишки{} и {C:mult}Множ.{}"
        },
      },
      j_mf_wilddrawfour = { 
        name = "Дикие карты: взять четыре",
        text = {
          "{C:attention}+#2#{} к размеру руки за",
          "каждую {C:attention}Дикую карту{}, подсчитанную",
          "в текущем раунде",
          "{C:inactive}(Сейчас {C:attention}+#1#{C:inactive} карт)"
        },
      },
      j_mf_unpleasantcard = { 
        name = "Неприятная карта",
        text = {
          "{X:chips,C:white} X#1# {} фишек",
          "{C:attention}Бустерные наборы{} содержат",
          "только {C:attention}1{} карту"
        },
      },
      j_mf_slotmachine = { 
        name = "Игровой автомат",
        text = {
          "Шанс {C:green}#1# к #2#{} повторно активировать",
          "подсчитанные {C:attention}7-ки{} {C:attention}#3#{} раз(а)",
        },
      },
      j_mf_snake = {
        name = "Змея",
        text = {
          "После {C:attention}игры{} или {C:attention}сброса{},",
          "всегда добирает {C:attention}#1#{} карт(ы)"
        }
      },
      j_mf_bookmove = {
        name = "Книжный ход",
        text = {
          "Спустя {C:attention}#2#{} раундов,",
          "продайте эту карту, чтобы создать",
          "{C:attention}Надорванный бюллетень{} и {C:attention}Фотографию",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}/#2#, должно быть место)"
        },
      },
      j_mf_cueball = {
        name = "Биток",
        text = {
          "Шанс {C:green}#1# к #2#{} для каждой сыгранной",
          "{C:attention}карты без достоинства{} создать",
          "{C:rotarot}Повёрнутую на 45° карту Таро{} при подсчёте",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_blunder = {
        name = "Зевок",
        text = {
          "{X:mult,C:white} X#1# {} множ.",
          "Принуждает выбрать",
          "одну карту"
        },
      },
      j_mf_brilliant = {
        name = "Блестящий ход",
        text = {
          "Если блайнд был побеждён",
          "одной рукой, создаёт",
          "случайную {C:spectral}Спектральную{} карту",
          "{C:inactive}(Должно быть место)"
        },
      },
      j_mf_lessfluff = {
        name = "Меньше воды",
        text = {
          "Уничтожает всех других {C:dark_edition}Модифицированных{} {C:attention}Джокеров{}",
          "в начале каждого {C:attention}Блайнда{}", 
          "и получает {X:mult,C:white} X#2# {} множ. за каждого",
          "уничтоженного {C:attention}Джокера{}",
          "{C:inactive}(Сейчас {X:red,C:white} X#1# {C:inactive})"
        },
      },
      j_mf_sudoku = {
        name = "Судоку джокер",
        text = {
          "{X:mult,C:white} X#1# {} множ., если каждое достоинство от {C:attention}Туза до 9{}",
          "было {C:attention}подсчитано{}, сбрасывается,",
          "когда {C:attention}Босс-блайнд{} {C:red}побеждён",
          "{C:inactive}(Сейчас {V:1}A{C:inactive}, {V:2}2{C:inactive}, {V:3}3{C:inactive}, {V:4}4{C:inactive}, {V:5}5{C:inactive}, {V:6}6{C:inactive}, {V:7}7{C:inactive}, {V:8}8{C:inactive}, {V:9}9{C:inactive})"
        },
      },
      j_mf_sapling = {
        name = "Быстрорастущий саженец",
        text = {
          "Спустя {C:attention}#3#{} раундов,",
          "продайте эту карту, чтобы установить",
          "{C:attention}счёт раунда{} на {s:1.1,C:spectral}TREE(3){}",
          "{C:inactive}(Сейчас #4#, {}[{C:attention}#1#{C:inactive}#2#{}]{C:inactive})",
        }
      },
      j_mf_onesliptoolate = {
        name = "Слишком поздно",
        text = {
          "{X:mult,C:white} xN {} множ., если {C:attention}покерная комбинация{} содержит",
          "ровно {C:attention}N{} карт, где {C:attention}N{} — это",
          "количество сыгранных рук в этом раунде",
          "{C:inactive}(N сейчас равно {C:attention}#1#{C:inactive})",
        }
      },
      j_mf_lightningstrikesthrice = {
        name = "Молния бьёт трижды",
        text = {
          "Повторно активирует эффекты",
          "{C:attention}при сбросе{} {C:attention}#1#{} раз(а)",
        }
      },
      j_mf_friendinsideme = {
        name = "Друг внутри меня",
        text = {
          "Один раз за {C:attention}анте{}, продажа {C:common}Обычного{}",
          "или {C:uncommon}Необычного{} джокера создаёт",
          "джокера следующей редкости",
          "{C:inactive}(Сейчас #1#)"
        }
      },
      j_mf_thewayhome = {
        name = "путь домой",
        text = {
          "Когда {C:attention}блайнд{} {C:attention}выбран{};",
          "шанс {C:green}#1# к #2#{}",
          "получить {C:blue}#3#{} рук(и)"
        }
      },
      j_mf_jackofalltrades = {
        name = "Мастер на все руки",
        text = {
          "Каждый {C:attention}Валет{}, удерживаемый",
          "в руке, даёт {C:mult}+#1#{} множ.,",
          "{C:chips}+#2#{} фишек и {C:money}$#3#"
        },
      },
      j_mf_oopsallfives = {
        name = "Упс! Одни 5-ки",
        text = {
          "Уменьшает все {C:attention}указанные",
          "{C:green,E:1,S:1.1}знаменатели{} на {C:green}1",
          "{C:inactive}(пример: {C:green}1 к 5{C:inactive} -> {C:green}1 к 4{C:inactive})"
        },
      },
      j_mf_passando = {
        name = "Спидран Balatro за 5 минут",
        text = {
          "{X:attention,C:white}X2{} Скорость",
          "Создаёт {C:dark_edition}Негативную{} {C:attention}Диетическую колу",
          "за каждые {C:attention}2{} пропущенных блайнда",
          "{C:inactive}(Сейчас #1#/#2#)"
        },
      },
      j_mf_grep = {
        name = "grep",
        text = {
          "Если в {C:attention}первом сбросе{} раунда",
          "только {C:attention}1{} карта, замешивает",
          "все карты с {C:attention}совпадающим",
          "{C:attention}достоинством или мастью{} на",
          "верх {C:dark_edition}колоды"
        }
      },
      j_mf_forge = {
        name = "Кузница джокеров",
        text = {
          "Создаёт случайного {C:attention}Джокера{}",
          "за каждые",
          "{C:attention}#3# Джокеров{}, проданных вами",
          "{C:inactive}(Сейчас {}[{C:attention}#1#{C:inactive}#2#{}]{C:inactive})",
          art_credit("LFMoth")
        }
      },
      j_mf_forgeslop = {
        name = "Кузнечные отходы",
        text = {
          "Не активирует {C:attention}Кузницу{}",
          "{C:attention}джокеров{} при продаже"
        }
      },
      j_mf_trianglewalker = {
        name = "Треугольник, Мироходец",
        text = {
          {
            "{X:black,C:white} +2 {}: Взять {C:attention}три{} карты",
          },
          {
            "{X:black,C:white} -3 {}: Уничтожить до {C:attention}трёх{} выбранных карт",
          },
          {
            "{X:black,C:white} -11 {}: Сделать до {C:attention}трёх{} выбранных",
            "{C:attention}игральных карт{} {C:dark_edition}Полихромными{}",
          }
        }
      },
      j_mf_mindsculptor = {
        name = "Джимбо, Скульптор разума",
        text = {
          {
            "{X:black,C:white} +2 {}: Взять карту",
          },
          {
            "{X:black,C:white} 0 {}: Взять {C:attention}четыре{} карты, затем {C:green}замешать{}",
            "{C:attention}три{} крайние левые карты из руки в колоду",
          },
          {
            "{X:black,C:white} -1 {}: {C:green}Замешать{} все карты в руке в колоду",
          },
          {
            "{X:black,C:white} -12 {}: {C:red}Уничтожить{} все карты, оставшиеся в колоде",
            art_credit("Ice"),
          },
        }
      },
      j_mf_johnbalatro = {
        name = "Джон Балатро..?",
        text = {
          {
            "{X:black,C:white} +1 {}: Ровно {C:attention}пять{} выбранных {C:attention}игральных карт",
            "без бонусов {C:mult}Множ.{} получают {C:mult}+4{} множ."
          },
          {
            "{X:black,C:white} -11 {}: {C:attention,E:1}Выпустить{} Джона Балатро",
          },
        }
      },
      j_mf_johnbalatrotrue = {
        name = "Джон Балатро",
        text = {
          "{X:dark_edition,C:white,s:1.5}^2{} множ.",
          "перед подсчётом"
        }
      },
      j_mf_dinner = {
        name = "УЖИН!",
        text = {
          "Повторно активирует {C:attention}Джокера",
          "справа следующие",
          "{C:attention}#1#{} раундов"
        }
      },
      j_mf_doubledscale = {
        name = "Удвоенный масштаб",
        text = {
          "{C:attention}Масштабируемые Джокеры{} {C:green,E:1}растут",
          "{C:attention}в два раза{} быстрее",
          art_credit("LFMoth")
        }
      },
      -- ORTALAB SWAPS
      j_mf_clintcondition = {
        name = "Состояние Клинта",
        text = {
          "{X:chips,C:white} X#1# {} фишек. {X:chips,C:white} X#2# {} фишек",
          "вместо этого для {C:chips}Клинта{}",
          "{C:inactive}(Кто такой Клинт?)"
        }
      },
      j_mf_sheetsuggestion = {
        name = "Предложение из таблицы",
        text = {
          "{C:mult,s:1.1}+#1#{} множ.",
          "{C:inactive}(смешной текст)"
        }
      },

      j_mf_devilsknife = {
        name = "Дьявольский нож",
        text = {
          "Создаёт {C:colourcard}Синюю{} и",
          "{C:colourcard}Сиреневую{} {C:colourcard}Цветную{} карту",
          "при продаже",
          "{C:inactive}(Должно быть место)"
        },
      },

      j_mf_twotrucks = {
        name = "Два грузовика",
        text = {
          "Получает {X:chips,C:white} X#1# {} фишек за",
          "каждую уникальную пару в сыгранной руке",
          "{C:inactive}(Сейчас {X:chips,C:white} X#2# {} {C:inactive}фишек)",
        },
      },

      -- FAMILIAR SWAPS
      j_mf_jimbojjoker = {
        name = "Джимбо Дж. Джокер",
        text = {
          "{X:mult,C:white} X#1# {} множ."
        }
      },

      -- FINITY CROSSMOD
      j_mf_theneedle = {
        name = "Игла",
        text = {
          "Когда выбран {C:attention}Блайнд{},",
          "превращает все {C:blue}Руки{} кроме одной",
          "в {C:red}#1# сбросов{} каждую"
        }
      },

      -- THE DEVIOUS THREE WAY CROSSMOD
      j_mf_farmmergecivilisation = {
        name = "Я выживаю в Ферма Слияние Цивилизации",
        text = {
          "В конце раунда {C:dark_edition}Сливает",
          "все карты вместе и превращает",
          "их всех в результат"
        },
      },
    },
    Colour = {
      c_mf_black = {
        name = "Чёрный",
        text = {
          "Добавляет {C:dark_edition}Негатив{} случайному",
          "{C:attention}Джокеру{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_deepblue = {
        name = "Тёмно-синий",
        text = {
          "Превращает случайную карту в",
          "руке в {C:spades}Пики{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_crimson = {
        name = "Малиновый",
        text = {
          "Создаёт {C:red}Редкий жетон{} за",
          "каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_seaweed = {
        name = "Морская водоросль",
        text = {
          "Превращает случайную карту в",
          "руке в {C:clubs}Трефы{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_brown = {
        name = "Коричневый",
        text = {
          "Уничтожает случайную карту в",
          "руке и даёт {C:attention}$#5#{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_grey = {
        name = "Серый",
        text = {
          "Создаёт {C:attention}Жетон-дубль{} за",
          "каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_silver = {
        name = "Серебряный",
        text = {
          "Создаёт {C:dark_edition}Полихромный жетон{} за",
          "каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_white = {
        name = "Белый",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "{C:colourcard}Цветную{} карту за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_red = {
        name = "Красный",
        text = {
          "Превращает случайную карту в",
          "руке в {C:hearts}Червы{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_orange = {
        name = "Оранжевый",
        text = {
          "Превращает случайную карту в",
          "руке в {C:diamonds}Бубны{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_yellow = {
        name = "Жёлтый",
        text = {
          "Получает {C:money}$#5#{} к",
          "{C:attention}стоимости продажи{}",
          "за каждые {C:attention}#4# раундов",
          "{C:inactive}({}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_green = {
        name = "Зелёный",
        text = {
          "Создаёт {C:dark_edition}Негативного{}",
          "{C:green}Упс! Одни 5-ки{} за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_blue = {
        name = "Синий",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "карту {C:planet}Планеты{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_lilac = {
        name = "Сиреневый",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "карту {C:tarot}Таро{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_pink = {
        name = "Розовый",
        text = {
          "Добавляет {C:attention}1{} раунд к случайной",
          "{C:colourcard}Цветной{} карте. Срабатывает раз в",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_peach = {
        name = "Персиковый",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "{C:rotarot}Повёрнутую на 45° карту Таро{} за",
          "каждые {C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_new_gold = {
        name = "Золотой",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:spectral}Душа{}",
          "за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      
      c_mf_purple = {
        name = "Пурпурный",
        text = {
          "Создаёт {C:cry_epic}Эпический жетон{} за",
          "каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_moonstone = {
        name = "Лунный камень",
        text = {
          "Создаёт карту {C:dark_edition}Весёлый джокер{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_gold = {
        name = "Mutare Basi Ludum",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:cry_exotic}Врата{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_ooffoo = {
        name = "00FF00",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:cry_code}Код{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_wordlegreen = {
        name = "Вордли Зелёный",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:green}Алфавит{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_pastelpink = {
        name = "Пастельно-розовый",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {V:1}Глупый{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_royalblue = {
        name = "Королевский синий",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:spectral}Спектральная Печать{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_teal = {
        name = "Бирюзовый",
        text = {
          "Создаёт {C:dark_edition}Негативный{} {C:spectral}Всплеск{}",
          "за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_blank = {
        name = "Пустой",
        text = {
          "Создаёт {C:dark_edition}Негативный{}",
          "{C:spectral}Джокер-студия: Базовый{}",
          "за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_amber = {
        name = "Янтарный",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:G.SP.C.travel_1}Путешествие{}",
          "за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_respiceperprisma = {
        name = "Respice Per Prisma",
        text = {
          "Создаёт {C:dark_edition}Негативную{}",
          "{C:spectral}Рингулярность{} за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("astralightsky")
        },
      },
      c_mf_moss = {
        name = "Мох",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:myth_light}Миф{}",
          "за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_caramel = {
        name = "Карамельный",
        text = {
          "Создаёт {C:dark_edition}Негативное{} {C:bakery}Кондитерское{}",
          "изделие за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
      c_mf_violet = {
        name = "Фиолетовый",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:spectral}Финити{}",
          "за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
          art_credit("Multi")
        },
      },
    },
    Rotarot = {
      c_mf_rot_fool = {
        name = "Дурак!",
        text = {
          "Создаёт последнюю карту",
          "{C:rotarot}Повёрнутого на 45° Таро{} или {C:colourcard}Цветную{} карту,",
          "использованную в этой партии",
          "{s:0.8,C:rotarot}Дурак!{s:0.8} исключён"
        }
      },
      c_mf_rot_magician = {
        name = "Маг!",
        text = {
          "Улучшает {C:attention}#1#{}",
          "выбранные карты",
          "до {C:attention}#2#ок"
        }
      },
      c_mf_rot_high_priestess = {
        name = "Верховная жрица!",
        text = {
          "Создаёт до {C:attention}#1#",
          "случайных {C:colourcard}Цветных{} карт",
          "{C:inactive}(Должно быть место)"
        }
      },
      c_mf_rot_empress = {
        name = "Императрица!",
        text = {
          "Улучшает {C:attention}#1#",
          "выбранные карты",
          "до {C:attention}#2#ок"
        }
      },
      c_mf_rot_emperor = {
        name = "Император!",
        text = {
          "Создаёт до {C:attention}#1#{} случайных",
          "{C:rotarot}Повёрнутых на 45° карт Таро{}",
          "{C:inactive}(Должно быть место)"
        },
      },
      c_mf_rot_heirophant = {
        name = "Иерофант!",
        text = {
          "Улучшает {C:attention}#1#",
          "выбранные карты",
          "до {C:attention}#2#ок"
        }
      },
      c_mf_rot_lovers = {
        name = "Влюблённые!",
        text = {
          "Улучшает {C:attention}#1#{}",
          "выбранные карты",
          "до {C:attention}#2#ок"
        }
      },
      c_mf_rot_chariot = {
        name = "Колесница!",
        text = {
          "Улучшает {C:attention}#1#{} выбранную",
          "карту до",
          "{C:attention}#2#ой"
        }
      },
      c_mf_rot_justice = {
        name = "Справедливость!",
        text = {
          "Улучшает {C:attention}#1#{} выбранную",
          "карту до",
          "{C:attention}#2#ой"
        }
      },
      c_mf_rot_hermit = {
        name = "Отшельник!",
        text = {
          "Устанавливает деньги на следующее",
          "кратное число от {C:money}$#1#",
          "{C:inactive}(Без эффекта на числах кратных {C:money}$#1#{C:inactive})"
        },
      },
      c_mf_rot_wheel = {
        name = "Колесо Фортуны!",
        text = {
          "Шанс {C:green}#1# к #2#{} добавить",
          "случайное {C:negative}издание",
          "случайному {C:attention}Джокеру",
          "{C:inactive}Все издания равновероятны...{}"
        }
      },
      c_mf_rot_strength = {
        name = "Сила!",
        text = {
          "Рандомизирует достоинство до",
          "{C:attention}#1#{} выбранных карт",
        },
      },
      c_mf_rot_hanged_man = {
        name = "Повешенный!",
        text = {
          "Уничтожает {C:attention}#1#{} случайных",
          "карт в руке",
        },
      },
      c_mf_rot_death = {
        name = "Смерть!",
        text = {
          "Выберите {C:attention}#1#{} карты,",
          "превратите {C:attention}все{} выбранные карты",
          "в {C:attention}случайную{} выбранную карту"
        }
      },
      c_mf_rot_temperance = {
        name = "Умеренность!",
        text = {
          "Добавляет {C:money}$#1#{} к {C:attention}стоимости продажи",
          "каждого {C:attention}Джокера{} и",
          "{C:attention}Расходника{}",
        },
      },
      c_mf_rot_devil = {
        name = "Дьявол!",
        text = {
          "Улучшает {C:attention}#1#{}",
          "выбранные карты",
          "до {C:attention}#2#ых"
        }
      },
      c_mf_rot_tower = {
        name = "Башня!",
        text = {
          "Улучшает {C:attention}#1#{} выбранную",
          "карту до",
          "{C:attention}#2#ой"
        }
      },
      c_mf_rot_star = {
        name = "Звезда!",
        text = {
          "Добавляет {C:attention}#1#{} случайных {C:attention}Улучшенных",
          "карт {C:diamonds}Бубен{} в вашу руку"
        }
      },
      c_mf_rot_moon = {
        name = "Луна!",
        text = {
          "Добавляет {C:attention}#1#{} случайных {C:attention}Улучшенных",
          "карт {C:clubs}Треф{} в вашу руку"
        }
      },
      c_mf_rot_sun = {
        name = "Солнце!",
        text = {
          "Добавляет {C:attention}#1#{} случайных {C:attention}Улучшенных",
          "карт {C:hearts}Червей{} в вашу руку"
        }
      },
      c_mf_rot_judgement = {
        name = "Суд!",
        text = {
          "Создаёт случайного",
          "{C:dark_edition}модифицированного{C:attention} Джокера",
          "{C:inactive}(Должно быть место)"
        },
      },
      c_mf_rot_world = {
        name = "Мир!",
        text = {
          "Добавляет {C:attention}#1#{} случайных {C:attention}Улучшенных",
          "карт {C:spades}Пик{} в вашу руку"
        }
      },
    },
    Shape = {
      c_mf_cloud = {
        name = "Облако",
        text = {
          "Создаёт {C:dark_edition}Негативного{}",
          "{C:spectral}Философского джокера{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_spade = {
        name = "Пика",
        text = {
          "Превращает случайную карту в {C:dark_edition}полной колоде{}",
          "в {C:spades}Пики{}. Если она уже была {C:spades}Пики{},",
          "{C:red}уничтожает{} карту. Срабатывает {C:attention}дважды",
          "за каждые {C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_omega = {
        name = "Омега",
        text = {
          "Создаёт {C:dark_edition}Абсолютный жетон{} за",
          "каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_club = {
        name = "Трефа",
        text = {
          "Превращает случайную карту в {C:dark_edition}полной колоде{}",
          "в {C:club}Трефы{}. Если она уже была {C:club}Трефы{},",
          "{C:red}уничтожает{} карту. Срабатывает {C:attention}дважды",
          "за каждые {C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_rectangle = {
        name = "Прямоугольник",
        text = {
          "Добавляет случайную {C:dark_edition}игральную{}",
          "{C:dark_edition}карту{} в руку за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_squircle = {
        name = "Сквиркл",
        text = {
          "Создаёт {C:dark_edition}случайный{} {C:attention}Жетон{} за",
          "каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_arrow = {
        name = "Стрела",
        text = {
          "Создаёт {C:dark_edition}Солнечный жетон{} за",
          "каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_circle = {
        name = "Круг",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "карту {C:shape}Фигуры{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_heart = {
        name = "Черва",
        text = {
          "Превращает случайную карту в {C:dark_edition}полной колоде{}",
          "в {C:hearts}Червы{}. Если она уже была {C:hearts}Червы{},",
          "{C:red}уничтожает{} карту. Срабатывает {C:attention}дважды",
          "за каждые {C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_diamond = {
        name = "Бубна",
        text = {
          "Превращает случайную карту в {C:dark_edition}полной колоде{}",
          "в {C:diamond}Бубны{}. Если она уже была {C:diamond}Бубны{},",
          "{C:red}уничтожает{} карту. Срабатывает {C:attention}дважды",
          "за каждые {C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_dollar = {
        name = "Доллар",
        text = {
          "{C:red}Принудительно{} {C:money}продаёт{} случайного {C:attention}Джокера{} или",
          "{C:attention}расходник{} за {C:money}#1#x стоимости{},",
          "увеличивается на {C:money}1x{} за каждые {C:attention}#4#{} раундов",
          "{C:inactive}(Принудительная продажа игнорирует Вечных){}",
          "{C:inactive}({}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_green = {
        name = "Зелёный",
        text = {
          "Создаёт {C:dark_edition}Негативного{}",
          "{C:green}Упс! Одни 6-ки{} за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_star = {
        name = "Звезда",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "карту {C:purple}Звезда{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_pentagon = {
        name = "Пентагон",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "карту {C:red}Мошенничество{} за каждые",
          "{C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_pause = {
        name = "Пауза",
        text = {
          "Добавляет {C:attention}1{} раунд всем {C:colourcard}Цветным{}",
          "картам за каждые {C:attention}#4#{} раундов удержания",
          "этой карты, затем {C:red}Останавливает{} их всех",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_peach = {
        name = "Персик",
        text = {
          "Создаёт случайную {C:dark_edition}Негативную{}",
          "{C:rotarot}Повёрнутую на 45° карту Таро{} за",
          "каждые {C:attention}#4#{} раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_gem = {
        name = "Самоцвет",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:spectral}Пыл{}",
          "за каждые {C:attention}#4#{} раундов",
          "удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
        },
      },
      
      c_mf_house = {
        name = "Дом",
        text = {
          "Создаёт {C:dark_edition}Жетон{}",
          "{C:dark_edition}Отсылки{} за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_loss = {
        name = "Loss",
        text = {
          "Создаёт {C:dark_edition}Loss{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_prism = {
        name = "Призма",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:cry_exotic}Запредельное{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
      c_mf_brackets = {
        name = "Скобки",
        text = {
          "Создаёт {C:dark_edition}Негативную{} карту {C:cry_code}Код?{}",
          "за каждые {C:attention}#4#{}",
          "раундов удержания этой карты",
          "{C:inactive}(Сейчас {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})"
        },
      },
    },
    Spectral = {
      c_mf_soul2 = {
        name = "{s:2,E:4}Душа {s:2,C:red,E:4}2",
        text = {
          "Создаёт",
          "{C:dark_edition,s:3,E:1}Суперлегендарного{}",
          "Джокера....",
        }
      }
    },
    Enhanced = {
      m_mf_yucky = {
        name = "Мерзкая карта",
				text = {
					"Шанс {C:green}#1# к #2#{}",
					"быть {C:red}уничтоженной{}",
					"после подсчёта",
				},
      },
      m_mf_teal = {
        name = "Бирюзовая карта",
        text = {
          "{X:chips,C:white} X#1# {} фишек,",
          "пока эта карта",
          "остаётся в руке"
        }
      },
      m_mf_styled = {
        name = "Стильная карта",
        text = {
          "Получает случайную {C:attention}Печать{}",
          "когда приходит в руку"
        }
      },
      m_mf_monus = {
        name = "Монусная карта",
        text = {
          "{C:chips}+#1#{} фишек",
          "за каждый уровень руки"
        }
      },
      m_mf_cult = {
        name = "Культистская карта",
        text = {
          "{C:mult}+#1#{} множ.",
          "за каждый уровень руки"
        }
      },
      m_mf_marigold = {
        name = "Карта Бархатцев",
        text = {
          "Даёт {C:money}$#1#{} в",
          "конце раунда, плюс",
          "{C:money}$#1#{} за каждую другую",
          "{C:attention}Карту Бархатцев{} в руке",
        }
      },
      m_mf_brass = {
        name = "Латунная карта",
        text = {
          "{C:attention}Срабатывает повторно{} #1# доп.",
          "раз(а) при подсчёте",
					"Шанс {C:green}#2# к #3#{} быть",
					"{C:red}уничтоженной{} после подсчёта",
        }
      },
      m_mf_gemstone = {
        name = "Самоцветная карта",
        text = {
          "{C:attention}+$#1#{} при подсчёте",
          "нет достоинства или масти"
        }
      },
    },
    Oddity = {
      c_mf_jimbophone = {
        name = "ДжимбоФон",
        text = {
          "Создаёт {C:attention}#1#{} {C:mult}Джокера{},",
          "не требует места",
          "{C:inactive}(Джокер: +4 множ.)"
        },
      },
    },
    Voucher = {
      v_mf_paintroller = {
        name = "Валик",
        text = {
          "Шанс {C:green}#1# к #2#{} добавить",
          "{C:attention}1{} раунд к {C:colourcard}Цветным картам{},",
          "когда они получают раунд"
        },
      },
      v_mf_colourtheory = {
        name = "Теория цвета",
        text = {
          "Некоторые {C:colourcard}Цветные{} карты в",
          "наборах становятся {C:dark_edition}Полихромными{}",
        },
      },
      v_mf_artprogram = {
        name = "Арт-программа",
        text = {
          "Некоторые {C:colourcard}Цветные{} карты в",
          "наборах становятся {C:dark_edition}Негативными{}",
        },
      },
      v_mf_superboss_ticket = {
        name = "Билет",
        text = {
          "Улучшает {C:attention}Анте #1#{}",
          "{C:inactive,s:0.8}Удачи!{}"
        },
      },
    },
    Back = {
      b_mf_grosmichel = {
        name = "Колода Гро-Мишель",
        text = {
          "Старт с картой {C:attention}Гро-Мишель"
        }
      },
      b_mf_philosophical = {
        name = "Философская колода",
        text = {
          "Старт с 5",
          "{C:attention}Философскими джокерами"
        }
      },
      b_mf_rainbow = {
        name = "Радужная колода",
        text = {
          "Старт с {C:colourcard}Белой",
          "{C:colourcard}Цветной{} картой и",
          "купоном {C:tarot,T:v_mf_paintroller}Валик{}",
        }
      },
      b_mf_blasphemy = {
        name = "Богохульная колода",
        text = {
          "Старт с {C:dark_edition}Негативным{}",
          "{C:spectral}Вечным{} {C:attention}Богохульством"
        }
      },
    },
    Stake = {
      stake_mf_pink = {
        name = "Розовая ставка",
        text = {
          "Второй {C:attention}Бустерный набор{}",
          "всегда будет {C:attention}Стандартным набором{}",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
      stake_mf_lime = {
        name = "Лаймовая ставка",
        text = {
          "Требования по очкам растут",
          "быстрее с каждым {C:attention}Анте",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
      stake_mf_steel = {
        name = "Стальная ставка",
        text = {
          "В магазине могут быть {C:attention}Тяжёлые{} джокеры",
          "{C:inactive,s:0.8}(-1 лимит выбора при сбросе)",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
      stake_mf_zodiac = {
        name = "Зодиакальная ставка",
        text = {
          "Старт с {C:attention}Торговцем планетами{},",
          "{C:attention}Торговцем Таро{} и {C:attention}Фокусом",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
      stake_mf_hot = {
        name = "Горячая ставка",
        text = {
          "В магазине могут быть {C:attention}Картофельные{} джокеры",
          "{C:inactive,s:0.8}(Должны быть проданы первыми)",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
      stake_mf_accelerated = {
        name = "Ускоренная ставка",
        text = {
          "Требования по очкам растут намного",
          "быстрее с каждым {C:attention}Анте",
          "{s:0.8}Также включает все предыдущие ставки",
          art_credit("Aikoyori"),
        }
      },
      stake_mf_cardboard = {
        name = "Картонная ставка",
        text = {
          "{C:uncommon}Необычные{} и {C:rare}Редкие{} джокеры",
          "появляются в {C:attention}2x{} раза реже",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
      stake_mf_violet = {
        name = "Фиолетовая ставка",
        text = {
          "Анте 4 имеет {C:dark_edition}Финальный поединок",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
      stake_mf_jimbo = {
        name = "Ставка Джимбо",
        text = {
          "+1 Победное {C:attention}Анте",
          "{s:0.8}Также включает все предыдущие ставки",
        }
      },
    },
    Other = {
      undiscovered_colour = {
        name = "Не обнаружено",
        text = {
          "Купите или используйте",
          "эту карту в партии",
          "без сида, чтобы",
          "узнать, что она делает"
        }
      },
      p_mf_colour_normal_1 = {
        name = "Цветной набор",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:colourcard} Цветных{} карт, чтобы",
          "добавить в расходники"
        }
      },
      p_mf_colour_normal_2 = {
        name = "Цветной набор",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:colourcard} Цветных{} карт, чтобы",
          "добавить в расходники"
        }
      },
      p_mf_colour_jumbo_1 = {
        name = "Цветной набор Джамбо",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:colourcard} Цветных{} карт, чтобы",
          "добавить в расходники"
        }
      },
      p_mf_colour_mega_1 = {
        name = "Цветной мега-набор",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:colourcard} Цветных{} карт, чтобы",
          "добавить в расходники"
        }
      },
      p_mf_rotarot_normal_1 = {
        name = "Повёрнутый на 45° набор аркана",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_rotarot_normal_2 = {
        name = "Повёрнутый на 45° набор аркана",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_rotarot_normal_3 = {
        name = "Повёрнутый на 45° набор аркана",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_rotarot_normal_4 = {
        name = "Повёрнутый на 45° набор аркана",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_rotarot_jumbo_1 = {
        name = "Повёрнутый на 45° набор аркана Джамбо",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_rotarot_jumbo_2 = {
        name = "Повёрнутый на 45° набор аркана Джамбо",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_rotarot_mega_1 = {
        name = "Повёрнутый на 45° мега-набор аркана",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_rotarot_mega_2 = {
        name = "Повёрнутый на 45° мега-набор аркана",
        text = {
          "Выберите {C:attention}#1#{} из {C:attention}#2#",
          "{C:rotarot}Повёрнутых на 45° карт Таро{},",
          "чтобы использовать немедленно"
        }
      },
      p_mf_modded_normal_1 = {
        name = "Модифицированный набор",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:dark_edition} Модифицированных Джокеров{},",
        }
      },
      p_mf_modded_normal_2 = {
        name = "Модифицированный набор",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:dark_edition} Модифицированных Джокеров{},",
        }
      },
      p_mf_modded_jumbo_1 = {
        name = "Модифицированный набор Джамбо",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:dark_edition} Модифицированных Джокеров{},",
        }
      },
      p_mf_modded_mega_1 = {
        name = "Модифицированный мега-набор",
        text = {
          "Выберите {C:attention}#1#{} из",
          "{C:attention}#2#{C:dark_edition} Модифицированных Джокеров{},",
        }
      },
      tetr_explainer = {
        name = "Объяснение",
        text = {
          "{X:dark_edition,C:white}^^n{} представляет {C:attention}Тетрацию",
          "В этом случае, {X:dark_edition,C:white}n^^#1#{} может быть",
          "вычислено как {X:dark_edition,C:white}n^n^#2#{}"
        }
      },
      planeswalker_explainer = {
        name = "Мироходец",
        text = {
          "Стартует с #1# {C:dark_edition}Верности{}.",
          "Раз в раунд вы можете {C:attention}активировать{}",
          "{C:dark_edition}способность{}, изменив {C:dark_edition}Верность{}.",
          "{C:dark_edition}Верность{} не может быть ниже 0.",
        }
      },
			mf_halted = {
				name = "Остановлено",
				text = {
					"Не может получать больше {C:attention}Раундов{}"
				},
			},
			mf_heavy = {
				name = "Тяжёлый",
				text = {
				  "-1 лимит выбора при {C:red}сбросе{}"
				},
			},
			mf_potato = {
				name = "Картофельный",
				text = {
				  "Должен быть продан первым"
				},
			},
    },
    Blind = {
      bl_mf_bigger_blind = {
        name = "Блайнд побольше",
      },
      bl_mf_violet_vessel_dx = {
        name = "Фиолетовый сосуд DX",
        text = {
          "ЧРЕЗВЫЧАЙНО большой блайнд"
        }
      },
      bl_mf_cerulean_bell_dx = {
        name = "Лазурный колокол DX",
        text = {
          "3 карты выбираются",
          "принудительно"
        }
      },
      bl_mf_needle_dx = {
        name = "Игла DX",
        text = {
          "Сыграйте только 1 руку,",
          "старт с 1 сбросом"
        }
      },
      bl_mf_manacle_dx = {
        name = "Кандалы DX",
        text = {
          "-3 к размеру руки"
        }
      },
      bl_mf_pillar_dx = {
        name = "Столп DX",
        text = {
          "Половина всех сыгранных карт",
          "в этой партии ослаблена"
        }
      },
      bl_mf_serpent_dx = {
        name = "Змей DX",
        text = {
          "Добор карт только когда",
          "рука пуста"
        }
      },
      bl_mf_club_dx = {
        name = "Трефа DX",
        text = {
          "Все карты не масти Трефы",
          "ослаблены"
        }
      },
      bl_mf_goad_dx = {
        name = "Стимул DX",
        text = {
          "Все карты не масти Пики",
          "ослаблены"
        }
      },
      bl_mf_window_dx = {
        name = "Окно DX",
        text = {
          "Все карты не масти Бубны",
          "ослаблены"
        }
      },
      bl_mf_head_dx = {
        name = "Голова DX",
        text = {
          "Все карты не масти Червы",
          "ослаблены"
        }
      },
      bl_mf_arm_dx = {
        name = "Рука DX",
        text = {
          "Уровень сыгранной",
          "покерной комбинации равен 0"
        }
      },
      bl_mf_wheel_dx = {
        name = "Колесо DX",
        text = {
          "Только одна карта",
          "тянется лицом вверх"
        }
      },
      bl_mf_house_dx = {
        name = "Дом DX",
        text = {
          "Первая взятая рука",
          "сбрасывается"
        }
      },
      bl_mf_psychic_dx = {
        name = "Экстрасенс DX",
        text = {
          "Нельзя играть 5 карт"
        }
      },
      bl_mf_hook_dx = {
        name = "Крюк DX",
        text = {
          "После сыгранной руки,",
          "сброс руки после добора"
        }
      },
    },
    Sleeve = {
      sleeve_mf_grosmichel = {
        name = "Рукав Гро-Мишель",
        text = {
          "Старт с картой {C:attention}Гро-Мишель"
        }
      },
      sleeve_mf_grosmichel_alt = {
        name = "Рукав Гро-Мишель",
        text = {
          "Старт с картой {C:attention}Кавендиш"
        }
      },
      sleeve_mf_philosophical = {
        name = "Философский рукав",
        text = {
          "Старт с 5",
          "{C:attention}Философскими джокерами"
        }
      },
      sleeve_mf_philosophical_alt = {
        name = "Философский рукав",
        text = {
          "Старт с 10",
          "{C:attention}Философскими джокерами"
        }
      },
      sleeve_mf_rainbow = {
        name = "Радужный рукав",
        text = {
          "Старт с {C:colourcard}Белой",
          "{C:colourcard}Цветной{} картой и",
          "купоном {C:tarot}Валик{}",
        }
      },
      sleeve_mf_rainbow_alt = {
        name = "Радужный рукав",
        text = {
          "Старт с купоном",
          "{C:tarot}Теория цвета{}",
        }
      },
      sleeve_mf_blasphemy = {
        name = "Богохульный рукав",
        text = {
          "Старт с {C:dark_edition}Негативным{}",
          "{C:spectral}Вечным{} {C:attention}Богохульством"
        }
      },
      sleeve_mf_blasphemy_alt = {
        name = "Богохульный рукав",
        text = {
          "Старт с",
          "{C:dark_edition}Негативным{} {C:attention}Богохульством"
        }
      },
    },
    Tag = {
      tag_mf_colour = {
        name = "Жетон художника",
        text = {
          "Даёт бесплатный",
          "{C:colourcard}Цветной набор Джамбо"
        }
      },
      tag_mf_rotarot = {
        name = "Жетон Ротаро",
        text = {
          "Даёт бесплатный",
          "{C:rotarot}Повёрнутый на 45° мега-набор аркана"
        }
      },
      tag_mf_moddedpack = {
        name = "Модифицированный жетон",
        text = {
          "Даёт бесплатный",
          "{C:dark_edition}Модифицированный набор Джамбо"
        }
      },
      tag_mf_clutch = {
        name = "Клатч-жетон",
        text = {
          "{X:mult,C:white}X#1#{} множ.",
          "для следующего {C:attention}Блайнда"
        }
      },
      tag_mf_absolute = {
        name = "Абсолютный жетон",
        text = {
          "Следующий джокер в магазине бесплатен",
          "и становится {C:dark_edition}Абсолютным"
        }
      },
      tag_mf_eclutch = {
        name = "{C:gold}Клатч-жетон{}",
        text = {
          "{X:dark_edition,C:white}^#1#{} множ.",
          "для следующего {C:attention}Блайнда"
        }
      },
      tag_mf_eabsolute = {
        name = "{C:gold}Абсолютный жетон{}",
        text = {
          "Все предметы в магазине {C:dark_edition}Абсолютные"
        }
      },
			tag_mf_emoddedpack = {
				name = "{C:gold}Модифицированный жетон{}",
				text = { "Даёт бесплатный", "{C:dark_edition}Модифицированный набор Джамбо с Изданием" },
			},
    },
    ComplexityCreep = { 
      cc_plusmult = {
        name = "Эффект",
        text = {
          "{C:mult}+#1#{} множ.",
          "#2#",
        }
      },
      cc_plusmult_if = {
        name = "Эффект",
        text = {
          "{C:mult}+#1#{} множ.",
          "#2#",
          "#3#",
        }
      },
      cc_pluschips = {
        name = "Эффект",
        text = {
          "{C:chips}+#1#{} фишек",
          "#2#",
        }
      },
      cc_pluschips_if = {
        name = "Эффект",
        text = {
          "{C:chips}+#1#{} фишек",
          "#2#",
          "#3#",
        }
      },
      cc_xmult = {
        name = "Эффект",
        text = {
          "{X:mult,C:white}X#1#{} множ.",
          "#2#",
        }
      },
      cc_xmult_if = {
        name = "Эффект",
        text = {
          "{X:mult,C:white}X#1#{} множ.",
          "#2#",
          "#3#",
        }
      },
      cc_xchips = {
        name = "Эффект",
        text = {
          "{X:chips,C:white}X#1#{} фишек",
          "#2#",
        }
      },
      cc_xchips_if = {
        name = "Эффект",
        text = {
          "{X:chips,C:white}X#1#{} фишек",
          "#2#",
          "#3#",
        }
      },
      cc_emult = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^#1#{} множ.",
          "#2#",
        }
      },
      cc_emult_if = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^#1#{} множ.",
          "#2#",
          "#3#",
        }
      },
      cc_echips = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^#1#{} фишек",
          "#2#",
        }
      },
      cc_echips_if = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^#1#{} фишек",
          "#2#",
          "#3#",
        }
      },
      cc_eemult = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^^#1#{} множ.",
          "#2#",
        }
      },
      cc_eemult_if = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^^#1#{} множ.",
          "#2#",
          "#3#",
        }
      },
      cc_eechips = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^^#1#{} фишек",
          "#2#",
        }
      },
      cc_eechips_if = {
        name = "Эффект",
        text = {
          "{X:dark_edition,C:white}^^#1#{} фишек",
          "#2#",
          "#3#",
        }
      },
      cc_dollars = {
        name = "Эффект",
        text = {
          "Даёт {C:money}$#1#{}",
          "#2#",
        }
      },
      cc_dollars_if = {
        name = "Эффект",
        text = {
          "Даёт {C:money}$#1#{}",
          "#2#",
          "#3#",
        }
      },
      cc_swapchipmult = {
        name = "Эффект",
        text = {
          "Меняет местами {C:chips}Фишки{} и {C:mult}Множ.{}",
          "#2#",
        }
      },
      cc_swapchipmult_if = {
        name = "Эффект",
        text = {
          "Меняет местами {C:chips}Фишки{} и {C:mult}Множ.{}",
          "#2#",
          "#3#",
        }
      },
      cc_createtarot = {
        name = "Эффект",
        text = {
          "Создаёт {C:tarot}Карту Таро",
          "#2#",
        }
      },
      cc_createtarot_if = {
        name = "Эффект",
        text = {
          "Создаёт {C:tarot}Карту Таро",
          "#2#",
          "#3#",
        }
      },
      cc_createplanet = {
        name = "Эффект",
        text = {
          "Создаёт {C:planet}Карту Планеты",
          "#2#",
        }
      },
      cc_createplanet_if = {
        name = "Эффект",
        text = {
          "Создаёт {C:planet}Карту Планеты",
          "#2#",
          "#3#",
        }
      },
      cc_copyconsumeable = {
        name = "Эффект",
        text = {
          "Создаёт {C:dark_edition}Негативную{} копию",
          "{C:attention}1{} случайного {C:attention}расходника{}",
          "в вашем владении",
          "#2#",
        }
      },
      cc_copyconsumeable_if = {
        name = "Эффект",
        text = {
          "Создаёт {C:dark_edition}Негативную{} копию",
          "{C:attention}1{} случайного {C:attention}расходника{}",
          "в вашем владении",
          "#2#",
          "#3#",
        }
      },
    },
  },
  misc = {
    v_dictionary = { 
      cc_mf_joker_trigger = { "за каждую руку" },
      cc_mf_card_trigger = { "при подсчёте карты" },
      cc_mf_first_card_trigger = { "при подсчёте первой карты" },
      cc_mf_face_card_trigger = { "при подсчёте карты с лицом" },
      cc_mf_endofround = { "в конце раунда" },
      cc_mf_cardsold = { "когда карта продана" },
      cc_mf_shoproll = { "при обновлении магазина" },

      cc_mf_handtype = { "если рука содержит #3#" },
      cc_mf_odds = { "если шанс #4# к #3# срабатывает" },
    },
    v_text = {
      ch_c_mf_superboss_active = { "Супербосс всегда активен" },
    },
    dictionary = {
      k_colour = "Цвет",
      b_colour_cards = "Цветные карты",
      k_colour_pack = "Цветной набор",
      k_plus_colour = "+1 Цвет",
      k_plus_rotarot = "+1 Повёрнутая на 45° карта Таро",
      b_take = "ВЗЯТЬ",
      k_death_caps = "СМЕРТЬ",
      k_effect_added_ex = "Эффект добавлен!",
      k_merged_ex = "Слито!",
      k_swap_ex = "Замена!",
      k_noted_ex = "Записано!",
      k_equals_tree_three = "=TREE(3)",
      k_correct_ex = "Верно!",
      k_searched_ex = "Найдено!",
      k_forged_ex = "Выковано!",
      
      k_shape = "Фигура",
      b_shape_cards = "Карты фигур",
      
      k_rotarot = "Повёрнутое на 45° Таро",
      b_rotarot_cards = "Повёрнутые на 45° карты Таро",
      k_rotarot_pack = "Повёрнутый на 45° набор аркана",
      
      k_modded_pack = "Модифицированный набор",
      
      k_plus_voucher = "+1 Купон",

      k_display_for_paul = "(для Пола)",
      k_display_for_paul_ex = "(для Пола!)",
      k_display_steel_cards = "Стальные карты",
      k_display_per_round = "за раунд",
      k_display_lose_all_hands = "(-9999 рук)",
      k_display_only_hearts = "(Только Червы!)",
      k_display_enhanced = "(Улучшено)",
      k_display_per_voucher = "за купон",
      k_display_first_hand = "(первая рука)",
      k_display_straight = "(Стрит)",
      k_display_modded_joker = "Мод. Джокер",
      k_display_on_reroll = "(при обновлении)",
      k_display_per_hand = "за руку",
      k_display_one_red_card = "(1 красная карта)",
      k_display_modded = "Мод.",
      k_display_hand_size = "Размер руки",
      k_display_joker_slot = "Слот джокера",
      k_display_pack_skipped = "(Набор пропущен)",
      k_display_play_debuffed = "(Игра ослаблена)",
      k_display_flint_and_steel = "(Огниво!)",
      k_display_inactive = "(неактивно)",
      k_display_upgrade_ex = "Улучшение!",
      k_display_four_cards = "(Четыре карты)",
      k_display_marigold_card = "(Карты Бархатцев)",
      k_display_yucky = "(Мерзость.)",

      mf_config_features = "Функции",

      mf_config_progart = "Набор арта (нужен перезапуск)",
      mf_config_disablecred = "Отключить авторов арта на картах",
      mf_config_jokers = "Джокеры",
      mf_config_music = "Музыка",
      mf_config_colour_cards = "Цветные карты",
      mf_config_rotarot_cards = "Повёрнутые на 45° карты Таро",
      mf_config_achievements = "Достижения",
      mf_config_unfinished = "Незавершённый контент",
      mf_config_huger_joker = "Ещё больший джокер",
      mf_config_horse_sound = "Звук лошади",
      mf_config_superboss = "Супербосс",
      mf_config_other_tags = "Другие жетоны",
      mf_config_other_packs = "Другие наборы",
      
      mf_credits = "Авторы",
      
      mf_config_maj = "Мой классный джокер",
    },
    labels = {
      colour = "Цвет",
      shape = "Фигура",
      mf_halted = "Остановлено",
      mf_heavy = "Тяжёлый",
      mf_potato = "Картофельный",
    },
    achievement_names = {
      ach_mf_ten_colour_rounds = "10-кратный",
      ach_mf_whos_paul = "Кто такой Пол?",
      ach_mf_jank_it_up = "Люблю этот Джанк",
      ach_mf_dropkick_ten_hands = "В бесконечность",
      ach_mf_negative_philosophical = "Две трубки",
      ach_mf_huge_and_pixel = "Союзники без сглаживания",
    },
    achievement_descriptions = {
      ach_mf_ten_colour_rounds = 'Иметь Цветную карту с 10 срабатываниями',
      ach_mf_whos_paul = "Активировать сильный эффект Карты Бэйспола",
      ach_mf_jank_it_up = "Иметь три копии Джанкмена",
      ach_mf_dropkick_ten_hands = "Активировать Дропкик 5 раз за один раунд",
      ach_mf_negative_philosophical = "Иметь Негативного Философского джокера",
      ach_mf_huge_and_pixel = "Иметь Пиксельного джокера и Огромного джокера",
    },
    challenge_names = {
      c_mf_superboss_always = "Better Balatro II",
    },
  }
}

return loc_stuff