//
//  TD_CartSprite.swift
//  TD_ Journey
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_CartSprite: TD_BaseSpriteNode {
//    var cardId = ""
    var cardInfo = [String:Any]()

    let stateLab = SKLabelNode()
    var coordinates = -1
    var newCoordinates = -1
    var type = -1
    var attackScopeSprite = SKSpriteNode()
    var imgSprite = TD_BaseSpriteNode()
    
    var isArrackHero = false
    
    var attackTargetEnemy = [TD_CartSprite](){
        willSet {
            
        }
        didSet {
//            if attackTower.count == 1 && oldValue.count == 0{
//                self.removeOrScopeAction(key: TD_MoveToTower)
//                self.updataAttack()
//            }
            print("attackTargetEnemy已经发生改变")
        }
    }
    
    var attackTargetOur = [TD_CartSprite](){
        willSet {
            
        }
        didSet {
            //            if attackTower.count == 1 && oldValue.count == 0{
            //                self.removeOrScopeAction(key: TD_MoveToTower)
            //                self.updataAttack()
            //            }
            print("attackTargetOur已经发生改变")
        }
    }
    
    
    
    //卡片属性
    var cardName:String = "狼"                               //卡片名称
    var image:String = "card_2001_1"                        //卡片图片（战场图片）
    var cardImage:String = "card_2001_2"                    //卡片图片（卡组图片）
    var prepare:Int = 1                                     //准备回合数
    var cardType:Int = 0                                    //卡片类型（0、普通卡片 1、魔法卡）
    var attack:Int = 1                                      //攻击
    var HP:Int = 2                                          //生命

    var mobile:Int = 2                                      //行动力
    var attackNumber:Int = 1                                //单次攻击伤害次数

    var attackScope:Int = 1                                 //攻击范围
    var attackGif:String = "cardMove_101.gif"               //攻击动画
    var moveGif:String = "cardMove_101.gif"                 //移动动画
    var attackType:Int = 0                                  //攻击方式(0、普通近战攻击   1、远程攻击（单体瞄准）2、远程能量攻击（单体瞄准）3、直线伤害（喷火等）ps：0、1为物理伤害 2、3位魔法伤害
    var energyBallType:Int = 0                              //远程能量球类型（0、无能量球动画 1、直线(弩箭，火枪) 2、抛射（弓箭、投石车）3、直击目标（雷电术等））
    var targetType:Int = 0                                  //攻击目标类型（0、敌方单体 1、敌方全体，2、敌方全体（建筑除外）3、敌方建筑 4、全体人员（不分敌我））
    var basisStar:Int = 1                                   //卡片初始星级
    var starAttack:Double = 0.3                             //升星增加攻击
    var starHP:Double = 0.6                                 //升星增加血量
//    var star:Int = 1                                        //当前星级
//    var isFirst:Bool = true                                 //是否是第一次出现
//    var skillsIntro:String = ""                             //卡片技能介绍（出现在卡片介绍栏）
    var relatedSkills = [String]()                          //卡片技能数组
    var intro:String = "步兵"                                //卡片介绍
    var placeholder1:String = ""                            //缺省关联字段1
    var placeholder2:String = ""                            //缺省关联字段2
    var placeholder3:String = ""                            //缺省关联字段3
    
    
    var isScope:Int = 0                                     //警戒属性
    var armor:Int = 0                                       //护甲
    var magicArmor:Int = 0                                  //魔甲
    var counterattackType:Int = 1                           //反击类型（0：不反击 1、反击近战 2、全部反击（攻击范围内））
    var rebound:Int = 1                                     //反弹伤害（仅限反弹近战，数值为受到攻击反弹的伤害）
    
    
    var actualAttack:Int = 1                                //当前攻击
    var actualHP:Int = 2                                    //当前生命
    var actualArmor:Int = 0                                 //当前护甲
    var actualMagicArmor:Int = 0                            //当前魔甲
    
    
    func layout() {
        initCartProperty()
        initPhysicsBoby()
        creatAttackScopeView()
        creatView()
        name = "cart"
        
    }
    
    
    
    
    /// 初始化小兵属性
    func initCartProperty(){

        
        cardName = cardInfo["Name"] as! String
        image = cardInfo["Image"] as! String
        cardImage = cardInfo["CardImage"] as! String
        prepare = Int(cardInfo["Prepare"] as! String)!
        cardType = Int(cardInfo["CardType"] as! String)!
        attack = Int(cardInfo["Attack"] as! String)!
        HP = Int(cardInfo["HP"] as! String)!
//        armor = Int(cardInfo["Armor"] as! String)!
//        magicArmor = Int(cardInfo["MagicArmor"] as! String)!
        mobile = Int(cardInfo["Mobile"] as! String)!
        attackNumber = Int(cardInfo["AttackNumber"] as! String)!
//        isScope = cardInfo["IsScope"] as! Bool
//        counterattackType = Int(cardInfo["CounterattackType"] as! String)!
//        rebound = Int(cardInfo["Rebound"] as! String)!
        attackScope = Int(cardInfo["AttackScope"] as! String)!
        attackGif = cardInfo["AttackGif"] as! String
        moveGif = cardInfo["MoveGif"] as! String
        attackType = Int(cardInfo["AttackType"] as! String)!
        energyBallType = Int(cardInfo["EnergyBallType"] as! String)!
        targetType = Int(cardInfo["TargetType"] as! String)!
        basisStar = Int(cardInfo["BasisStar"] as! String)!
        starAttack = Double(cardInfo["StarAttack"] as! String)!
        starHP = Double(cardInfo["StarHP"] as! String)!
//        star = Int(cardInfo["Star"] as! String)!
//        isFirst = cardInfo["IsFirst"] as! Bool
        relatedSkills = cardInfo["RelatedSkills"] as! [String]
        intro = cardInfo["Intro"] as! String
        placeholder1 = cardInfo["Placeholder1"] as! String
        placeholder2 = cardInfo["Placeholder1"] as! String
        placeholder3 = cardInfo["Placeholder1"] as! String
        
        
        initSkillAttributes()
    }
    func initSkillAttributes(){
        for item in relatedSkills {
            let data = (TD_AnalyticalDataObject().getFileData(fileName: "Skills"))[item] as! NSDictionary
            let type = Int(data["Type"] as! String)
            if type! < 10{//属性类技能
                initSkills(attData: data)
            }
            else if type! >= 10 && type! < 20{//动作类技能
                
            }
            else if type! >= 20 && type! < 30{//光环类技能
                
            }
            else if type! == 100{//限制类技能
                
            }
            else if type! == 101{//召唤类技能
                
            }
        }
    }
    
    /// 初始化技能数据
    ///
    /// - Parameter attData: 属性类技能数据
    func initSkills(attData:NSDictionary)  {
        print("%@",attData)
//        attData["AttributeName"]
        let attributeName = attData["AttributeName"] as! String
        
        let number = Int(attData["AttributeNumber"] as! String)!
        if attributeName == "IsScope" {
            isScope = isScope + number
        }
        else if attributeName == "Armor" {
            armor = armor + number
        }
        
        
//        let setSel = Selector.init(String(format: "set%@", attData["AttributeName"] as! String))
//        let getSel = Selector.init(String(format: "get%@", attData["AttributeName"] as! String))
//        var number = target(forAction: getSel, withSender: nil) as! Int
//        number = number + Int(attData["AttributeNumber"] as! String)!
//        target(forAction: setSel, withSender: number)
        
    }
    
    /// 初始化技能数据
    ///
    /// - Parameter actionData: 动作类技能数据
    func initSkills(actionData:NSDictionary)  {
        
    }
    
    /// 初始化技能数据
    ///
    /// - Parameter haloData: 光环类技能数据
    func initSkills(haloData:NSDictionary)  {
        
    }
    
    /// 初始化技能数据
    ///
    /// - Parameter limitData: 限制类技能数据
    func initSkills(limitData:NSDictionary)  {
        
    }
    
    /// 初始化技能数据
    ///
    /// - Parameter summonData: 召唤类技能数据
    func initSkills(summonData:NSDictionary)  {
        
    }
    
    func creatView() {
        //        let imgName = String(format: "card_%@_2",cardId)
        
        imgSprite = TD_BaseSpriteNode(imageNamed: image)
        if type == 1 {//敌方主场卡片imgSprite
            imgSprite.size = CGSize(width: -TD_Block_Width, height: TD_Block_Width)
        }else{
            imgSprite.size = CGSize(width: TD_Block_Width, height: TD_Block_Width)
        }
        imgSprite.position = CGPoint(x: 0, y: 0)
        addChild(imgSprite)
        
        actualAttack = attack
//        actualArmor = armor
        actualHP = HP
//        actualMagicArmor = magicArmor
        stateLab.position = CGPoint(x: 0, y: -(TD_Block_Height * 0.5))
        stateLab.text = String(format: "%d/%d/%d/%d", actualAttack,actualArmor,actualMagicArmor,actualHP)
        stateLab.fontSize = 14.0
        stateLab.fontColor = UIColor.red
        addChild(stateLab)
        
        
        

    }
    //初始化物理属性
    func initPhysicsBoby(){
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: TD_Block_Width - 2, height: TD_Block_Width - 2))
        //        physicsBody.colo
        physicsBody?.collisionBitMask = 0
        //        physicsBody?.density = 0                //密度
        physicsBody?.mass = 1                     //质量
        physicsBody?.restitution = 0              //弹性
        physicsBody?.friction = 1.0               //摩擦力
        physicsBody?.linearDamping = 0.0          //线性阻力(空气阻力)
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        
        
        if type == 0 {
            physicsBody?.contactTestBitMask = TD_EnemyHeroHomeCategory
//            physicsBody?.collisionBitMask = TD_EnemyCartCollisionBitMask
            physicsBody?.categoryBitMask = TD_OurCartCategory
        }else {
            physicsBody?.contactTestBitMask = TD_OurHeroHomeCategory
//            physicsBody?.collisionBitMask = TD_OurCartCollisionBitMask
            physicsBody?.categoryBitMask = TD_EnemyCartCategory
        }
        
    }
    //初始化攻击范围物理属性
    func creatAttackScopeView() {
        if isScope == 1{
            attackScopeSprite.size = CGSize(width: CGFloat(attackScope * 2 + 1) * TD_Block_Width , height: CGFloat(attackScope * 2 + 1) * TD_Block_Height)
        }else{
            attackScopeSprite.size = CGSize(width: CGFloat(attackScope) * TD_Block_Width, height: TD_Block_Height)
            if type == 0 {
                attackScopeSprite.position = CGPoint(x: attackScopeSprite.size.width / 2.0 + TD_Block_Width / 2.0, y: 0)
            }else {
                attackScopeSprite.position = CGPoint(x: -attackScopeSprite.size.width / 2.0 - TD_Block_Width / 2.0, y: 0)
            }
            
        }
        addChild(attackScopeSprite)

        attackScopeSprite.physicsBody = SKPhysicsBody(rectangleOf: attackScopeSprite.size)
        attackScopeSprite.physicsBody?.collisionBitMask = 0
        //        physicsBody?.density = 0                //密度
        attackScopeSprite.physicsBody?.mass = 1                     //质量
        attackScopeSprite.physicsBody?.restitution = 0              //弹性
        attackScopeSprite.physicsBody?.friction = 0.0               //摩擦力
        attackScopeSprite.physicsBody?.linearDamping = 0.0          //线性阻力(空气阻力)
        attackScopeSprite.physicsBody?.allowsRotation = false
        attackScopeSprite.physicsBody?.affectedByGravity = false
        
        if type == 0 {
            attackScopeSprite.physicsBody?.contactTestBitMask = TD_EnemyCartCategory | TD_EnemyHeroCategory
            attackScopeSprite.physicsBody?.categoryBitMask = TD_OurCartAttackCategory
        }else{
            attackScopeSprite.physicsBody?.contactTestBitMask = TD_OurCartCategory | TD_OurHeroCategory
            attackScopeSprite.physicsBody?.categoryBitMask = TD_EnemyCartAttackCategory
        }

        self.zPosition = 20
    }
    func action() {
        newCoordinates = coordinates
        if attackTargetEnemy.count > 0{
            attackEnemy(targetType: 1)
        }else if(isArrackHero){
            attackEnemy(targetType: 2)
        }else{
            move(mobile: mobile)
        }
    }
    
    func move(mobile:Int){
        var w = TD_Block_Width
        var step = 1
        if type == 1{
            w = -TD_Block_Width
            step = -1
            if newCoordinates % 100 == 0{//在最左方
                (superScene as! TD_FightScene).pollingAction()
                return
            }
        }else{
            if newCoordinates % 100 == 11{//在最右方
                (superScene as! TD_FightScene).pollingAction()
                return
            }
        }
        
        
        if !(superScene as! TD_FightScene).performMobile(step: step, coordinates: newCoordinates, mobile: mobile){//前方没有落脚点
            (superScene as! TD_FightScene).pollingAction()
            return
        }
        
        
        imgSprite.runActionGif(fileName: moveGif, isRepeat: true, key: "move")
        let action = SKAction.move(to: CGPoint(x: position.x + w, y: position.y), duration: TimeInterval(TD_Block_Width / 100))
        self.run(action) {
            
            if self.type == 0 {
                self.newCoordinates = self.newCoordinates + 1
                
            }else{
                
                self.newCoordinates = self.newCoordinates - 1
            }
            if (self.superScene as! TD_FightScene).thereAreUnits(coordinates: self.newCoordinates) == false{
                (self.superScene as! TD_FightScene).refreshData(oldKey: self.coordinates, newKey: self.newCoordinates)
                self.coordinates = self.newCoordinates
                if self.attackTargetEnemy.count > 0{
                    self.imgSprite.removeAction(key: "move")
                    self.attackEnemy(targetType: 1)
                }else if(self.isArrackHero){
                    self.imgSprite.removeAction(key: "move")
                    self.attackEnemy(targetType: 2)
                }else if (mobile > 0){
                    self.imgSprite.removeAction(key: "move")
                    self.move(mobile: mobile - 1)
                }else{
                    self.imgSprite.removeAction(key: "move")
                    (self.superScene as! TD_FightScene).pollingAction()
                }
            }else{
                if (mobile > 0){
                    self.imgSprite.removeAction(key: "move")
                    self.move(mobile: mobile - 1)
                }
            }
            
            

            
        }
    }
    
    
    /// 攻击敌军，处理逻辑
    ///
    /// - Parameter targetType: 1、卡片 2、英雄
    func attackEnemy(targetType:Int) {
        switch attackType {
            case 0://普通近战攻击
                meleeAttack(targetType:targetType)
                break
            case 1://远程能量攻击（单体瞄准）
                remoteAttack()
                break
            case 2://直线攻击
                straightLineAttack()
                break
            default:
                break
        }
    }
    
    
    /// 普通近战攻击，有攻击动作，目标直接受到伤害
    ///
    /// - Parameter targetType: 1、卡片 2、英雄
    func meleeAttack(targetType:Int) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
            {
                if (targetType == 1){
                    let target = self.getMonomerTarget()
                    self.attackked(sprites: [target])
                }else{
                    self.attackkedHero()
                }
                
        })
        imgSprite.runActionGif(fileName: attackGif) { (results) in
            (self.superScene as! TD_FightScene).pollingAction()
        }
    }
    
    
    /// 远程攻击方式
    func remoteAttack(){
        switch energyBallType {
            case 0://无能量球动画
//                meleeAttack()
                break
            case 1://直线(弩箭，火枪)
//                remoteAttack()
                break
            case 2://抛射（弓箭、投石车）
//                meleeAttack()
                break
            case 3://直击目标（雷电术、突刺）
//                meleeAttack()
                break
            default:
                break
        }
    }
    
    /// 直线攻击（喷火等）
    func straightLineAttack(){
        switch targetType {
        case 0://敌方单体
            break
        case 1://敌方全体
            break
        case 2://敌方全体（建筑除外）
            break
        case 3://敌方建筑
            break
        case 4://全体人员（不分敌我）
            break
        default:
            break
        }
    }
    
    
    
    
    /// 获取攻击目标（单体）
    ///
    /// - Returns: 攻击目标
    func getMonomerTarget() -> TD_CartSprite {
        var cartSprite = TD_CartSprite()
        
        for item in attackTargetEnemy {
            if cartSprite.type == -1{
                cartSprite = item
            }else{
                if type == 0{
                    if item.coordinates < cartSprite.coordinates{
                        cartSprite = item
                    }
                }else{
                    if item.coordinates > cartSprite.coordinates{
                        cartSprite = item
                    }
                }
            }
        }
        return cartSprite
    }
    
    
    /// 攻击英雄
    func attackkedHero(){
        
    }
    
    /// 攻击目标（卡片单位）
    ///
    /// - Parameter sprites:被攻击的卡片单位数组
    func attackked(sprites:[TD_CartSprite]){
        var type = 0;
        if self.attackType > 1{
            type = 1
        }
        for item in sprites {
//            let isKill=(superScene as! TD_FightScene).target(attack: actualAttack, cardSprite: item, attackType: type)
            if (superScene as! TD_FightScene).target(attack: actualAttack, cardSprite: item, attackType: type){//击杀目标
                let iEnemy = attackTargetEnemy.index(of: item)
                if (iEnemy != nil){
                    attackTargetEnemy.remove(at: iEnemy!)
                    continue
                }
                
                if targetType == 4{
                    let iOur = attackTargetOur.index(of: item)
                    if (iOur != nil){
                        attackTargetEnemy.remove(at: iOur!)
                    }
                }
            }
        }
        

    }
    
    /// 被攻击
    ///
    /// - Parameters:
    ///   - attack: 伤害
    ///   - attackType: 伤害类型 1：物理伤害、1:魔法伤害
    /// - Returns: 是否被击杀
    func beingAttacked(attack:Int,attackType:Int) -> Bool {
        var ar = 0
        if attackType == 0 {
            ar = actualArmor
        }else{
            ar = actualMagicArmor
        }
        actualHP = actualHP - max(attack - ar, 0)
        
        let temporaryImgSprite = SKSpriteNode(imageNamed: "beingAttackedTrace")
        temporaryImgSprite.size = size
        temporaryImgSprite.zPosition = 100;
        addChild(temporaryImgSprite)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
            {
                temporaryImgSprite.removeFromParent()
                
        })


        
        if actualHP <= 0 {
            print("该单位被击杀 -- %d -- %@",coordinates,cardName);
            (self.superScene as! TD_FightScene).removeSptiye(key: coordinates)
            removeFromParent()
            return true
        }
        
        return false
    }
}
