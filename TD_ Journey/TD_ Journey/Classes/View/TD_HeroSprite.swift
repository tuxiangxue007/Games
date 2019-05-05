//
//  TD_HeroSprite.swift
//  TD_AncientRuins
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_HeroSprite: TD_BaseSpriteNode {
    var type = 0
    
    var actualHP = 10
    
    let homeSprite = SKNode()
    var enemySpriteList = [TD_CartSprite](){
        willSet {
            
        }
        didSet {
            //            if attackTower.count == 1 && oldValue.count == 0{
            //                self.removeOrScopeAction(key: TD_MoveToTower)
            //                self.updataAttack()
            //            }
            print("enemySpritnList已经发生改变")
        }
    }
    var ourSpriteList = [TD_CartSprite](){
        willSet {
            
        }
        didSet {

            print("ourSpritnList已经发生改变")
        }
    }
    var playCartData = [Int:TD_CartSprite]()            //在战场上的卡片
    var actionCartData = [Int:TD_CartSprite]()          //需要行动的卡片
    func layout(){
        initPhysicsBoby()
        creatHomeRange()
    }
    func initPhysicsBoby(){
        addChild(homeSprite)
        
        homeSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: TD_Block_Width, height: TD_Block_Height * 5), center: CGPoint(x:0, y: 0))
        //        physicsBody.colo
        homeSprite.physicsBody?.collisionBitMask = 0
        //        physicsBody?.density = 0                //密度
        homeSprite.physicsBody?.mass = 1                     //质量
        homeSprite.physicsBody?.restitution = 0              //弹性
        homeSprite.physicsBody?.friction = 0.0               //摩擦力
        homeSprite.physicsBody?.linearDamping = 0.0          //线性阻力(空气阻力)
        homeSprite.physicsBody?.allowsRotation = false
        homeSprite.physicsBody?.affectedByGravity = false
        
        //        if  soldierCategory == TD_Soldier1Category {
        //            physicsBody?.contactTestBitMask = TD_TowerCategory | TD_Soldier2Category//碰撞检测
        //        }else{
        //            physicsBody?.contactTestBitMask = TD_TowerCategory | TD_Soldier1Category//碰撞检测
        //        }
        
        //        physicsBody?.contactTestBitMask = TD_TowerCategory | TD_Soldier1Category | TD_Soldier2Category//碰撞检测
        
        if type == 0 {
            //            physicsBody?.contactTestBitMask = TD_EnemyCartCategory
            homeSprite.physicsBody?.categoryBitMask = TD_OurHeroCategory
        }else{
            //            physicsBody?.contactTestBitMask = TD_OurHeroHomeCategory
            homeSprite.physicsBody?.categoryBitMask = TD_EnemyHeroCategory
        }
        
        
        //        physicsBody?.isDynamic = true
        //        physicsBody?.isResting = true
        self.zPosition = 20
    }
    func creatHomeRange(){
        
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: TD_Block_Width * 4, height: TD_Block_Height * 5), center: CGPoint(x: type == 0 ? TD_Block_Width * 2 + TD_Block_Width * 0.5:-TD_Block_Width * 2 - TD_Block_Width * 0.5, y: 0))
//        physicsBody.colo
        physicsBody?.collisionBitMask = 0
        //        physicsBody?.density = 0                //密度
        physicsBody?.mass = 1                     //质量
        physicsBody?.restitution = 0              //弹性
        physicsBody?.friction = 0.0               //摩擦力
        physicsBody?.linearDamping = 0.0          //线性阻力(空气阻力)
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        
//        if  soldierCategory == TD_Soldier1Category {
//            physicsBody?.contactTestBitMask = TD_TowerCategory | TD_Soldier2Category//碰撞检测
//        }else{
//            physicsBody?.contactTestBitMask = TD_TowerCategory | TD_Soldier1Category//碰撞检测
//        }

//        physicsBody?.contactTestBitMask = TD_TowerCategory | TD_Soldier1Category | TD_Soldier2Category//碰撞检测
        
        if type == 0 {
//            physicsBody?.contactTestBitMask = TD_EnemyCartCategory
            physicsBody?.categoryBitMask = TD_OurHeroHomeCategory
        }else{
//            physicsBody?.contactTestBitMask = TD_OurHeroHomeCategory
            physicsBody?.categoryBitMask = TD_EnemyHeroHomeCategory
        }
    

//        physicsBody?.isDynamic = true
//        physicsBody?.isResting = true
        self.zPosition = 20
    }
    
    
    /// 被攻击
    ///
    /// - Parameters:
    ///   - attack: 伤害
    ///   - attackType: 伤害类型 1：物理伤害、1:魔法伤害
    /// - Returns: 是否被击杀
    func beingAttacked(attack:Int,attackType:Int) -> Bool {
        var ar = 0
//        if attackType == 0 {
//            ar = actualArmor
//        }else{
//            ar = actualMagicArmor
//        }
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
            print("该英雄被击杀 --");
//            (self.superScene as! TD_FightScene).removeSptiye(key: coordinates)
//            removeFromParent()
            return true
        }
        
        return false
    }

    
}
