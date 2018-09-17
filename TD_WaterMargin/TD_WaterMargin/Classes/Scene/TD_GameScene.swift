//
//  TD_GameScene.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_GameScene: TD_BaseScene ,SKSceneDelegate{

    var scenarioIndex = 1                                       //关卡
    
    var allSceneRecordData = [String:NSDictionary]()            //关卡通关记录数据
    
    
    override func didMove(to view: SKView) {
        allSceneRecordData = TD_AnalyticalDataObject().getFileData(fileName: "SceneRecord") as! [String : NSDictionary]
        
        
        
        creatScene();
    }

    

    func creatScene() {
        for i in 0 ..< allSceneRecordData.count {
            let data = allSceneRecordData[String(format: "Scene_%d", i + 1)]

            let sp = TD_SelectScenarioSprite(color: UIColor.lightGray, size: CGSize(width: 80, height: 80))
            sp.tag = 1000 + i
            sp.name = "selectScenario"
            sp.data = data as! [String : Any]
            sp.position = CGPoint(x: 26 + i % 6 * (80 + 27) + 40, y: 30 + (80 + 30) * Int(i / 6) + 40)
            addChild(sp)
        }
        

    }

    func gameOver(){
        print("游戏结束")
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
//        let bodyA = contact.bodyA
//        let bodyB = contact.bodyB
        
       
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        print("bodyA.categoryBitMask:",bodyA.categoryBitMask)
        print("bodyB.categoryBitMask:",bodyB.categoryBitMask)
        
        
        
        
        
    }
    
    


    func update(_ currentTime: TimeInterval,for scene: SKScene){
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)     //进行类  型转化
        let point = touch.location(in:self)
        let node = self.atPoint(point)
        
        if (node.name != nil) {
            if (node.name == "selectScenario") {//判断是关卡选择按钮
                (viewController as! GameViewController).showScenarioScene(index: (node as! TD_SelectScenarioSprite).tag - 1000 + 1)
            }
        }else{
        }

    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = ((touches as NSSet).anyObject() as AnyObject)     //进行类  型转化
//        let point = touch.location(in:self)
//        let node = self.atPoint(point)
       
    }
    
}