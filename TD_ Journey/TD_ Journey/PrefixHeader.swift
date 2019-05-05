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


let TD_Scene_OrSoClearance = CGFloat(60.0)
let TD_Block_Width = (TD_ScreenW - TD_Scene_OrSoClearance * 2) / 12.0

let TD_Block_AspectRatio = CGFloat(4.0 / 3)
let TD_Block_Height = TD_Block_Width * TD_Block_AspectRatio
//let TD_topClearance = (TD_ScreenH - CGFloat(maxLine) * TD_Block_Height - 50) / 2.0
let TD_Game_TopClearance = (TD_ScreenH - CGFloat(5) * TD_Block_Height - 50) / 2.0

let TD_MAX_Scenario = 10



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
let TD_WorldCategory            : UInt32 = 0x1 << 1                     //战场边缘
let TD_OurHeroHomeCategory      : UInt32 = 0x1 << 2                     //我方英雄主场范围
let TD_EnemyHeroHomeCategory    : UInt32 = 0x1 << 3                     //敌方英雄主场范围
let TD_OurCartCategory          : UInt32 = 0x1 << 4                     //我方卡片
let TD_EnemyCartCategory        : UInt32 = 0x1 << 5                     //敌方卡片  32
let TD_OurCartAttackCategory    : UInt32 = 0x1 << 6                     //我方卡片攻击范围
let TD_EnemyCartAttackCategory  : UInt32 = 0x1 << 7                     //敌方卡片攻击范围
let TD_OurHeroCategory          : UInt32 = 0x1 << 8                     //我方英雄 256
let TD_EnemyHeroCategory        : UInt32 = 0x1 << 9                     //敌方英雄


//let TD_EnergyBallCategory       : UInt32 = 0x1 << 7                     //敌方卡片攻击范围


//contactTestBitMask
let TD_OurCartContactTestBitMask            = TD_EnemyHeroHomeCategory | TD_EnemyCartAttackCategory
let TD_EnemyCartContactTestBitMask          = TD_OurHeroHomeCategory | TD_OurCartAttackCategory
//collisionBitMask
let TD_OurCartCollisionBitMask              = TD_EnemyCartCategory
let TD_EnemyCartCollisionBitMask            = TD_OurCartCategory

//struct PhysicsCategory {
//    static let Crocodile: UInt32 = 1
//    static let VineHolder: UInt32 = 2
//    static let Vine: UInt32 = 4
//    static let Prize: UInt32 = 8
//}


let TD_Name_Clearing = "clearing"                       //空地
let TD_Name_Tower = "tower"                             //防御塔整体
let TD_Name_TowerSprite = "towerSprite"                 //防御塔实例
let TD_Name_ScopeAttack = "scopeAttack"                 //防御塔攻击范围
let TD_Name_CountdownLab = "countdownLab"               //出怪倒计时Lab
let TD_Name_HPLab = "HPLab"                             //关卡血量显示Lab
let TD_Name_EnergyLab = "energyLab"                     //出怪倒计时Lab
let TD_Name_ConfirmItem = "confirm"                     //确认建造按钮
let TD_Name_CancelItem = "cancel"                       //取消建造按钮
let TD_Name_UpgradeItem = "upgrade"                     //升级建筑按钮
let TD_Name_SellItem = "sell"                           //卖出建筑按钮
let TD_Name_ReturnItem = "return"                       //返回按钮


