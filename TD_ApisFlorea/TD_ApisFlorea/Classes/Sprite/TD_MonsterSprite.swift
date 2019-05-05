//
//  TD_MonsterSprite.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_MonsterSprite: TD_BaseSpriteNode {

    var monsterType = "1"                                //怪物种类
    
    var soldierName:String = "步兵"                       //士兵名称
    var image = "soldier"                                //士兵图片名称
    var expenditure:Double = 2.0                         //召唤消耗
    var energy:Double = 2.0                              //击杀获得的能量
    var maxHP:Double = 0.0                               //最大生命值
    var armor:Double = 0.0                               //基础护甲

    var moveSpeed:Double = 50.0                          //移动速度
    var attackSpeed:Double = 1.0                         //攻击速度 x秒/次
    var alertScope:Double = 50.0                         //警戒范围半径
    var attackScope:Double = 20.0                        //攻击范围半径
    var attackNumber:Int = 1                             //单次攻击最大数量
    var attackBumberOfTimes:Int = 1                      //单次攻击造成伤害次数
    var attackGif = "attack"                             //攻击动画gif
    var moveGif = "towerMove"                            //移动动画gif
    var harm:Double = 1.0                                //造成伤害值
    var isFirst:Bool = true                              //是否是第一次出现
    var intro = "基础近战兵种"                             //兵种介绍
    var HP:Double = 0.0                                  //单位当前剩余生命
    var temporaryDebuffArmor:Double = 0.0                //临时减益护甲   当前护甲等于临时护甲+基础护甲
    var temporaryDebufMoveSpeed:Double = 0.0             //临时减益移动速度   当前速度等于临时移动速度+基础移动速度

    
    var temporaryArmorTimer = Timer()                    //记录临时护甲timer
    var temporaryMoveSpeedTimer = Timer()                //记录临时移动速度timer

    
    
    var articleBloodSprite = SKSpriteNode()              //血条显示控件
    var targetPosition = CGPoint()                       //目的地坐标
    var isAggressive = Bool()                            //是否有攻击性的（主动攻击）
    func layout(monsterType:String){
        self.monsterType = monsterType
        initSoldierProperty(type: monsterType)
        initPhysicsBody()
        moveToTargetPosition(targetPosition: targetPosition)
        creatView()
    }
    
    /// 初始化小兵属性
    func initSoldierProperty(type:String){
        let data = TD_AnalyticalDataObject().getFileData(fileName: "Monster") as! [NSString : NSDictionary]
        let soldierInfo = data[NSString(format: "Monster_%@",type)]
        
        soldierName = soldierInfo!["Name"] as! String
        image = soldierInfo!["Image"] as! String
        expenditure = Double(soldierInfo!["Expenditure"] as! String)!
        energy = Double(soldierInfo!["Energy"] as! String)!
        maxHP = Double(soldierInfo!["HP"] as! String)!
        armor = Double(soldierInfo!["Armor"] as! String)!
        moveSpeed = Double(soldierInfo!["Speed"] as! String)!
        attackSpeed = Double(soldierInfo!["AttackSpeed"] as! String)!
        alertScope = Double(soldierInfo!["ScopeAlert"] as! String)!
        attackScope = Double(soldierInfo!["ScopeAttack"] as! String)!
        attackNumber = Int(soldierInfo!["AttackNumber"] as! String)!
        attackBumberOfTimes = Int(soldierInfo!["AttackBumberOfTimes"] as! String)!
        attackGif = soldierInfo!["AttackGif"] as! String
        moveGif = soldierInfo!["MoveGif"] as! String
        harm = Double(soldierInfo!["Harm"] as! String)!
        isFirst = soldierInfo!["IsFirst"] as! Bool
        intro = soldierInfo!["Intro"] as! String
        
        HP = maxHP
    }
    /// 初始化物理属性
    func initPhysicsBody(){
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width / 2.0, height: size.height / 2.0))
        //        physicsBody?.
        //        physicsBody?.density = 1                  //密度
        physicsBody?.mass = 1                       //质量
        physicsBody?.restitution = 0                //弹性
        physicsBody?.friction = 0.0                 //摩擦力
        physicsBody?.linearDamping = 0              //线性阻力(空气阻力)
        physicsBody?.allowsRotation = true
        physicsBody?.affectedByGravity = false
        
        physicsBody?.contactTestBitMask = TD_TowerAttackCategory        //碰撞检测
        physicsBody?.collisionBitMask = 0                               //碰撞效果
        physicsBody?.categoryBitMask = TD_MonsterCategory
  
    }
    func creatView(){
        if articleBloodSprite.name == nil{
            articleBloodSprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: TD_Block_Width, height: 5))
            articleBloodSprite.position = CGPoint(x: position.x, y: position.y +  size.height / 2.0)
            articleBloodSprite.name = "articleBloodSprite"
            superScene.addChild(articleBloodSprite)
        }
    }
    
    func moveToTargetPosition(targetPosition:CGPoint){
        let pathPlanning = TD_PathPlanning()
        pathPlanning.startRect = CGRect(x: position.x - TD_Block_Width / 2.0, y: position.y - TD_Block_Width / 2.0, width: TD_Block_Width, height: TD_Block_Width)
        
        let mapData = (superScene as! TD_ScenarioScene).mapData as! [NSArray]

        
        pathPlanning.mapData = mapData
        pathPlanning.endRect = CGRect(x: targetPosition.x - TD_Block_Width / 2.0, y: targetPosition.y - TD_Block_Width / 2.0, width: TD_Block_Width, height: TD_Block_Width)
        pathPlanning.mapStartPoint = CGPoint(x: 10, y: TD_Game_TopClearance)
        pathPlanning.getPathPlanning { (callBack) in
            let paths = NSMutableArray()
            for i in 0..<callBack.count {
                let point = callBack[i] as! CGPoint
                paths.add(CGPoint(x: point.x + TD_Block_Width / 2.0 + 10, y: point.y + TD_Game_TopClearance + TD_Block_Width / 2.0))
            }
            self.runActionGif(fileName: self.moveGif as NSString, isRepeat: true, key:"move")
            self.movePaths(paths: paths, startPoint: CGPoint(x: self.position.x, y: self.position.y), key: "move", runType: 1)
            
            let mPaths = NSMutableArray(array: paths)
            mPaths.removeObject(at: 0)
            self.moveArticleBloodSprite(paths: mPaths)
        }
    }
    func moveArticleBloodSprite(paths:NSArray) {
        
        let mPaths = NSMutableArray(array: paths)
        
        let point = mPaths.firstObject as! CGPoint
        mPaths.removeObject(at: 0)
        
        let action = SKAction.move(to: CGPoint(x: point.x, y: point.y + size.height / 2.0), duration:TimeInterval(TD_Block_Width / CGFloat(moveSpeed)))
        articleBloodSprite.run(action) {
            if  self.articleBloodSprite.name == nil{
                return
            }
            if mPaths.count >= 1{
                self.moveArticleBloodSprite(paths: mPaths)
            }
        }
    }
    
    func movePaths(paths:NSArray,startPoint:CGPoint,key:String,runType:Int){

        
        let action = TD_Action().action(paths: paths, startPoint: startPoint, moveSpeed: CGFloat(moveSpeed) * (100.0 - CGFloat(temporaryDebufMoveSpeed)) / 100.0)
        runActionWithThisOrScope(action: action, key: key,runType: runType)
    }
    func runActionWithThisOrScope(action:SKAction,key:String,runType:Int){
        if runType == 1 {
            self.run(action) {
                self.removeAllFromParent()
                (self.superScene as! TD_ScenarioScene).breakthrough(monster: self)
            }
            
        }else{
            run(action, withKey: key)
        }
        
    }
    func removeAllFromParent(){
        removeFromParent()
        articleBloodSprite.name = nil
        articleBloodSprite.removeFromParent()
    }
    
    
    /// 护甲被改变调用
    ///
    /// - Parameters:
    ///   - temporaryArmor: 临时改变的护甲
    ///   - time: 改变持续时间
    func setTemporaryArmor(temporaryArmor:Double,time:Double) {
        if self.temporaryDebuffArmor > temporaryArmor {
            return
        }
        self.temporaryArmorTimer.invalidate()            //停止
        self.temporaryDebuffArmor = temporaryArmor
        temporaryArmorTimer = Timer.init(timeInterval: time, repeats: true) { (kTimer) in
            
            self.temporaryArmorTimer.invalidate()            //停止
            self.temporaryDebuffArmor = 0
            self.removeAction(key: "move")
            self.moveToTargetPosition(targetPosition: self.targetPosition)
        }
        RunLoop.current.add(temporaryArmorTimer, forMode: .defaultRunLoopMode)
        // TODO : 启动定时器
        temporaryArmorTimer.fire()
    }
    
    /// 速度被改变调用
    ///
    /// - Parameters:
    ///   - temporaryMoveSpeed: 临时改变的速度
    ///   - time: 改变持续时间
    func setTemporaryMoveSpeed(temporaryMoveSpeed:Double,time:Double){
        if self.temporaryDebufMoveSpeed > temporaryMoveSpeed {
            return
        }
        
        self.temporaryMoveSpeedTimer.invalidate()            //停止
        self.temporaryDebufMoveSpeed = temporaryMoveSpeed
        
        removeAction(forKey: "move")
//        moveToTargetPosition(targetPosition: targetPosition)
        
        temporaryMoveSpeedTimer = Timer.init(timeInterval: time, repeats: true) { (kTimer) in
            
            self.temporaryMoveSpeedTimer.invalidate()            //停止
            self.temporaryDebufMoveSpeed = 0
            self.removeAction(forKey: "move")
            
//            self.moveToTargetPosition(targetPosition: self.targetPosition)
        }
        RunLoop.current.add(temporaryMoveSpeedTimer, forMode: .defaultRunLoopMode)
        // TODO : 启动定时器
        temporaryMoveSpeedTimer.fire()
    }
    
    /// 被攻击调用
    ///
    /// - Parameter damage: 攻击造成的伤害
    /// - Returns: 是否被击杀
    func beingAttacked(damage:Double) -> Bool {
        HP = HP - actualDamage(damage: damage)
        
        articleBloodSprite.size = CGSize(width: TD_Block_Width * CGFloat(HP / maxHP), height: articleBloodSprite.size.height)
        if (HP <= 0){//被击杀
            (superScene as! TD_ScenarioScene).destroyed(monster: self)
            (superScene as! TD_ScenarioScene).collectEnergy(energy: energy)
            return true
        }else{
            return false
        }
    }
    func actualDamage(damage:Double) -> Double {
        let arm = armor + temporaryDebuffArmor
        return damage * pow(0.95, arm)
    }
}
