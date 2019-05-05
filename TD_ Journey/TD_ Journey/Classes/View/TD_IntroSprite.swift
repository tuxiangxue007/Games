//
//  TD_IntroSprite.swift
//  TD_ Journey
//
//  Created by mac on 2018/11/12.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_IntroSprite:SKNode {
    var cardInfo = [String:Any](){
        willSet {
            
        }
        didSet {
            self.refreshView()
            print("cardInfo已经发生改变")
        }
    }
    
    func layout(){
//        refreshView()
    }
    func refreshView(){
        removeAllChildren()
        let introNode = SKSpriteNode(color: UIColor.black, size: CGSize(width: TD_Block_Width * 2, height: TD_Block_Height * 2))
        addChild(introNode)
        
        var attStr = NSMutableAttributedString(string: "人类士兵/精英")
        attStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 7))
        let titleText = SKLabelNode(attributedText: attStr)
//        titleText.fontColor = UIColor.white
//        titleText.fontSize = 13
        titleText.position = CGPoint(x: 0, y: TD_Block_Height / 2.0 + 13)
        introNode.addChild(titleText)
        
        _ = getInfoAttStr()
//        let introStr = String(format: "%@", NSLocalizedString("topic", comment: ""))
        attStr = NSMutableAttributedString(string: "警戒1:攻击范围为周围一格。")
//        attStr.addAttributes(NSAttributedStringKey.foregroundColor, range: NSRange(location: 0, length: 4))
        attStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.orange, range: NSRange(location: 0, length: 4))
        attStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location: 4, length: 10))
        let intrText = SKLabelNode(attributedText: attStr)
        intrText.preferredMaxLayoutWidth = TD_Block_Width * 2 - 15
        intrText.position = CGPoint(x: 0, y: -10)
        intrText.numberOfLines = 0
        introNode.addChild(intrText)
    }
    
    
    func getInfoAttStr() -> NSAttributedString {
        let relatedSkills = cardInfo["RelatedSkills"] as! [String]
        var introStr = ""
        
        for item in relatedSkills {
            let data = (TD_AnalyticalDataObject().getFileData(fileName: "Skills"))[item] as! NSDictionary
            var key = data["Name"] as! String
            let name = NSLocalizedString(key, comment: "default")
            key = data["Intro"] as! String
            let intro = NSLocalizedString(key, comment: "default")
            print("name:",name,"intro:",intro)
//                TD_Internationalization_Skills2Name
//            NSLocalizedString("topic", comment: "")
//            let type = Int(data["Type"] as! String)
//            if type! < 10{//属性类技能
//                initSkills(attData: data)
//            }
//            else if type! >= 10 && type! < 20{//动作类技能
//
//            }
//            else if type! >= 20 && type! < 30{//光环类技能
//
//            }
//            else if type! == 100{//限制类技能
//
//            }
//            else if type! == 101{//召唤类技能
//
//            }
        }
        let attStr = NSMutableAttributedString(string: introStr)
        return attStr
    }
}
