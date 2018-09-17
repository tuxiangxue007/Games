//
//  TD_ScenarioScene.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_ScenarioScene: TD_BaseScene ,SKPhysicsContactDelegate {
    var allSceneData = [String:NSDictionary]()          //场景布局数据
    
    var scenarioIndex = 0
    var mapData = [[String]]()
    
    
    var startPointList = [CGPoint]()
    var endPointList = [CGPoint]()
    
    var startPoint = CGPoint();
    var endPoint = CGPoint();
    var monsterSpriteList = [TD_MonsterSprite]()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        
        allSceneData = TD_AnalyticalDataObject().getFileData(fileName: "Scene") as! [String : NSDictionary]
        
        
        
        creatScene();
    }
    
    func creatScene() {

        
        let data = allSceneData[String(format: "Scene_%d", scenarioIndex)]
        let mapData = NSMutableArray()
        let sceneData = data!["scene"] as! NSArray
        for i in 0..<sceneData.count {
            
            let lineData = NSMutableArray()
            var lineStr = sceneData[i] as! String
            let maxNum = lineStr.count
            for j in 0..<maxNum {
                let blocktype = lineStr.first
                lineStr.removeFirst()
                var blockSprite = SKSpriteNode()
                let position = CGPoint(x: TD_Block_Width / 2.0 + 10 + TD_Block_Width * CGFloat(j), y: TD_Block_Width / 2.0 + TD_Game_TopClearance + TD_Block_Width * CGFloat(i))
                
                print(blockSprite.position)
                lineData.add(blocktype as Any)
                switch blocktype {
                case "0"://道路
                    blockSprite = SKSpriteNode(color: UIColor.white, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    break
                case "1"://空地
                    blockSprite = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    break
                case "2":
                    break
                case "3":
                    break
                case "4":
                    break
                case "Y":
                    blockSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    startPointList.append(position)
                    break
                case "Z":
                    blockSprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    endPointList.append(position)
                    break
                default:
                    blockSprite = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    break
                }
                blockSprite.position = position
                addChild(blockSprite)
            }
            mapData.add(lineData)
        }
        
        startPoint = startPointList.first!
        endPoint = endPointList.first!
        creatMonsterSprte(type: 1)
        setPhysicsBody()    //设置物理世界
    }
    func setPhysicsBody(){
        physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)//重力
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)//物理世界的边界
        //        physicsBody?.contactTestBitMask = TD_ProtagonistCategory | TD_MonsterCategory  //产生碰撞的物理类型
        physicsBody?.categoryBitMask = TD_WorldCategory     //标记自身的物理类型
        //        physicsBody?.friction = 0 //阻力 为零时完全反弹
        
    }
    
    func creatMonsterSprte(type:Int){
        let monsterSprite = TD_MonsterSprite(imageNamed: String(format: "monster_%d", type));
        monsterSprite.size = CGSize(width: TD_Block_Width, height: TD_Block_Width)
        monsterSprite.position = startPoint
        addChild(monsterSprite)
        
        monsterSprite.movePaths(paths: [startPoint,endPoint], startPoint: startPoint, key: "move")
//        let action = SKAction.move(to: endPoint, duration: 2)
//        monsterSprite.run(action)
//        (named: "move", duration: 2)
    }

}
