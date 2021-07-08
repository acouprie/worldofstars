module BuildingsHelper
  SOLAR_NAME = 'Centrale solaire'.freeze
  SOLAR = [
    { lvl: 1, metal_price: 50, food_price: 25, production: 55, time_to_build: 90 },
    { lvl: 2, metal_price: 75, food_price: 37, production: 108, time_to_build: 171 },
    { lvl: 3, metal_price: 112, food_price: 56, production: 161, time_to_build: 325 },
    { lvl: 4, metal_price: 168, food_price: 84, production: 214, time_to_build: 617 },
    { lvl: 5, metal_price: 253, food_price: 126, production: 267, time_to_build: 1172 },
    { lvl: 6, metal_price: 379, food_price: 189, production: 320, time_to_build: 2228 },
    { lvl: 7, metal_price: 569, food_price: 284, production: 373, time_to_build: 4234 },
    { lvl: 8, metal_price: 854, food_price: 427, production: 426, time_to_build: 8045 },
    { lvl: 9, metal_price: 1281, food_price: 640, production: 479, time_to_build: 15285 },
    { lvl: 10, metal_price: 1922, food_price: 961, production: 532, time_to_build: 29042 },
    { lvl: 11, metal_price: 2883, food_price: 1441, production: 585, time_to_build: 55179 },
    { lvl: 12, metal_price: 4324, food_price: 2162, production: 638, time_to_build: 104841 },
    { lvl: 13, metal_price: 6487, food_price: 3243, production: 691, time_to_build: 199198 }
  ].freeze

  FARM_NAME = 'Champs'.freeze
  FARM = [
    { lvl: 1, food_price: 50, metal_price: 60, conso_power: 22, production: 18, time_to_build: 53 },
    { lvl: 2, food_price: 75, metal_price: 90, conso_power: 46, production: 21, time_to_build: 95 },
    { lvl: 3, food_price: 112, metal_price: 135, conso_power: 70, production: 51, time_to_build: 170 },
    { lvl: 4, food_price: 168, metal_price: 202, conso_power: 94, production: 93, time_to_build: 306 },
    { lvl: 5, food_price: 253, metal_price: 303, conso_power: 118, production: 149, time_to_build: 551 },
    { lvl: 6, food_price: 379, metal_price: 405, conso_power: 142, production: 223, time_to_build: 992 },
    { lvl: 7, food_price: 569, metal_price: 683, conso_power: 166, production: 322, time_to_build: 1785 },
    { lvl: 8, food_price: 854, metal_price: 1025, conso_power: 190, production: 451, time_to_build: 3214 },
    { lvl: 9, food_price: 1281, metal_price: 1537, conso_power: 214, production: 619, time_to_build: 5785 },
    { lvl: 10, food_price: 1922, metal_price: 2306, conso_power: 238, production: 835, time_to_build: 10414 },
    { lvl: 11, food_price: 2883, metal_price: 3459, conso_power: 262, production: 1114, time_to_build: 18745 },
    { lvl: 12, food_price: 4324, metal_price: 5189, conso_power: 286, production: 1471, time_to_build: 33740 },
    { lvl: 13, food_price: 6487, metal_price: 7784, conso_power: 310, production: 1925, time_to_build: 60734 },
    { lvl: 14, food_price: 9730, metal_price: 11677, conso_power: 334, production: 2503, time_to_build: 109320 },
    { lvl: 15, food_price: 14596, metal_price: 17515, conso_power: 358, production: 3235, time_to_build: 196777 },
    { lvl: 16, food_price: 21894, metal_price: 26273, conso_power: 382, production: 4159, time_to_build: 354198 },
    { lvl: 17, food_price: 32842, metal_price: 45978, conso_power: 406, production: 5324, time_to_build: 637557 },
    { lvl: 18, food_price: 49263, metal_price: 68968, conso_power: 430, production: 6788, time_to_build: 1147604 },
    { lvl: 19, food_price: 73894, metal_price: 88673, conso_power: 454, production: 8625, time_to_build: 2065686 },
    { lvl: 20, food_price: 110841, metal_price: 133010, conso_power: 478, production: 10926, time_to_build: 3718235 }
  ].freeze

  METAL_NAME = 'Mine de métaux'.freeze
  METAL = [
      { lvl: 1, food_price: 20, metal_price: 60, conso_power: 11, production: 24, time_to_build: 53 },
      { lvl: 2, food_price: 30, metal_price: 105, conso_power: 46, production: 57, time_to_build: 95 },
      { lvl: 3, food_price: 45, metal_price: 157, conso_power: 70, production: 103, time_to_build: 170 },
      { lvl: 4, food_price: 67, metal_price: 236, conso_power: 94, production: 165, time_to_build: 306 },
      { lvl: 5, food_price: 101, metal_price: 354, conso_power: 118, production: 248, time_to_build: 551 },
      { lvl: 6, food_price: 151, metal_price: 531, conso_power: 142, production: 358, time_to_build: 992 },
      { lvl: 7, food_price: 227, metal_price: 797, conso_power: 16, production: 501, time_to_build: 1785 },
      { lvl: 8, food_price: 341, metal_price: 1196, conso_power: 190, production: 687, time_to_build: 3214 },
      { lvl: 9, food_price: 512, metal_price: 1794, conso_power: 214, production: 928, time_to_build: 5785 },
      { lvl: 10, food_price: 768, metal_price: 2691, conso_power: 238, production: 1238, time_to_build: 10414 },
      { lvl: 11, food_price: 1153, metal_price: 4036, conso_power: 262, production: 1634, time_to_build: 18745 },
      { lvl: 12, food_price: 1729, metal_price: 6054, conso_power: 286, production: 2139, time_to_build: 33740 },
      { lvl: 13, food_price: 2594, metal_price: 9082, conso_power: 310, production: 2781, time_to_build: 60734 },
      { lvl: 14, food_price: 3892, metal_price: 13623, conso_power: 334, production: 3594, time_to_build: 109320 },
      { lvl: 15, food_price: 5838, metal_price: 20435, conso_power: 358, production: 4622, time_to_build: 196777 },
      { lvl: 16, food_price: 8757, metal_price: 30652, conso_power: 382, production: 5916, time_to_build: 354198 },
      { lvl: 17, food_price: 13136, metal_price: 45978, conso_power: 406, production: 7543, time_to_build: 637557 },
      { lvl: 18, food_price: 19705, metal_price: 68968, conso_power: 430, production: 9584, time_to_build: 1147604 },
      { lvl: 19, food_price: 29557, metal_price: 103452, conso_power: 454, production: 12140, time_to_build: 2065686 },
      { lvl: 20, food_price: 44336, metal_price: 155178, conso_power: 478, production: 15355, time_to_build: 3718235 }
  ].freeze

  THORIUM_NAME = 'Mine de thorium'.freeze
  THORIUM = [
    { lvl: 1, metal_price: 50, food_price: 40, conso_power: 22, production: 18, time_to_build: 53 },
    { lvl: 2, metal_price: 75, food_price: 60, conso_power: 46, production: 43, time_to_build: 95 },
    { lvl: 3, metal_price: 112, food_price: 90, conso_power: 70, production: 77, time_to_build: 170 },
    { lvl: 4, metal_price: 168, food_price: 135, conso_power: 94, production: 124, time_to_build: 306 },
    { lvl: 5, metal_price: 253, food_price: 202, conso_power: 118, production: 186, time_to_build: 551 },
    { lvl: 6, metal_price: 379, food_price: 303, conso_power: 142, production: 268, time_to_build: 992 },
    { lvl: 7, metal_price: 569, food_price: 455, conso_power: 166, production: 376, time_to_build: 1785 },
    { lvl: 8, metal_price: 854, food_price: 683, conso_power: 190, production: 515, time_to_build: 3214 },
    { lvl: 9, metal_price: 1281, food_price: 1025, conso_power: 214, production: 696, time_to_build: 5785 },
    { lvl: 10, metal_price: 1922, food_price: 1537, conso_power: 238, production: 928, time_to_build: 10414 },
    { lvl: 11, metal_price: 2883, food_price: 2306, conso_power: 262, production: 1225, time_to_build: 18745 },
    { lvl: 12, metal_price: 4324, food_price: 3459, conso_power: 286, production: 1604, time_to_build: 33740 },
    { lvl: 13, metal_price: 6487, food_price: 5189, conso_power: 310, production: 2086, time_to_build: 60734 },
    { lvl: 14, metal_price: 9730, food_price: 7784, conso_power: 334, production: 2696, time_to_build: 109320 },
    { lvl: 15, metal_price: 14596, food_price: 11677, conso_power: 358, production: 3466, time_to_build: 196777 },
    { lvl: 16, metal_price: 21894, food_price: 17515, conso_power: 382, production: 4437, time_to_build: 354198 },
    { lvl: 17, metal_price: 32842, food_price: 26273, conso_power: 406, production: 5657, time_to_build: 637557 },
    { lvl: 18, metal_price: 49263, food_price: 39410, conso_power: 430, production: 7188, time_to_build: 1147604 },
    { lvl: 19, metal_price: 73894, food_price: 59115, conso_power: 454, production: 9105, time_to_build: 2065686 },
    { lvl: 20, metal_price: 110841, food_price: 88673, conso_power: 478, production: 11501, time_to_build: 3718235 }
  ].freeze

  HEADQUARTER_NAME = 'Centre de commandement'.freeze
  HEADQUARTER = [
    { lvl: 1, metal_price: 600, food_price: 150, thorium_price: 300, time_to_build: 15 },
    { lvl: 2, metal_price: 1260, food_price: 315, thorium_price: 630, time_to_build: 428 },
    { lvl: 3, metal_price: 2646, food_price: 661, thorium_price: 1323, time_to_build: 812 },
    { lvl: 4, metal_price: 5556, food_price: 1389, thorium_price: 2778, time_to_build: 1543 },
    { lvl: 5, metal_price: 11668, food_price: 2917, thorium_price: 5834, time_to_build: 2932 },
    { lvl: 6, metal_price: 24504, food_price: 6126, thorium_price: 12252, time_to_build: 5571 },
    { lvl: 7, metal_price: 51549, food_price: 12864, thorium_price: 25729, time_to_build: 10585 },
    { lvl: 8, metal_price: 108865, food_price: 27016, thorium_price: 54032, time_to_build: 20112 },
    { lvl: 9, metal_price: 226937, food_price: 56734, thorium_price: 113468, time_to_build: 38213 },
    { lvl: 10, metal_price: 476568, food_price: 119142, thorium_price: 238284, time_to_build: 72605 },
    { lvl: 11, metal_price: 1000792, food_price: 250168, thorium_price: 500396, time_to_build: 137948 },
    { lvl: 12, metal_price: 2101665, food_price: 525416, thorium_price: 1050832, time_to_build: 262103 },
    { lvl: 13, metal_price: 4413496, food_price: 1103374, thorium_price: 2206748, time_to_build: 434276 }
  ].freeze

  TRAIN_CAMP_NAME = "Camp d'entrainement".freeze
  TRAIN_CAMP = [
      { lvl: 1, metal_price: 250, food_price: 250, thorium_price: 100, time_to_build: 45 },
      { lvl: 2, metal_price: 500, food_price: 500, thorium_price: 128, time_to_build: 86 },
      { lvl: 3, metal_price: 1000, food_price: 1000, thorium_price: 400, time_to_build: 162 },
      { lvl: 4, metal_price: 1344, food_price: 1344, thorium_price: 800, time_to_build: 308 },
      { lvl: 5, metal_price: 2688, food_price: 4000, thorium_price: 1024, time_to_build: 1114 },
      { lvl: 6, metal_price: 5376, food_price: 5376, thorium_price: 2048, time_to_build: 2030 },
      { lvl: 7, metal_price: 10752, food_price: 10752, thorium_price: 4092, time_to_build: 2717 },
      { lvl: 8, metal_price: 21504, food_price: 21504, thorium_price: 8192, time_to_build: 4022 },
      { lvl: 9, metal_price: 43008, food_price: 43008, thorium_price: 16384, time_to_build: 7646 },
      { lvl: 10, metal_price: 86016, food_price: 86016, thorium_price: 32768, time_to_build: 14521 }
  ].freeze

  CAMP_NAME = "Camp militaire".freeze
  CAMP = [
      { lvl: 1, metal_price: 300, food_price: 200, thorium_price: 150, time_to_build: 45 },
      { lvl: 2, metal_price: 600, food_price: 400, thorium_price: 300, time_to_build: 86 },
      { lvl: 3, metal_price: 1200, food_price: 800, thorium_price: 600, time_to_build: 162 },
      { lvl: 4, metal_price: 2400, food_price: 1600, thorium_price: 1200, time_to_build: 308 },
      { lvl: 5, metal_price: 4800, food_price: 3200, thorium_price: 2400, time_to_build: 1114 },
      { lvl: 6, metal_price: 9600, food_price: 6400, thorium_price: 4800, time_to_build: 2030 },
      { lvl: 7, metal_price: 19200, food_price: 12800, thorium_price: 9600, time_to_build: 2717 },
      { lvl: 8, metal_price: 38400, food_price: 25600, thorium_price: 19200, time_to_build: 4022 },
      { lvl: 9, metal_price: 76800, food_price: 51200, thorium_price: 38400, time_to_build: 7646 },
      { lvl: 10, metal_price: 153600, food_price: 102400, thorium_price: 76800, time_to_build: 14521 }
  ].freeze

  # TODO, do the next 10 levels
  STOCK_FOOD_NAME = 'Entrepôt de nourriture'.freeze
  STOCK_FOOD = [
      { lvl: 1, metal_price: 65, food_price: 65, production: 21000, time_to_build: 49 },
      { lvl: 2, metal_price: 97, food_price: 97, production: 28000, time_to_build: 92 },
      { lvl: 3, metal_price: 146, food_price: 146, production: 47000, time_to_build: 176 },
      { lvl: 4, metal_price: 219, food_price: 219, production: 84000, time_to_build: 262 },
      { lvl: 5, metal_price: 329, food_price: 329, production: 145000, time_to_build: 635 },
      { lvl: 6, metal_price: 493, food_price: 493, production: 236000, time_to_build: 1207 },
      { lvl: 7, metal_price: 740, food_price: 740, production: 363000, time_to_build: 2293 },
      { lvl: 8, metal_price: 1110, food_price: 1110, production: 532000, time_to_build: 4358 },
      { lvl: 9, metal_price: 1665, food_price: 1665, production: 749000, time_to_build: 8279 },
      { lvl: 10, metal_price: 2498, food_price: 2498, production: 1020000, time_to_build: 15731 }
  ].freeze

  STOCK_METAL_NAME = 'Entrepôt de metal'.freeze
  STOCK_METAL = [
      { lvl: 1, metal_price: 100, food_price: 30, production: 21000, time_to_build: 49 },
      { lvl: 2, metal_price: 150, food_price: 45, production: 28000, time_to_build: 92 },
      { lvl: 3, metal_price: 225, food_price: 67, production: 47000, time_to_build: 176 },
      { lvl: 4, metal_price: 337, food_price: 101, production: 84000, time_to_build: 262 },
      { lvl: 5, metal_price: 506, food_price: 151, production: 145000, time_to_build: 635 },
      { lvl: 6, metal_price: 759, food_price: 227, production: 236000, time_to_build: 1207 },
      { lvl: 7, metal_price: 1139, food_price: 341, production: 363000, time_to_build: 2293 },
      { lvl: 8, metal_price: 1708, food_price: 512, production: 532000, time_to_build: 4358 },
      { lvl: 9, metal_price: 2562, food_price: 768, production: 749000, time_to_build: 8279 },
      { lvl: 10, metal_price: 3844, food_price: 1153, production: 1020000, time_to_build: 15731 }
  ].freeze

  STOCK_THORIUM_NAME = 'Entrepôt de thorium'.freeze
  STOCK_THORIUM = [
      { lvl: 1, metal_price: 30, food_price: 100, production: 21000, time_to_build: 49 },
      { lvl: 2, metal_price: 45, food_price: 150, production: 28000, time_to_build: 92 },
      { lvl: 3, metal_price: 67, food_price: 225, production: 47000, time_to_build: 176 },
      { lvl: 4, metal_price: 101, food_price: 337, production: 84000, time_to_build: 262 },
      { lvl: 5, metal_price: 151, food_price: 506, production: 145000, time_to_build: 635 },
      { lvl: 6, metal_price: 227, food_price: 759, production: 236000, time_to_build: 1207 },
      { lvl: 7, metal_price: 341, food_price: 1139, production: 363000, time_to_build: 2293 },
      { lvl: 8, metal_price: 512, food_price: 1708, production: 532000, time_to_build: 4358 },
      { lvl: 9, metal_price: 768, food_price: 2562, production: 749000, time_to_build: 8279 },
      { lvl: 10, metal_price: 1153, food_price: 3844, production: 1020000, time_to_build: 15731 }
  ].freeze
end
