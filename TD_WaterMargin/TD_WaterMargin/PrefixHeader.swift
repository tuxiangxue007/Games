//
//  PrefixHeader.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit

let TD_Screen = UIScreen.main.bounds.size
let TD_ScreenW = TD_Screen.width
let TD_ScreenH = TD_Screen.height

let TD_Block_Width = (TD_ScreenW - 10 * 2) / 19.0


let TD_Game_TopClearance = (TD_ScreenH - TD_Block_Width * 9) / 2.0
//let TD_Block_Height = (TD_ScreenH - 10 * 2) / 9.0



let TD_SpriteName_ZS = "战士"
let TD_SpriteName_GJS = "弓箭手"
let TD_SpriteName_QB = "骑兵"
let TD_SpriteName_KZS = "狂战士"
let TD_SpriteName_TL = "统领"

let TD_SpriteType_ZS = 1
let TD_SpriteType_GJS = 2
let TD_SpriteType_QB = 3
let TD_SpriteType_KZS = 4
let TD_SpriteType_TL = 5



let TD_Attack_ZS = ["roundness","attack"]


let TD_MoveToTower = "TD_MoveToTower"       //移动到指定城堡 action key
let TD_MoveToSprite = "TD_MoveToSprite"     //移动到指定士兵 action key





//TD_WorldCategory
let TD_WorldCategory            : UInt32 = 0x1 << 1                     //屏幕边缘
let TD_RoadCategory             : UInt32 = 0x1 << 2                     //道路边缘
let TD_TowerCategory            : UInt32 = 0x1 << 3                     //城堡
let TD_Soldier1Category         : UInt32 = 0x1 << 4                     //士兵(我方)
let TD_Soldier2Category         : UInt32 = 0x1 << 5                     //士兵(敌方)
let TD_AlertCategory            : UInt32 = 0x1 << 6                     //警戒范围
let TD_AttackCategory           : UInt32 = 0x1 << 7                     //攻击范围

//struct PhysicsCategory {
//    static let Crocodile: UInt32 = 1
//    static let VineHolder: UInt32 = 2
//    static let Vine: UInt32 = 4
//    static let Prize: UInt32 = 8
//}



