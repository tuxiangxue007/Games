//
//  TD_SceneElement.swift
//  TD_AncientRuins
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_SceneElementSprite: TD_BaseSpriteNode {
    var blockType = "0"
    
    func layout() {
        refreshView()
    }
    func refreshView(){
        
        
//        let showBlock = SKSpriteNode(imageNamed: String(format: "mapElement_%@", blockType))
//        showBlock.position = CGPoint(x: position.x, y: position.y + (TD_Block_AspectRatio_Show - 1) * TD_Block_Width * 0.5)
//        showBlock.size = CGSize(width: TD_Block_Width, height: TD_Block_Width * TD_Block_AspectRatio_Show)
//        superScene.addChild(showBlock)
    }
}
