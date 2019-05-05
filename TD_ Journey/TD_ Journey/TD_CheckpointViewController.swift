//
//  TD_ CheckpointViewController.swift
//  TD_ Journey
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class TD_CheckpointViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
//        NSLog("self.view,%@", self.view)
//        if let view = self.view as! SKView? {
//            let gameScene = TD_GameScene(size: view.bounds.size)
//            gameScene.viewController = self;
//            gameScene.scaleMode = .aspectFill
//            view.presentScene(gameScene)
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
//        self.view.add
//        (view as! SKView).presentScene(<#T##scene: SKScene?##SKScene?#>)
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
//        let helpVC = TD_FightViewController(nibName: "TD_FightViewController", bundle: nil);
        self.present(TD_FightViewController(), animated: true, completion: nil)
    }

}
