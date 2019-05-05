//
//  GameViewController.swift
//  TD_ Journey
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("self.view,%@", self.view)
        
        NSLog("%@", (view as! SKView))
//        if let view = self.view as! SKView? {
//            let gameScene = TD_GameScene(size: view.bounds.size)
//            gameScene.viewController = self;
//            gameScene.scaleMode = .aspectFill
//            view.presentScene(gameScene)
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.present(TD_CheckpointViewController(), animated: true, completion: nil)
        
//       let vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
//        let helpVC = TD_CheckpointViewController(nibName: "HelpViewController", bundle: nil)
            
//            [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
//        [vc presentViewController: helpVC animated: YES completion:nil];
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
