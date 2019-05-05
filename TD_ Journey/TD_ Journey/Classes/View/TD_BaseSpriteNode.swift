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
//    cartAttack_2001.gif
    func runActionGif(fileName:String,completion: @escaping (_ result : Bool)->()) -> () {
        let path = Bundle.main.path(forResource: fileName, ofType: "gif")!

        let coinTextures = load(imagePath: path as String)!
        let action = SKAction.animate(with: coinTextures, timePerFrame: 0.3)
        
        run(action) {
            self.removeAllActions()
            completion(true)
        }
//        run(action, withKey: "attack")
//        let timer = Timer.init(timeInterval: 1, repeats: false) { (kTimer) in
//            self.removeAction(key: "attack")
//            completion(true)
//        }
//        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
//        // TODO : 启动定时器
//        timer.fire()
    }
    func runActionGif(filePath:String,isRepeat:Bool,key:String){
        let coinTextures = load(imagePath: filePath)!
        
        runGif(textures: coinTextures, timePerFrame: 0.1,isRepeat: isRepeat, key:key)
    }
    
    func runActionGif(fileName:String){
        let path = Bundle.main.path(forResource: fileName, ofType: "gif")!
        
        runActionGif(filePath: path as String, isRepeat: false, key:"xxx")
    }
    
    func runActionGif(fileName:String,isRepeat:Bool,key:String){
        let path = Bundle.main.path(forResource: fileName, ofType: "gif")!
        
        runActionGif(filePath: path as String, isRepeat: isRepeat, key:key)
    }
    func runGif(textures:[SKTexture],timePerFrame:TimeInterval,isRepeat:Bool,key:String){
        
        var action = SKAction()
        if isRepeat{
            action = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: timePerFrame))
            run(action, withKey: key)
            
        }else{
            action = SKAction.animate(with: textures, timePerFrame: timePerFrame)
            run(action) {
//                self.removeAction(forKey: "xxx")
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
