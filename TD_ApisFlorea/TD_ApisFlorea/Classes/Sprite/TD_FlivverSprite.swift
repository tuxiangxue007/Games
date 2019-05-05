//
//  TD_MonsterSprite.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_FlivverSprite: TD_BaseSpriteNode {

    var monsterType = "1"                                //怪物种类

    
    func layout() {
        initPhysicsBody()
        creatView()
    }
    /// 初始化物理属性
    func initPhysicsBody(){
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width / 2.0, height: size.height / 2.0))
        //physicsBody?.
        //physicsBody?.density = 1                  //密度
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
        
    }
}
