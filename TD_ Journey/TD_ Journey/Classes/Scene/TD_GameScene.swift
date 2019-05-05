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
