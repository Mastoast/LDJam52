pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
#include object.lua
#include objects.lua
#include runner.lua
#include levels.lua
#include main.lua


--❎🅾️⬆️⬇️⬅️➡️
--█▥░➡️⧗▤⬆️☉🅾️◆
--…★⬇️✽●♥웃⌂⬅️⬅️😐
--∧❎🐱ˇ▒♪
__gfx__
0000000000001111111110000000000000aaaa0000aaaa000000500000000000000000000000000000000000000000009bbb9ee9000000000000000000000000
000000000001111111111110000000000aaaaaaa0aaaaaaa00055a00000000000000000000000000000000000000000059000092000000000000000000000000
0070070000011111111111110000000055ff1fff55ff1fff4405faa0000000000000000000000000000000000000000050000002000000000000000000000000
00077000001111116666661000000000055ff550055ff550c1cffaa0000000000000000000000000000000000000000090000009000000000000000000000000
00077000001111116006006000000000007c7c000ffc7cffcc7f1aa000000000000000000000000000000000000000002000000b000000000000000000000000
007007000111111660060060000000000ff1c1f00ff1c1ffc1c5faa000000000000000000000000000000000000000002000000b000000000000000000000000
000000000111111666666660000000000ffcccf0000ccc444f05fa0000000000000000333333333330000000000000002900009b000000000000000000000000
0000000011111116666666000000000000440440044000004f00fa000000000000000033bbbb333bb0000000000000009ee95599000000000000000000000000
0000000011111116666666000000000033333b330033000000330000000000000000033333333333b00000000000000000000000000000000000000000000000
0000000011111116666660000000000033bbb3bb0003300000033000000000000000033333333333b33000000000000000000000000000000000000000000000
00000000101111116161600000000000333333330008880000000000000000000000003333bbbbb3333300000000000000000000000000000000000000000000
000000001000111111110000000000004494444400888880000000000000000000000333333333b3333300000000000000000000000000000000000000000000
00000000000011111111000000000000444444440088888000000000000000000000033333333333333000000000000000000000000000000000000000000000
0000000000001111111100000000000044444f440008880000000000000000000000033333333333333300000000000000000000000000000000000000000000
00000000000011111111000000000000444444440000000000000000000000000000000033333333033000000000000000000000000000000000000000000000
000000000001111111110000000000004f4444490000000000000000000000000000000000044400000000000000000000000000000000000000000000000000
00000000000111111111000000000000444444440000060000000000000000000000000b00044400000000000000000000000000000000000000000000000000
0000000000011111111100000000000044444444066060000000000000000000000000b000044400000000000000000000000000000000000000000000000000
0000000000011111111100000000000044494444006060000000000000000000000b0b0000044400000000000000000000000000000000000006666660000000
00000000000111111111000000000000444444440066000000000000000000000000b00000044400000000000000000006666660006666600066777776660000
00000000000111111111000000000000444444440033000000000000000000000000000000044400000000000000000067777766667776660677666677776000
00000000000111111111000000000000444444f40033000000330000000000000000000000044400000000000000000067767777767777776777777666777600
00000000000111111111000000000000494444440033000000330000000000000000000000044400000000000000000067767777777777776777777777777660
00000000001111111111000000000000444444440044000000440000000000000000000000044400000000000000000067776666777776777766666667777770
00000000001111111111000000000000000000000000444000000000000000000008000800044400000000000000000007777776666666777777777766667776
00000000001111111111100000000000000000000033330000000000000000000000808000044400000000000000000006677777777777767777777777776776
0000000000111111111110000000000000000000033b3b3000000000000000000000080000044400000000000000000000077776677777767777770777777776
00000000001111111111100000000000000000003b33b3b300000000000000000000808000044400000000000000000000007777666677600007770000777776
00000000001111111111100000000000000000003b33b3b300000000000000000008000800444400000000000000000000000007777766000000000000000000
00000000011111111111100000000000000000003b3333b300000040000000000000000004444440000000000000000000000000000000000000000000000000
000000000111111111111000000000000000000003b33b3000000440000000000000000004444444000000000000000000000000000000000000000000000000
00000000011111111111110000000000000000000003300000004400000000000000000044453354000000000000000000000000000000000000000000000000
00000005500000000000000660000000000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000055550000000000006666000000000000777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000555555000000000066666600000000007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00005555555500000000666666660000000077777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055555555550000006666666666000000777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555555555555000066666666666600007777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555500666666666666660077777777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555556666666666666666777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555000000006666666600000000777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000010000000000020000000000000000000100000000000000010101010000000000000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0c00000000000000000000000000000c0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002e2f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000044450000000000000000000000000000003e3f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000044545445000000000000000000002c2d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000004050505050410000000000000000003c3d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000040505050505050410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000004050505050505050504100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000008090a00000000000000000000000000000000000000000000000000405050505050505050505041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000018191a00000000000000000000000000000000000000000000000040505050505050505050505050410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000390000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414141414141414141414141414141414000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242424000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242424000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242424000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000c000000000000000c000000000000000c000000000000000c000000000000000c00000000
0000003500000000000000350000000000000035000000250000003500000000000000350000002500000000000000250000003500000000000000000025002500250035000000250000003500000025250000350000002500252500000000000000003500002500003500002500003500000025002500002500252500000025
0000003500000000000000000000150000001500000000000000003500000025000000001500000000000035000015000000150000000000000000250000000000000035150000000000003500001500000015000000000000000025000000000000003515000000000000350000150000001500000000000000002500000000
__sfx__
011000000000039600376003760028600292002920029200000003960037600376002860029200292002920000000396003760037600286002920029200292000000039600376003760028600292002920029200
011000001c000000001c000000001c0001c000000001c0001c000000001c000000001c00021000000001c0001c000000001c000000001c0001c000000001c0001c000000001c000000001c0001f0000000021000
05080000134750c455000000000100001000010000000000181651810000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000001c050000001c050000001c0551c050000001c0551c050000001c050000001c05521050000001c0551c050000001c050000001c0551c050000001c0551c050000001c050000001c0501c0301c03300000
031000000007339600376003760028655292002920029200000733960037600376002865500033292002920000073000000000000033286552920000033292000007300033000000003328655292000003328635
011000001c050000001c050000001c0551c050000001c0551c050000001c050000001c05521050000001c0551c050000001c050000001c05523050000001c055230510000021052000001f050210511f0511f053
011000002322023220232222322223222232222322223222000000000000000000002622426220000000000023220232202322223222232222322223222000002322000000212201f2001f220212202120000000
011000001e2201e2201e2221e2221e2221e2221e2221e22200000000000000021224000002322400000000001e2201e2201e2221e2221e2221e2221e2221e222000001c220000001a220000001f2200000000000
011000001c2221c2221c2221c2221c2221c2221c2221c2221e2221e2221e2221e2221e2221e2221e2221e2221f2221f2221f2221f2221f2221f2221f2221f2222322100000262220000023220212202422000000
01100000232212322023222232222322223222232222322223222232222322223222232222322223222232222822000000282200000000000282200000028220272212722227222272222b2212b221000001c521
01100000282212822028220282102821300000000000000000000000001a2211a2201a2201a210172211722017220172101721300000000000000000000000001f200000001f2001f2211f2201f2101f21300000
01100000240271f0271c02718027240271f0271c0271802726027210271e0271a02726027210271e0271a02728027230271f0271c02728027230271f0271c0272f0202f0202f0222f0222f0222f0222f0222f022
031000000c073000700007000070240330007000070000700e073020700207002070260432603302070020701007304070040700407028043040702804328033170730b6400b0000b0730b6400b0730b6400b640
0110000003071030700307403070030700307403070030700f0710f0700f0740f0700f0700f0740f0701002112071120701207412070120701207412070120700307003075060700607504070030710307503075
111000001b5201f52023520215201f5201b520185201b52026520235201f5201c5201b520185201e5201b520215201c510215201c52024000215201c52021520235202352321520215231f5201f5231e5201e523
011000001722117220172201721017213000000000000000000000000015221152201522015210042210422004220042100421300000000000000000000000000000000000000000000000000000000000000000
__music__
01 04034344
00 04054344
00 04030644
00 04050744
00 0c0b0844
00 0d0e0944
00 0c0b0a44
00 0c0b0f44
00 0c0b0a44
04 0c0b0f44

