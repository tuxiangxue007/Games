//
//  TD_MonsterSprite.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_MonsterSprite: TD_BaseSpriteNode {

    
    var soldierName:String = "步兵"                   //士兵名称
    var image = "soldier"                            //士兵图片名称
    var expenditure:Double = 2.0                     //召唤消耗
    var maxHP:Double = 0.0                           //最大生命值
    var moveSpeed:Double = 50.0                      //移动速度
    var attackSpeed:Double = 1.0                     //攻击速度 x秒/次
    var alertScope:Double = 50.0                     //警戒范围半径
    var attackScope:Double = 20.0                    //攻击范围半径
    var attackNumber:Int = 1                         //单次攻击最大数量
    var attackBumberOfTimes:Int = 1                  //单次攻击造成伤害次数
    var attackGif = "attack"                         //攻击动画gif
    var moveGif = "towerMove"                        //移动动画gif
    var harm:Double = 1.0                            //造成伤害值
    var isFirst:Bool = true                          //是否是第一次出现
    var intro = "基础近战兵种"                         //兵种介绍
    var HP:Double = 0.0                              //单位当前剩余生命
    
    func layout(){
        initSoldierProperty(type: 1)
    }
    
    /// 初始化小兵属性
    func initSoldierProperty(type:Int){
        let data = TD_AnalyticalDataObject().getFileData(fileName: "Monster") as! [NSString : NSDictionary]
        let soldierInfo = data[NSString(format: "Monster_%d",type)]
        
        soldierName = soldierInfo!["Name"] as! String
        image = soldierInfo!["Image"] as! String
        expenditure = Double(soldierInfo!["Expenditure"] as! String)!
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
    
    
    func movePaths(paths:NSArray,startPoint:CGPoint,key:String){
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
        
        runActionWithThisOrScope(action: action, key: key)
    }
    func runActionWithThisOrScope(action:SKAction,key:String){
        self.run(action, withKey: key)
    }
}
