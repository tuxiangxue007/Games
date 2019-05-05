//
//  TD_TowerSprite.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/17.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_TowerSprite: TD_BaseSpriteNode {
    var totalValue:Double = 0.0
    
    
    var soldierName:String = "步兵"                       //士兵名称
    var image = "soldier"                                //士兵图片名称
    var expenditure:Double = 2.0                         //召唤消耗
    var upExpenditure:Double = 2.0                       //升级消耗
    var maxHP:Double = 0.0                               //最大生命值
    var moveSpeed:Double = 50.0                          //移动速度
    var attackSpeed:Double = 1.0                         //攻击速度 x秒/次
    var alertScope:Double = 50.0                         //警戒范围半径
    var attackScope:Double = 20.0                        //攻击范围半径
    var attackNumber:Int = 1                             //单次攻击最大数量
    var attackBumberOfTimes:Int = 1                      //单次攻击造成伤害次数
    var attackGif = "attack"                             //攻击动画gif
    var attackImg = "attack"                             //攻击能量球图片
    var attackType = "1"                                 //攻击类型  1、单体（散射）2、群体（范围）
    var attackRadius:Double = 10.0                       //伤害范围
    var attackSpecialEffects = "0"                       //攻击特效 0、无特效 1、减速 2、击晕   3、减甲
    var specialEffectsNumber:Double = 10.0               //攻击特效效果 例如 减速（击晕）指减速百分比 减甲指减甲数据
    var specialEffectsDuration:Double = 1.0              //攻击特效持续时间
    var specialEffectsprobability:Double = 0.0           //触发特效概率

    var moveGif = "towerMove"                            //移动动画gif
    var harm:Double = 1.0                                //造成伤害值
    var maxLevel:Int = 1                                 //可升至最高级别

    var isFirst:Bool = true                              //是否是第一次出现
    var intro = "基础近战兵种"                             //兵种介绍
    var HP:Double = 0.0                                  //单位当前剩余生命
    
    var confirmBuild = SKNode()                          //用来显示是否确认建造视图
    var scopeAttack = SKSpriteNode()                     //防御塔攻击范围显示
    var operationMenuView = SKNode()                     //防御塔操作视图
    
    var towerType = 0                                    //防御塔类型
    var level = 1                                        //防御塔级别
    var towerSprite = SKSpriteNode()                     //防御塔实例
    
    var attackTarget = [TD_MonsterSprite]()              //防御塔正在攻击的目标
    
    var isActivate = false{                              //标记防御塔是否已经激活
        willSet {
            print("attackRange即将发生改变")
        }
        didSet {
            if oldValue == false{
                updataAttack()
            }
        }
    }
    var attackRange = [TD_MonsterSprite](){              //攻击范围内的怪物
        willSet {
            print("attackRange即将发生改变")
        }
        didSet {
            if oldValue.count == 0 {
//                isActive = true
                updataAttack()
                
            }else if oldValue.count == 1 && attackRange.count == 0{
//                isActive = false
                attackTarget.removeAll()
            }
            print("attackRange已经发生改变")
        }
    }
    var energyBallList = [TD_EnergyBallSprite]()
    
    func layout(towerType:Int){
        self.towerType = towerType
        refresh()
    }
    
    /// 初始化小兵属性
    func initTowerProperty(type:Int){
        let data = TD_AnalyticalDataObject().getFileData(fileName: "Towers") as! [NSString : NSDictionary]
        let soldierInfo = data[NSString(format: "Towers_%d_%d",type,level)]
        
        soldierName = soldierInfo!["Name"] as! String
        image = soldierInfo!["Image"] as! String
        expenditure = Double(soldierInfo!["Expenditure"] as! String)!
        upExpenditure = Double(soldierInfo!["UpExpenditure"] as! String)!
        maxHP = Double(soldierInfo!["HP"] as! String)!
        moveSpeed = Double(soldierInfo!["Speed"] as! String)!
        attackSpeed = Double(soldierInfo!["AttackSpeed"] as! String)!
        alertScope = Double(soldierInfo!["ScopeAlert"] as! String)!
        attackScope = Double(soldierInfo!["ScopeAttack"] as! String)!
        attackNumber = Int(soldierInfo!["AttackNumber"] as! String)!
        attackBumberOfTimes = Int(soldierInfo!["AttackBumberOfTimes"] as! String)!
        attackGif = soldierInfo!["AttackGif"] as! String
        attackImg = soldierInfo!["AttackImg"] as! String
        attackType = soldierInfo!["AttackType"] as! String
        attackRadius = Double(soldierInfo!["AttackRadius"] as! String)!
        attackSpecialEffects = soldierInfo!["AttackSpecialEffects"] as! String
        specialEffectsNumber = Double(soldierInfo!["SpecialEffectsNumber"] as! String)!
        specialEffectsDuration = Double(soldierInfo!["SpecialEffectsDuration"] as! String)!
        specialEffectsprobability = Double(soldierInfo!["SpecialEffectsprobability"] as! String)!
        intro = soldierInfo!["Intro"] as! String
        moveGif = soldierInfo!["MoveGif"] as! String
        harm = Double(soldierInfo!["Harm"] as! String)!
        maxLevel = Int(soldierInfo!["MaxLevel"] as! String)!
        isFirst = soldierInfo!["IsFirst"] as! Bool
        intro = soldierInfo!["Intro"] as! String

        
        HP = maxHP
    }
    
    func refresh() {
        initTowerProperty(type: towerType)
        refreshTowerSprite()
    }
    
    func refreshTowerSprite(){
        
        if towerSprite.name == TD_Name_TowerSprite{
            towerSprite.removeFromParent()
        }
        
        towerSprite = SKSpriteNode(imageNamed:image)
        towerSprite.name = TD_Name_TowerSprite
        towerSprite.position = position
        towerSprite.size = size
        superScene.addChild(towerSprite)
    }
    

    func showConfirmBuild() {
        if confirmBuild.name == nil{
            confirmBuild.name = "confirmBuild"
            confirmBuild.position = CGPoint(x: position.x, y: position.y + size.height + 10)
            confirmBuild.zPosition = 11
            confirmBuild.isHidden = true
            superScene.addChild(confirmBuild)
            
            let confirmItem = SKSpriteNode(imageNamed: "confirm")
            confirmItem.position = CGPoint(x: -20, y: -10)
            confirmItem.size = CGSize(width: 30, height: 30)
            confirmItem.name = TD_Name_ConfirmItem
            confirmBuild.addChild(confirmItem)
            
            let cancelItem = SKSpriteNode(imageNamed: "cancel")
            cancelItem.position = CGPoint(x: 15, y: -10)
            cancelItem.size = CGSize(width: 30, height: 30)
            cancelItem.name = TD_Name_CancelItem
            confirmBuild.addChild(cancelItem)
            
        }
        confirmBuild.isHidden = false
    }
    func hiddenConfirmBuild(){
        confirmBuild.isHidden = true
    }
    func showScopeAttack(){
        if scopeAttack.name == nil{
            scopeAttack = SKSpriteNode(imageNamed: "scope_ round")
            scopeAttack.size = CGSize(width: CGFloat(attackScope) + size.width, height: CGFloat(attackScope) + size.width)
            scopeAttack.name = TD_Name_ScopeAttack
            scopeAttack.position = position
            superScene.addChild(scopeAttack)
            
            scopeAttack.physicsBody = SKPhysicsBody(circleOfRadius: scopeAttack.size.width / 2.0)
            //        physicsBody?.density = 0                //密度
            scopeAttack.physicsBody?.mass = 1                     //质量
            scopeAttack.physicsBody?.restitution = 0              //弹性
            scopeAttack.physicsBody?.friction = 0.0               //摩擦力
            scopeAttack.physicsBody?.linearDamping = 0.0          //线性阻力(空气阻力)
            scopeAttack.physicsBody?.allowsRotation = false
            scopeAttack.physicsBody?.affectedByGravity = false
            //         physicsBody?.collisionBitMask =   TD_MonsterCategory              //碰撞效果
            //        physicsBody?.contactTestBitMask = TD_MonsterCategory//碰撞检测
            scopeAttack.physicsBody?.collisionBitMask = 0                        //不会产生被碰撞效果
            scopeAttack.physicsBody?.categoryBitMask = TD_TowerAttackCategory
            scopeAttack.isHidden = true
            scopeAttack.zPosition = 10
        }
        
        
        scopeAttack.isHidden = false
    }
    func hiddenScopeAttack(){
        scopeAttack.isHidden = true
    }
    
    func showOperationMenuView(){
        
        
        if operationMenuView.name == nil{
            operationMenuView.name = "operationMenuView"
            operationMenuView.position = CGPoint(x: position.x, y: position.y - size.height)
            operationMenuView.zPosition = 11
            operationMenuView.isHidden = true
            superScene.addChild(operationMenuView)
            
            let upgradeItem = SKSpriteNode(imageNamed: "upgrade")
            upgradeItem.position = CGPoint(x: -35, y: -10)
            upgradeItem.size = CGSize(width: 30, height: 30)
            upgradeItem.name = TD_Name_UpgradeItem
            operationMenuView.addChild(upgradeItem)
            
            let sellItem = SKSpriteNode(imageNamed: "sell")
            sellItem.position = CGPoint(x: 0, y: -10)
            sellItem.size = CGSize(width: 30, height: 30)
            sellItem.name = TD_Name_SellItem
            operationMenuView.addChild(sellItem)
            
            let returnItem = SKSpriteNode(imageNamed: "return")
            returnItem.position = CGPoint(x: 35, y: -10)
            returnItem.size = CGSize(width: 30, height: 30)
            returnItem.name = TD_Name_ReturnItem
            operationMenuView.addChild(returnItem)
            
        }
        operationMenuView.isHidden = false
    }
    
    func hiddenOperationMenuView(){
        operationMenuView.isHidden = true
    }
    
    func removeAllFromParent(){
        removeFromParent()
        confirmBuild.removeFromParent()
        scopeAttack.removeFromParent()
        towerSprite.removeFromParent()
        operationMenuView.removeFromParent()
    }
    func updataAttack(){
        
        
        if  attackRange.count >= 1 && isActivate{
            if attackTarget.count != attackNumber && attackRange.count != attackTarget.count{
                attackTarget.removeAll()
                for i in 0..<attackRange.count {
                    attackTarget.append(attackRange[i])
                    if attackTarget.count == attackNumber{
                        attack()
                        break;
                    }
                }
            }else{
                attack()
            }
        }else{
            return
        }
        
        let time: TimeInterval = attackSpeed
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.updataAttack()
        }
    }
    func attack() {
        
        if attackType == "1" {//单体（散射攻击）
            for i in 0..<attackTarget.count {
                attackToMonster(monster: attackTarget[i])
            }
        }else if attackType == "2"{//群体攻击（范围攻击）
            let energyBallSprite = TD_EnergyBallSprite(imageNamed: "roundness")
            energyBallSprite.size = CGSize(width: attackRadius, height: attackRadius)
            energyBallSprite.position = position
            superScene.addChild(energyBallSprite)
            energyBallSprite.layout()
            energyBallList.append(energyBallSprite)
            let paths = NSMutableArray()
            
            let endPosition = attackTarget[0].position
            paths.add(position)
            paths.add(CGPoint(x: (endPosition.x + position.x ) / 2.0, y: (endPosition.y + position.y) / 2.0 + (endPosition.y - position.y) * 0.7))
            paths.add(endPosition)
            let action = TD_Action().action(paths: paths, startPoint: position, moveSpeed: 300)
            energyBallSprite.run(action) {
                
                let index = self.energyBallList.index(of: energyBallSprite)
                if index != nil{
                    self.energyBallList.remove(at: index!)
                }
                energyBallSprite.removeFromParent()
            }
        }
    }
    func attackToMonster(monster:TD_MonsterSprite) {
        let attackSprite = SKSpriteNode(imageNamed: attackImg)
        attackSprite.size = CGSize(width: 10, height: 10)
        attackSprite.position = CGPoint(x: position.x, y: position.y + size.height / 2.0)
        superScene.addChild(attackSprite)
        
        let action = SKAction.move(to: monster.position, duration: 0.10)
        attackSprite.run(action) {
            attackSprite.removeFromParent()
            if monster.beingAttacked(damage:self.harm) {
                
            }
            self.triggerAttackSpecialEffects(monster: monster)
        }
    }
    func damageToMonster(monster:TD_MonsterSprite) {
        if monster.beingAttacked(damage:self.harm) {
            
        }
        triggerAttackSpecialEffects(monster: monster)
    }
    func triggerAttackSpecialEffects(monster:TD_MonsterSprite){
        if attackSpecialEffects == "0" {//无特效直接跳过
            return
        }
        if (Double)(arc4random() % 100) <= specialEffectsprobability  {
            if attackSpecialEffects == "1"{//减速
                monster.setTemporaryMoveSpeed(temporaryMoveSpeed: specialEffectsNumber, time: specialEffectsDuration)
            }else if attackSpecialEffects == "2"{//击晕
                monster.setTemporaryMoveSpeed(temporaryMoveSpeed: specialEffectsNumber, time: specialEffectsDuration)

            }else if attackSpecialEffects == "3"{//减甲
                monster.setTemporaryArmor(temporaryArmor: specialEffectsNumber, time: specialEffectsDuration)

            }
        }
    }
}
