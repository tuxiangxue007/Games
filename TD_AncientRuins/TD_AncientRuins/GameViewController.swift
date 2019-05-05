//
//  GameViewController.swift
//  TD_AncientRuins
//
//  Created by mac on 2018/10/16.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            let gameScene = TD_GameScene(size: view.bounds.size)
            gameScene.viewController = self;
            gameScene.scaleMode = .aspectFill
            view.presentScene(gameScene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }

    }


}
