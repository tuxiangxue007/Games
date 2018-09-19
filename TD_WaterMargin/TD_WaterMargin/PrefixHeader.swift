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
let TD_TowerCategory            : UInt32 = 0x1 << 2                     //防御塔
let TD_MonsterCategory          : UInt32 = 0x1 << 3                     //怪物
let TD_TowerAttackCategory      : UInt32 = 0x1 << 4                     //防御塔攻击范围
let TD_AlertCategory            : UInt32 = 0x1 << 5                     //怪物警戒范围
let TD_AttackCategory           : UInt32 = 0x1 << 6                     //怪物攻击范围

//struct PhysicsCategory {
//    static let Crocodile: UInt32 = 1
//    static let VineHolder: UInt32 = 2
//    static let Vine: UInt32 = 4
//    static let Prize: UInt32 = 8
//}


let TD_Name_Clearing = "clearing"                       //空地
let TD_Name_Tower = "tower"                             //防御塔
let TD_Name_ScopeAttack = "scopeAttack"                 //防御塔攻击范围
let TD_Name_CountdownLab = "countdownLab"               //出怪倒计时Lab
let TD_Name_HPLab = "HPLab"                             //关卡血量显示Lab
let TD_Name_EnergyLab = "energyLab"                     //出怪倒计时Lab
let TD_Name_ConfirmItem = "confirm"                     //确认建造按钮
let TD_Name_CancelItem = "cancel"                       //取消建造按钮
let TD_Name_UpgradeItem = "upgrade"                     //升级建筑按钮
let TD_Name_SellItem = "sell"                           //卖出建筑按钮
let TD_Name_ReturnItem = "return"                       //返回按钮


