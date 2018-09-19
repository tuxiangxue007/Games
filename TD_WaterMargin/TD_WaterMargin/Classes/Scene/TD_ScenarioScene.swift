//
//  TD_ScenarioScene.swift
//  TD_WaterMargin
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import SpriteKit
import UIKit

class TD_ScenarioScene: TD_BaseScene ,SKPhysicsContactDelegate {
    
    var timer = Timer()
    var allSceneData = [String:Any]()                   //场景布局以及怪物信息数据
    var towersData = [String:Any]()                     //防御塔数据

    
    
    var scenarioIndex = 0                               //当前关卡
    var mapData = [Any]()                               //记录场景布局信息
    var monsterData = [String]()                        //记录关卡出怪顺序以及信息
    
    var startPointList = [CGPoint]()                    //出怪点数组
    var endPointList = [CGPoint]()                      //怪物目的地数组
    
    var startPoint = CGPoint();                         //出怪点
    var endPoint = CGPoint();                           //怪物目的地
    
    var selClearBlockSprite = SKSpriteNode()            //用于标记被选中的空地
    var selClearBlock = SKNode()
    var towersMenuView = SKSpriteNode()
    var isBeingBuilt = false
    
    var selTowerSprite = TD_TowerSprite()               //记录正在建造的防御塔
    
    var towersList = [TD_TowerSprite]()                 //记录防御塔数组
    var monsterSpriteList = [TD_MonsterSprite]()        //记录场上怪物的数组
    
    var countdown = 60                                  //出怪倒计时
    var countdownLab = SKLabelNode()                    //出怪倒计时显示控件
    var HP = 0.0                                        //关卡中血量
    var hpLab = SKLabelNode()                           //关卡血量显示控件
    var energy = 100.0                                  //关卡中血量
    var energyLab = SKLabelNode()                       //剩余能量显示控件
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        
        
        allSceneData = TD_AnalyticalDataObject().getFileData(fileName: "Scene") as! [String : NSDictionary]
        towersData = TD_AnalyticalDataObject().getFileData(fileName: "Towers") as! [String : NSDictionary]
        creatScene();
    }
    
    func creatScene() {
        
        
        let data = allSceneData[String(format: "Scene_%d", scenarioIndex)] as! NSDictionary
        
        HP = Double(data["HP"] as! String)!

        let sceneData = data["scene"] as! NSArray
        monsterData = data["monster"] as! [String]
        for i in 0..<sceneData.count {
            
            let lineData = NSMutableArray()
            var lineStr = sceneData[i] as! String
            let maxNum = lineStr.count
            for j in 0..<maxNum {
                let blocktype = lineStr.first
                lineStr.removeFirst()
                var blockSprite = SKSpriteNode()
                let position = CGPoint(x: TD_Block_Width / 2.0 + 10 + TD_Block_Width * CGFloat(j), y: TD_Block_Width / 2.0 + TD_Game_TopClearance + TD_Block_Width * CGFloat(i))
                
                
                lineData.add(blocktype as Any)
                switch blocktype {
                case "0"://道路
                    blockSprite = SKSpriteNode(color: UIColor.white, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    break
                case "1"://空地
                    blockSprite = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    blockSprite.name = TD_Name_Clearing
                    break
                case "2":
                    break
                case "3":
                    break
                case "4":
                    break
                case "Y":
                    blockSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    startPointList.append(position)
                    break
                case "Z":
                    blockSprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    endPointList.append(position)
                    break
                default:
                    blockSprite = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
                    break
                }
                blockSprite.position = position
                addChild(blockSprite)
            }
            mapData.append(lineData)
        }
        
        selClearBlockSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: TD_Block_Width, height: TD_Block_Width))
        selClearBlockSprite.isHidden = true
        addChild(selClearBlockSprite)
        
        startPoint = startPointList.first!
        endPoint = endPointList.first!
        startCreatMonsterSprite()
        setPhysicsBody()    //设置物理世界
        
        
        countdownLab = SKLabelNode(text: String(countdown))
        countdownLab.name = TD_Name_CountdownLab
        countdownLab.position = CGPoint(x: 50, y: TD_ScreenH - 80)
        countdownLab.fontColor = UIColor.blue
        addChild(countdownLab)
        
        hpLab = SKLabelNode(text: String(HP))
        hpLab.name = TD_Name_HPLab
        hpLab.position = CGPoint(x: TD_ScreenW - 80, y: TD_ScreenH - 80)
        hpLab.fontColor = UIColor.red
        addChild(hpLab)
        
        
        energyLab = SKLabelNode(text: String(HP))
        energyLab.name = TD_Name_EnergyLab
        energyLab.position = CGPoint(x: TD_ScreenW / 2.0, y: TD_ScreenH - 80)
        energyLab.fontColor = UIColor.red
        addChild(energyLab)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)     //进行类  型转化
        let point = touch.location(in:self)
        let node = self.atPoint(point)
        if  node.name == nil{
            return
        }
        if isBeingBuilt{
            isBeingBuilt = false
            if node.name == TD_Name_ConfirmItem{
                selTowerSprite.alpha = 1.0
                selTowerSprite.isActivate = true
                selTowerSprite.hiddenScopeAttack()
                selTowerSprite.hiddenConfirmBuild()
                
                
                
                let data = towersData[String(format: "Towers_%d", selTowerSprite.towerType)] as! NSDictionary
                let expenditure = Double(data["Expenditure"] as! String)
                energy = energy - expenditure!
                energyLab.text = String(energy)
            }else if node.name == TD_Name_ConfirmItem{
                selTowerSprite.removeAllFromParent()
                isBeingBuilt = false
                
                let index = towersList.index(of: selTowerSprite)
                if index != nil{
                    towersList.append(selTowerSprite)
                }
            }else if node.name == TD_Name_UpgradeItem{
                selTowerSprite.hiddenOperationMenuView()
            }else if node.name == TD_Name_SellItem{
                selTowerSprite.hiddenOperationMenuView()
            }else if node.name == TD_Name_ReturnItem{
                selTowerSprite.hiddenOperationMenuView()
            }
            return
        }
        if node.name == TD_Name_Clearing {//空地
            selClearBlock = node
            selClearBlockSprite.position = selClearBlock.position
            selClearBlockSprite.isHidden = false
            showCreatTowersMenu()
        }else{
            
            towersMenuView.isHidden = true
            selClearBlockSprite.isHidden = true
            if (node.name?.hasPrefix("CreatMenu_"))! {//判断是建造菜单按钮
                let towerType = Int(String((node.name?.last)!))
                let data = towersData[String(format: "Towers_%d", towerType!)] as! NSDictionary
                let expenditure = Double(data["Expenditure"] as! String)
                if energy >= expenditure!{
                    
                    
                    towersMenuView.isHidden = true
                    let name = node.name! as NSString
                    let img = name.substring(from: 10)
                    let towerSprite = TD_TowerSprite(imageNamed: img)
                    towerSprite.name = TD_Name_Tower
                    towerSprite.alpha = 0.4
                    towerSprite.position = selClearBlockSprite.position
                    towerSprite.size = selClearBlockSprite.size
                    towerSprite.superScene = self
                    
                    addChild(towerSprite)
                    towerSprite.layout(towerType: Int(String(name.substring(from: 17).first!))!)
                    towersList.append(towerSprite)
                    selTowerSprite = towerSprite
                    isBeingBuilt = true
                    
                    towerSprite.showScopeAttack()
                    towerSprite.showConfirmBuild()
                }else{//能量不足
                    (viewController as! GameViewController).showMsgbox(_message: "能量不足")
                }
                
                
            }else if node.name == TD_Name_CountdownLab{//点击出怪倒计时
                if self.countdown > 3{
                    self.countdown = 3
                }
                
            }else if node.name == TD_Name_Tower{//点击防御塔
                isBeingBuilt = true
                selTowerSprite = node as! TD_TowerSprite
                selTowerSprite.showOperationMenuView()
            }else if node.name == TD_Name_ScopeAttack{
                node.isHidden = true
            }
        }
    }
    func setPhysicsBody(){
        physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)//重力
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)//物理世界的边界
        //        physicsBody?.contactTestBitMask = TD_ProtagonistCategory | TD_MonsterCategory  //产生碰撞的物理类型
        physicsBody?.categoryBitMask = TD_WorldCategory     //标记自身的物理类型
        //        physicsBody?.friction = 0 //阻力 为零时完全反弹
        
    }
    func startCreatMonsterSprite(){
        
        
        let monsterStr = monsterData.first
        monsterData.removeFirst()
        creatTeamMonsterSprte(monsterStr: monsterStr!)
        
        timer = Timer.init(timeInterval: 1, repeats: true) { (kTimer) in
            self.countdown = self.countdown - 1
            self.countdownLab.text = String(self.countdown)
            if (self.countdown == 0){
                let monsterStr = self.monsterData.first
                self.monsterData.removeFirst()
                self.creatTeamMonsterSprte(monsterStr: monsterStr!)
                self.countdown = 60
                if self.monsterData.count < 1{
                    self.timer.invalidate()            //停止
                }
            }
        }
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        // TODO : 启动定时器
        timer.fire()

//        timer.invalidate()            //停止
    
       
    }
    
    func creatTeamMonsterSprte(monsterStr:String) {
        var str = monsterStr
        let monster = str.first
        creatMonsterSprte(type: Int(String(monster!))!)
        str.removeFirst()
        
        if str.count >= 1 {
            let time: TimeInterval = 1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                self.creatTeamMonsterSprte(monsterStr: str)
            }
        }
    }
    
    func creatMonsterSprte(type:Int){
        let monsterSprite = TD_MonsterSprite(imageNamed: String(format: "monster_%d", type));
        monsterSprite.size = CGSize(width: TD_Block_Width, height: TD_Block_Width)
        monsterSprite.position = startPoint
        monsterSprite.isAggressive = false
        monsterSprite.targetPosition = endPoint
        monsterSprite.superScene = self
        addChild(monsterSprite)
        monsterSprite.layout(monsterType: type)
        monsterSpriteList.append(monsterSprite)
    }
    
    /// 显示建造防御塔菜单
    func showCreatTowersMenu() {
        if (towersMenuView.name == nil){
            towersMenuView = SKSpriteNode(color: UIColor.cyan, size: CGSize(width: TD_ScreenW, height: 60))
            towersMenuView.position = CGPoint(x: towersMenuView.size.width / 2.0, y: towersMenuView.size.height / 2.0)
            addChild(towersMenuView)
            towersMenuView.isHidden = true
            
//            let towersData = [["name":"能量塔","img":"towers_1"],["name":"能量塔","img":"towers_1"],["name":"能量塔","img":"towers_1"],["name":"能量塔","img":"towers_1"],["name":"能量塔","img":"towers_1"],["name":"能量塔","img":"towers_1"]]
            for i in 0..<towersData.count{
                let data = towersData[String(format: "Towers_%d", scenarioIndex + 1)] as! NSDictionary
                let towerMenu = SKSpriteNode(imageNamed: String(format: "%@_1", data["Image"] as! String))
                towerMenu.size = CGSize(width: 60, height: 60)
                towerMenu.name = String(format: "CreatMenu_%@_1", data["Image"] as! String)
                towerMenu.position = CGPoint(x: CGFloat(60 * i) + towerMenu.size.width / 2.0 - towersMenuView.size.width / 2.0, y: towerMenu.size.height / 2.0 - towersMenuView.size.height / 2.0)
                towersMenuView.addChild(towerMenu)
            }
        }
    
        towersMenuView.isHidden = false
    }
    func didBegin(_ contact: SKPhysicsContact) {//开始接触碰撞
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        if bodyB.categoryBitMask == TD_TowerAttackCategory {//bodyA 进入防御塔攻击范围
            let towerSprite = getTowerSprite(body: bodyB)
            let monsterSprite = getMonsterSprite(body: bodyA)
            towerSprite.attackRange.append(monsterSprite)
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {//结束碰撞
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        if bodyB.categoryBitMask == TD_TowerAttackCategory {//bodyA 离开防御塔攻击范围
            let towerSprite = getTowerSprite(body: bodyB)
            let monsterSprite = getMonsterSprite(body: bodyA)
            let index = towerSprite.attackRange.index(of: monsterSprite)
            towerSprite.attackRange.remove(at: index!)
        }
    }
    func getTowerSprite(body:SKPhysicsBody) -> TD_TowerSprite {
        for towerSprite in towersList {
            if (towerSprite.scopeAttack.physicsBody == body){
                return towerSprite
            }
        }
        return TD_TowerSprite()
    }
    func getMonsterSprite(body:SKPhysicsBody) -> TD_MonsterSprite {
        for mosterSprite in monsterSpriteList {
            if (mosterSprite.physicsBody == body){
                return mosterSprite
            }
        }
        return TD_MonsterSprite()
    }
    func destroyed(monster:TD_MonsterSprite){
        
        for i in 0..<towersList.count {
            let tower = towersList[i]
            let index = tower.attackRange.index(of: monster)
            if index != nil{
                tower.attackRange.remove(at: index!)
            }
            
            let index1 = tower.attackTarget.index(of: monster)
            if index1 != nil{
                tower.attackTarget.remove(at: index1!)
            }
        }
        
    }
    func breakthrough(harm:Double){
        HP = HP - harm
        hpLab.text = String(HP)
        if HP <= 0{
            (viewController as! GameViewController).showMsgbox(_message: "Game Over")
        }
    }
}
