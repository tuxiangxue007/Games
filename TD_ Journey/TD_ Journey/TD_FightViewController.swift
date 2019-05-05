//
//  TD_FightViewController.swift
//  TD_ Journey
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class TD_FightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sView = SKView(frame: view.bounds)
        view.addSubview(sView)
        let gameScene = TD_FightScene(size: view.bounds.size)
        gameScene.viewController = self;
        gameScene.scaleMode = .aspectFill
        sView.presentScene(gameScene)
        sView.ignoresSiblingOrder = true
        sView.showsFPS = true
        sView.showsNodeCount = true
    }
    
}
