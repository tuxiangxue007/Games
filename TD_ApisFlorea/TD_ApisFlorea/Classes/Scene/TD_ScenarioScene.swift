//
//  TD_ScenarioScene.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//  关卡主场景

import SpriteKit
import UIKit

class TD_ScenarioScene: TD_BaseScene ,SKPhysicsContactDelegate {
    
    var timer = Timer()
    var allSceneData = [String:Any]()                   //场景布局以及怪物信息数据
    var towersData = [String:Any]()                     //防御塔数据

    
    var scenarioIndex = 0                               //当前关卡
    var mapData = [Any]()                               //记录场景布局信息
    var monsterData = [String]()                        //记录关卡出怪顺序以及信息
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        

    }
    
    func refreshScene(scenarioIndex:Int){
        self.scenarioIndex = scenarioIndex
        refresh()
    }
    func refresh() {
        removeAllChildren()
        
        createFlivver()
        createFlivver()
    }
    
    func createFlivver(){
        
    }
}
