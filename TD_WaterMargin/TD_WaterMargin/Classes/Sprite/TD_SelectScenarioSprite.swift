//
//  TD_SelectScenarioSprite.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_SelectScenarioSprite: TD_BaseSpriteNode {
    var data = [String : Any]()
    
    func layout() {
        refreshView()
    }
    
    func refreshView(){
        
        
        let img = SKSpriteNode(imageNamed: "sell")
        
        img.size = CGSize(width: 40, height: 40)
        img.position = CGPoint(x: position.x, y: position.y + 15)
        
        superScene.addChild(img)
        
        let star = Int(data["star"] as! String)
        for i in 0..<star! {
            
            
            let img = SKSpriteNode(imageNamed: "star")
            
            img.size = CGSize(width: 20, height: 20)
            img.position = CGPoint(x: position.x - size.width / 2.0 + 5 + 10 + (20 + 5) * CGFloat(i), y: position.y - 20)
            superScene.addChild(img)
        }
        
    }
    
    
}
