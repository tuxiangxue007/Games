//
//  TD_GameScene.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_GameScene: TD_BaseScene ,SKSceneDelegate,SKPhysicsContactDelegate{

    
    var allSceneRecordData = [String:NSDictionary]()            //关卡通关记录数据
    var ballsSprite = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        
//        setPhysicsBody();
//        createBalls();
        let ball = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 20))
        
        ball.position = CGPoint(x: 100, y: 100)
        
        addChild(ball)
        let sp = SKSpriteNode(color: UIColor.red, size: CGSize(width: 80, height: 80))
        sp.zPosition = 100
//        sp.superScene = self
//        sp.tag = 1000 + i
        sp.name = "selectScenario"
//        sp.data = data as! [String : Any]
        sp.position = CGPoint(x: 100, y: 300)
        addChild(sp)
    }

    func setPhysicsBody(){
        physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)//重力
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)//物理世界的边界
        //        physicsBody?.contactTestBitMask = TD_ProtagonistCategory | TD_MonsterCategory  //产生碰撞的物理类型
        physicsBody?.categoryBitMask = TD_WorldCategory     //标记自身的物理类型
        physicsBody?.friction = 0 //阻力 为零时完全反弹
    }
    
    func createBalls(){
        ballsSprite = TD_BallsSprite(color: UIColor.white, size: CGSize(width: 20, height: 20))
        addChild(ballsSprite)
        (ballsSprite as! TD_BallsSprite).layout(ballsType:"1")
        
        let ball = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: 20))
        
        ball.position = CGPoint(x: 100, y: 100)
        
        addChild(ball)
    }
}
