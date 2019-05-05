//
//  TD_Action.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/28.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_Action: NSObject {
    func action(paths:NSArray,startPoint:CGPoint,moveSpeed:CGFloat) ->  SKAction{
        let bezierPath = UIBezierPath()
        
        
        for i in 0..<paths.count {
            let p = paths[i] as! CGPoint
            let center = CGPoint(x: p.x  - startPoint.x, y:  p.y - startPoint.y)
            
            if i == 0{
                bezierPath.move(to: center)
            }else{
                bezierPath.addLine(to: center)
            }
        }
        
        
        
        
        let action = SKAction.follow(bezierPath.cgPath, speed: CGFloat(moveSpeed))
        return action
    }
}
