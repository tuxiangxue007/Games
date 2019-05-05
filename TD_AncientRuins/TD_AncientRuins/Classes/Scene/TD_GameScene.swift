//
//  TD_GameScene.swift
//  TD_Decathlon
//
//  Created by mac on 2018/7/9.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_GameScene: TD_BaseScene ,SKSceneDelegate{

    var allSceneData = [String:Any]()                   //场景布局原始数据
    var mapData = [Any]()                               //记录场景布局转化数据
    var scenarioIndex = 1                               //当前关卡
    
    override func didMove(to view: SKView) {
        

        allSceneData = TD_AnalyticalDataObject().getFileData(fileName: "Scene") as! [String : NSDictionary]
        backgroundColor = UIColor.blue
        refreshView();
    }

    

    func refreshView() {

        removeAllChildren()
        
        let data = allSceneData[String(format: "Scene_%d", scenarioIndex)] as! NSDictionary
        let sceneData = data["scene"] as! NSArray
        for i in 0..<sceneData.count {
            
//            let lineData = NSMutableArray()
            var lineStr = sceneData[sceneData.count - i - 1] as! String
            let maxNum = lineStr.count
            
            let lineData = NSMutableArray()
            for j in 0..<maxNum {
                let blocktype = lineStr.first
                lineStr.removeFirst()
                
                lineData.add(blocktype as Any)
                
                let blockSprite = TD_SceneElementSprite()
                blockSprite.blockType = String(blocktype!)
                blockSprite.superScene = self
                var indentation = CGFloat(0.0)
                if (i % 2 == 1){
                    indentation = TD_Block_Width * CGFloat(0.5)
                }
                blockSprite.position = CGPoint(x: TD_Block_Width * CGFloat(Double(j) + 0.5) + indentation, y: TD_Block_Width * TD_Block_AspectRatio_Typography * CGFloat(i) + TD_Block_Width * 0.5)
                blockSprite.size = CGSize(width: TD_Block_Width, height: TD_Block_Width)
                addChild(blockSprite)
                blockSprite.layout()
            }
            
            mapData.append(lineData)
        }
        
        
        
    }

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = ((touches as NSSet).anyObject() as AnyObject)     //进行类  型转化
//        let point = touch.location(in:self)
//        let node = self.atPoint(point)
//
//        if (node.name != nil) {
//            if (node.name == "selectScenario") {//判断是关卡选择按钮
//                (viewController as! GameViewController).showScenarioScene(index: (node as! TD_SelectScenarioSprite).tag - 1000 + 1)
//            }
//        }else{
//        }
    }
    
}
