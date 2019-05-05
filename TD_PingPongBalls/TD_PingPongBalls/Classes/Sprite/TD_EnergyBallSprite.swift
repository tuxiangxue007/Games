//
//  TD_EnergyBallSprite.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/28.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_EnergyBallSprite: TD_BaseSpriteNode {

    func layout(){
        physicsBody = SKPhysicsBody(circleOfRadius:size.width / 2.0)
        physicsBody?.collisionBitMask = 0
        //        physicsBody?.density = 0                //密度
        physicsBody?.mass = 1                     //质量
        physicsBody?.restitution = 0              //弹性
        physicsBody?.friction = 0.0               //摩擦力
        physicsBody?.linearDamping = 0.0          //线性阻力(空气阻力)
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody?.contactTestBitMask = TD_MonsterCategory

        
        physicsBody?.categoryBitMask = TD_EnergyBallCategory
    }
}
