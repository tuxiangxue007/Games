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
    var scenarioIndex = 0
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
            scenarioIndex = index
            scenarioScene.scenarioIndex = index
            view.presentScene(scenarioScene)
        }
    }
    
    func showSelScenarioScene(){
        if let view = self.view as! SKView? {
            view.presentScene(selScenarioScene)
        }
    }
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    func showMsgbox(_message: String, _title: String, okTitle:String, cancelTitle:String,tag:Int){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        
        let btnOK = UIAlertAction(title: okTitle, style: .default) { (action) in
            if tag == 1{
                self.scenarioIndex = self.scenarioIndex + 1
                self.scenarioScene.scenarioIndex = self.scenarioIndex + 1
                self.scenarioScene.refreshScene(scenarioIndex: self.scenarioIndex)
            }
        }
        let btnCancel = UIAlertAction(title: cancelTitle, style: .default){ (action) in
            if tag == 1{
                self.showSelScenarioScene()
                self.selScenarioScene.refreshView()
            }
        }
        alert.addAction(btnOK)
        alert.addAction(btnCancel)
        self.present(alert, animated: true, completion: nil)
        
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
