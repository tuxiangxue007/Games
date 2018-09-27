//
//  TD_MonsterSprite.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_MonsterSprite: TD_BaseSpriteNode {

    
    var soldierName:String = "步兵"                       //士兵名称
    var image = "soldier"                                //士兵图片名称
    var expenditure:Double = 2.0                         //召唤消耗
    var energy:Double = 2.0                              //击杀获得的能量
    var maxHP:Double = 0.0                               //最大生命值
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
    
    var articleBloodSprite = SKSpriteNode()              //血条显示控件
    var targetPosition = CGPoint()                       //目的地坐标
    var isAggressive = Bool()                            //是否有攻击性的（主动攻击）
    func layout(monsterType:Int){
        initSoldierProperty(type: monsterType)
        initPhysicsBody()
        moveToTargetPosition(targetPosition: targetPosition)
        creatView()
    }
    
    /// 初始化小兵属性
    func initSoldierProperty(type:Int){
        let data = TD_AnalyticalDataObject().getFileData(fileName: "Monster") as! [NSString : NSDictionary]
        let soldierInfo = data[NSString(format: "Monster_%d",type)]
        
        soldierName = soldierInfo!["Name"] as! String
        image = soldierInfo!["Image"] as! String
        expenditure = Double(soldierInfo!["Expenditure"] as! String)!
        energy = Double(soldierInfo!["Energy"] as! String)!
        maxHP = Double(soldierInfo!["HP"] as! String)!
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
//        var mData = [Any]()
//        for i in 0..<mapData.count{
//            mData.append(mapData[mapData.count - i - 1])
//        }
        
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
        let bezierPath = UIBezierPath()
        
        
        for i in 0..<paths.count {
            let p = paths[i] as! CGPoint
            let center = CGPoint(x: p.x  - startPoint.x, y:  p.y - startPoint.y)
            
            if i == 0{
                bezierPath.move(to: center)
            }else{
                bezierPath.addLine(to: center)
            }
        }
        
        
        
        
        let action = SKAction.follow(bezierPath.cgPath, speed: CGFloat(moveSpeed))
        //        SKAction.
        
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
    
    /// 被攻击调用
    ///
    /// - Parameter damage: 攻击造成的伤害
    /// - Returns: 是否被击杀
    func beingAttacked(damage:Double) -> Bool {
        HP = HP - damage
        
        articleBloodSprite.size = CGSize(width: TD_Block_Width * CGFloat(HP / maxHP), height: articleBloodSprite.size.height)
        if (HP <= 0){//被击杀
            (superScene as! TD_ScenarioScene).destroyed(monster: self)
            (superScene as! TD_ScenarioScene).collectEnergy(energy: energy)
            return true
        }else{
            return false
        }
    }
}
