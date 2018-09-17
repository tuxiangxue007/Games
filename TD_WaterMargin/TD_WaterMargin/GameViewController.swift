//
//  GameViewController.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var scenarioScene = TD_ScenarioScene()
    var selScenarioScene = TD_GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            selScenarioScene = TD_GameScene(size: view.bounds.size)
            selScenarioScene.viewController = self;
            selScenarioScene.scaleMode = .aspectFill
            view.presentScene(selScenarioScene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        scenarioScene = TD_ScenarioScene(size: view.bounds.size)                                                 //创建场景
        scenarioScene.viewController = self;
    }
    
    func showScenarioScene(index:Int){
        
        if let view = self.view as! SKView? {
            scenarioScene.scenarioIndex = index
            view.presentScene(scenarioScene)
        }
    }
    
    func showSelScenarioScene(){
        if let view = self.view as! SKView? {
            view.presentScene(selScenarioScene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
