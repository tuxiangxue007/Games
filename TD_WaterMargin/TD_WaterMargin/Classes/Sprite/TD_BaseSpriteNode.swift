//
//  TD_BaseSpriteNode.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit

class TD_BaseSpriteNode: SKSpriteNode {
    var tag = 0
    var superScene = SKScene()
    
    
    func runActionGif(filePath:NSString,isRepeat:Bool,key:NSString){
        let coinTextures = load(imagePath: filePath as String)!
        
        runGif(textures: coinTextures, timePerFrame: 0.1,isRepeat: isRepeat, key:key)
    }
    
    func runActionGif(fileName:NSString){
        let path = Bundle.main.path(forResource: fileName as String, ofType: "gif")!
        
        runActionGif(filePath: path as NSString, isRepeat: false, key:"xxx")
    }
    
    func runActionGif(fileName:NSString,isRepeat:Bool,key:NSString){
        
        let path = Bundle.main.path(forResource: fileName as String, ofType: "gif")!
        
        runActionGif(filePath: path as NSString, isRepeat: isRepeat, key:key)
    }
    func runGif(textures:[SKTexture],timePerFrame:TimeInterval,isRepeat:Bool,key:NSString){
        
        var action = SKAction()
        if isRepeat{
            action = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: timePerFrame))
            run(action, withKey: key as String)
            
        }else{
            action = SKAction.animate(with: textures, timePerFrame: timePerFrame)
            run(action) {
                self.removeAction(key: "xxx")
            }
        }
    }
    func removeAction(key:String){
        self.removeAction(forKey: key)
    }
    func load(imagePath:String)->[SKTexture]?{
        guard let imageSource = CGImageSourceCreateWithURL(URL(fileURLWithPath: imagePath) as CFURL, nil) else {
            return nil
        }
        let count = CGImageSourceGetCount(imageSource)
        var images:[CGImage] = []
        
        for i in 0..<count{
            guard let img = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {continue}
            
            images.append(img)
        }
        return images.map {SKTexture(cgImage:$0)}
    }
}
