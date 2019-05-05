//
//  TD_FightScene.swift
//  TD_ Journey
//
//  Created by mac on 2018/10/17.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_FightScene: TD_BaseScene ,SKPhysicsContactDelegate{
    
//    var maxLine = 5
    
    var actionType = 1
    var introView = TD_IntroSprite()
    var prepareView = SKSpriteNode()
    var selPrepareCardView = SKSpriteNode()
    let startSprite = SKSpriteNode(imageNamed: "startBtn")
    var selIndex = -1
    
    var prepareCardList = NSMutableArray()
    var cardList = NSArray()
    var upsetCardList = NSMutableArray()
    var playCardData = [Int:TD_CartSprite]()

    var ourHeroSprite = TD_HeroSprite()                     //我方英雄
    var enemyHeroSprite = TD_HeroSprite()                   //敌方英雄

    
    var aiCardGroup = NSMutableArray()
    var aiUpsetCardGroup = NSMutableArray()
    var aiPrepareCardList = NSMutableArray()

    
    

//    creatHomeRangeView
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.lightGray
        refreshView();
    }
    
    //创建战场UI
    func refreshView() {
        removeAllChildren()
        backgroundColor = UIColor.init(patternImage: UIImage(named: "background1_1")!)
        for i in 0..<5 {
            for j in 0..<12{
                
                
                let blockSprite = SKSpriteNode(color: UIColor(displayP3Red: 100, green: 22, blue: 22, alpha: 0.5), size: CGSize(width: TD_Block_Width - 1, height: TD_Block_Height - 1))
                blockSprite.position = CGPoint(x: TD_Scene_OrSoClearance + TD_Block_Width * CGFloat(j) + TD_Block_Width / 2.0, y: TD_Game_TopClearance + TD_Block_Height * CGFloat(i) + TD_Block_Height / 2.0 + 50)
                addChild(blockSprite)
                
                let tapBlockSprite = SKSpriteNode()
                tapBlockSprite.size = blockSprite.size
                tapBlockSprite.position = CGPoint(x: TD_Scene_OrSoClearance + TD_Block_Width * CGFloat(j) + TD_Block_Width / 2.0, y: TD_Game_TopClearance + TD_Block_Height * CGFloat(i) + TD_Block_Height / 2.0 + 50)
                tapBlockSprite.name = "blockSprite"
                tapBlockSprite.zPosition = 1000
                addChild(tapBlockSprite)
                
            }
        }
        creatHeroSprite()
        creatPrepareView()
        creatIntroView()
        
        setPhysicsBody()
        startGame()
    }
    
    //创建备战界面
    func creatPrepareView(){

        prepareView.size = CGSize(width: TD_ScreenW - 100, height: 50)
        prepareView.position = CGPoint(x: (TD_ScreenW - 100) / 2.0 + 50 - 20, y: 25)
        prepareView.color = UIColor.white
        addChild(prepareView)
        
        selPrepareCardView.color = UIColor(displayP3Red: 128, green: 22, blue: 22, alpha: 0.4)
        selPrepareCardView.size = CGSize(width: 50 / TD_Block_AspectRatio - 1, height: 50)
        selPrepareCardView.isHidden = true
        selPrepareCardView.zPosition = 100
        prepareView.addChild(selPrepareCardView)
        
        startSprite.position = CGPoint(x: TD_ScreenW - 25, y: 25)
        startSprite.size = CGSize(width: 50, height: 50)
        startSprite.name = "startBtn"
        addChild(startSprite)
    }
    func creatHeroSprite(){
        
        for i in 0..<2 {
            let heroSprite = TD_HeroSprite(color: UIColor.yellow, size: CGSize(width: TD_Block_Width, height: TD_Block_Height))
            heroSprite.type = i
//            if
            heroSprite.position = CGPoint(x: i == 0 ?TD_Scene_OrSoClearance - TD_Block_Width / 2 - 1:TD_ScreenW - (TD_Scene_OrSoClearance - TD_Block_Width / 2 + 1), y: TD_Game_TopClearance + TD_Block_Height / 2.0 + 50 + TD_Block_Height * 2)
            addChild(heroSprite)
            heroSprite.layout()
            if i == 0{
                ourHeroSprite = heroSprite
            }else{
                enemyHeroSprite = heroSprite
            }
        }
    }
    func creatIntroView(){
        introView.position = CGPoint(x: TD_ScreenW - TD_Block_Width * 2, y: TD_Block_Height + 50)
        introView.isHidden = true
        introView.layout()
        addChild(introView)
    }
    
    
    //刷新备战界面数据
    func refreshPrepareView(){
        for item in prepareView.children {
            if (item.isKind(of: TD_BaseSpriteNode.classForCoder())){
                item.removeFromParent()
            }
        }
        for i in 0..<prepareCardList.count {
            let data = prepareCardList[i] as! NSDictionary
//            let data = NSMutableDictionary(dictionary: d)
            let imgName = data.value(forKey: "CardImage") as! String
            let blockSprite = TD_BaseSpriteNode(imageNamed: imgName)
            blockSprite.tag = 100 + i
            blockSprite.name = "prepareCard"
            blockSprite.size = CGSize(width: 50 / TD_Block_AspectRatio - 1, height: 50 - 2)
            blockSprite.position = CGPoint(x: 50 / TD_Block_AspectRatio * CGFloat(i) - 0.5 * (TD_ScreenW - 100) + blockSprite.size.width * 0.5, y: 0 )
            prepareView.addChild(blockSprite)
            
            
            let remainingPrepareLab = SKLabelNode(text: String(format: "%d", (data.value(forKey: "remainingPrepare1") as! Int)))
            remainingPrepareLab.fontColor = UIColor.red
            remainingPrepareLab.fontSize = 17.0
            remainingPrepareLab.position = CGPoint(x: 10, y: 10)
            blockSprite.addChild(remainingPrepareLab)
        }
    }
    func creatCartSprite(type:Int,infoData:NSDictionary) ->TD_CartSprite{
        return creatCartSprite(type: type, coordinates: 0, infoData: infoData)
    }
    func creatCartSprite(type:Int,coordinates:Int,infoData:NSDictionary) ->TD_CartSprite{
        let arcX = coordinates % 100
        let arcY = coordinates / 100
        let position = CGPoint(x: TD_Scene_OrSoClearance + TD_Block_Width * CGFloat(arcX) + TD_Block_Width / 2.0, y: TD_Game_TopClearance + TD_Block_Height * CGFloat(arcY) + TD_Block_Height / 2.0 + 50 + 5)
        
        
        let selData = infoData
        let cartSprite = TD_CartSprite()
        cartSprite.type = type
        cartSprite.coordinates = coordinates
        cartSprite.position = position
        cartSprite.size = CGSize(width: TD_Block_Width - 2, height: TD_Block_Width - 2)
        cartSprite.name = String(format: "%d", cartSprite.coordinates)
        cartSprite.cardInfo = selData as! [String : Any]
        cartSprite.superScene = self
        addChild(cartSprite)
//        playCardList.append(cartSprite)
        playCardData[coordinates] = cartSprite
        cartSprite.layout()
        if type == 0 {
            ourHeroSprite.playCartData[coordinates] = cartSprite
        }else{
            enemyHeroSprite.playCartData[coordinates] = cartSprite
        }
        return cartSprite
    }
    
    //获取卡组
    func getCardGroup() -> NSArray{
        let data = NSMutableArray()
        let dict = NSMutableDictionary()
        dict.setValue("2001", forKey: "id")
        dict.setValue("1", forKey: "star")
        for index in 0..<10 {
            dict.setValue(String(format: "index_%d", index), forKey: "key")
            data.add(dict)
        }
        
        
        for i in 0..<data.count {
            let item = data[i] as! NSDictionary
            let cardId = item["id"] as! String
            let star = item["star"] as! String
            
            let index = Int(cardId)! / 1000
            let data1 = (TD_AnalyticalDataObject().getFileData(fileName: "Card"))["Data"] as! NSArray
            let cardRaceData = data1[index - 1] as! [String:NSDictionary]
            let cardInfo = cardRaceData[String(format: "Card_%@",cardId)]
            
            let cardInfo1 = NSMutableDictionary(dictionary: cardInfo!)
            cardInfo1.setValue(star, forKey: "star")
            
            cardInfo1.setValue(cardInfo?["Prepare"], forKey: "remainingPrepare")
            data.replaceObject(at: i, with: cardInfo1)
        }
        
        
        return data
    }
    
    
    //卡组乱序
    func getUpsetCardGroup(oldList:NSArray) -> NSArray {
        let mList = NSMutableArray(array: oldList)
        
//        for i in 0..<mList.count {
//
//        }
        
        return mList
    }
    
    //开始游戏
    func startGame(){
        cardList = getCardGroup()
        upsetCardList = NSMutableArray(array: getUpsetCardGroup(oldList: cardList))
        aiUpsetCardGroup = NSMutableArray(array: cardList)
//        for _ in 0..<3 {
//            prepareCardList.add(upsetCardList.firstObject as Any)
//            upsetCardList.removeObject(at: 0)
//            let item = aiUpsetCardGroup.firstObject as! NSMutableDictionary
//            let remainingPrepare = Int(item.value(forKey: "remainingPrepare") as! String)
//
//            item.setValue(remainingPrepare! - 1, forKey: "remainingPrepare1")
//            aiPrepareCardList.add(aiUpsetCardGroup.firstObject as Any)
//            aiUpsetCardGroup.removeObject(at: 0)
//        }
//        refreshPrepareView()
        thatCard(isFirst: true)
    }
    func thatCard(isFirst:Bool){
        for item in prepareCardList {
            let remainingPrepare = (item as AnyObject).value(forKey: "remainingPrepare1") as! Int
            if remainingPrepare == 0{
                (item as AnyObject).setValue(Int((remainingPrepare + 1) / 2), forKey: "remainingPrepare1")
            }
        }
        var number = 1
        if  isFirst {
            number = 3
        }
        
        for _ in 0..<number {
            prepareCardList.add(upsetCardList.firstObject as Any)
            upsetCardList.removeObject(at: 0)
            let item = aiUpsetCardGroup.firstObject as! NSMutableDictionary
            let remainingPrepare = Int(item.value(forKey: "remainingPrepare") as! String)
            
            item.setValue(remainingPrepare! - 1, forKey: "remainingPrepare1")
            aiPrepareCardList.add(aiUpsetCardGroup.firstObject as Any)
            aiUpsetCardGroup.removeObject(at: 0)
        }
        refreshPrepareView()
        startSprite.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)     //进行类  型转化
        let point = touch.location(in:self)
        let node = self.atPoint(point)
        introView.isHidden = true
        if (node.name != nil) {
            
            if (node.name == "prepareCard") {//选中备战的卡片
                selPrepareCardView.position = node.position
                selPrepareCardView.isHidden = false
                
                selIndex = (node as! TD_BaseSpriteNode).tag - 100
                
//                introView.cardInfo =
                let selData = prepareCardList[selIndex] as! NSDictionary
                introView.cardInfo = selData as! [String : Any]
                introView.isHidden = false
            }else if (node.name == "blockSprite"){//选中空地
                if selIndex >= 0{//已经选中备战卡片
                    selPrepareCardView.isHidden = true
                    let selData = prepareCardList[selIndex] as! NSDictionary
                    let remainingPrepare = selData.value(forKey: "remainingPrepare1") as! Int
                    if remainingPrepare > 0{//该单位没有准备完成
                        selIndex = -1
                        return;
                    }
                    
                    prepareCardList.removeObject(at: selIndex)
                    selIndex = -1
                    refreshPrepareView()
                    
                    let x = Int((node.position.x - TD_Scene_OrSoClearance - TD_Block_Width / 2.0) / TD_Block_Width + 0.5)
                    let y =  Int((node.position.y - TD_Game_TopClearance - TD_Block_Height / 2.0 - 50) / TD_Block_Height + 0.5)
                    
                    _ = creatCartSprite(type: 0, coordinates: y * 100 + x,infoData: selData)
                    
                }
            }else if(node.name == "startBtn"){
                node.isHidden = true
                takingAction()
            }
        }else{
            
        }
    }
    func takingAction() {
        aiLayout()
        
        ourHeroSprite.actionCartData = ourHeroSprite.playCartData
        enemyHeroSprite.actionCartData = enemyHeroSprite.playCartData
        
        actionType = 1
        pollingAction()
    }
    
    //ai布局 战斗开始时调用
    func aiLayout(){
//        String(format: "Card_%@",cardId)
        
        let screeningList = NSMutableArray()
        
        for i in 0..<aiPrepareCardList.count {
            let item = NSMutableDictionary(dictionary: aiPrepareCardList[i] as! NSDictionary)
            var remainingPrepare = item.value(forKey: "remainingPrepare1") as! Int
            if remainingPrepare > 0{
                remainingPrepare = remainingPrepare - 1
                item.setValue(remainingPrepare, forKey: "remainingPrepare1")
                aiPrepareCardList.replaceObject(at: i, with: item)
            }else{
                
                screeningList.add(item)
                
            }
        }
        
        /*
         Ai出怪规则
         1、当我方半场内有敌方卡片存在，优先同一行出怪（在攻击范围内优先放置在最远处）
         2、当我方英雄正在被攻击时，带有警戒属性的卡片，需放置在能攻击敌方的位置，优先前方
         3、随机出怪
         */
        
        for i in 0..<screeningList.count {
            let item = screeningList[i] as! NSDictionary
            if ourHeroSprite.enemySpriteList.count == 0 {
                randomLayout(infoData: item)
                aiPrepareCardList.remove(item)
            }else{
                for j in 0..<ourHeroSprite.enemySpriteList.count {
                    let cartSprite = ourHeroSprite.enemySpriteList[j];
                    if canResist(cartSprite: cartSprite, item: item){
                        aiPrepareCardList.remove(item)
                        continue
                    }
                    
                    if j == ourHeroSprite.enemySpriteList.count - 1{
                        randomLayout(infoData: item)
                        aiPrepareCardList.remove(item)
                        break
                    }
                }
            }
        }
    }
    
    //判断 是否能攻击到我方主场内的敌人
    func canResist(cartSprite:TD_CartSprite,item:NSDictionary) -> Bool {
        let newCartSprite = creatCartSprite(type: 1, infoData: item)
        
        var keys = [Int]()
        if newCartSprite.isScope == 1 {//警戒属性
            keys.append(cartSprite.coordinates + 100 - 1)
            keys.append(cartSprite.coordinates + 100)
            keys.append(cartSprite.coordinates + 100 + 1)
            keys.append(cartSprite.coordinates + 1)
            keys.append(cartSprite.coordinates - 100 + 1)
            keys.append(cartSprite.coordinates - 100)
            keys.append(cartSprite.coordinates - 100 - 1)
            keys.append(cartSprite.coordinates - 1)
        }else{
            for i in 0..<newCartSprite.attackScope {
                keys.append(cartSprite.coordinates + newCartSprite.attackScope - i)
                
            }
        }
        
        for key in keys {
            if key / 100 < 0 || key / 100 > 4{//上下越界
                
            }else if key % 100 < 0 || key % 100 > 11{//左右越界
                
            }else if (playCardData[key] == nil){//有空位
                let arcX = key % 100
                let arcY = key / 100
                
                _ = creatCartSprite(type: 1, coordinates: Int(arcX+arcY*100),infoData:item )
                return true
            }
        }
        
        return false
    }
    
    //随机布置单位
    func randomLayout(infoData:NSDictionary){
        let number = getRandomCoordinates(type: 1)
        let arcX = number % 100
        let arcY = number / 100
        
        _ = creatCartSprite(type: 1, coordinates: Int(arcX+arcY*100),infoData:infoData )

    }
    
    //随机空闲坐标
    func getRandomCoordinates(type:Int) -> Int {
        while true {
            var arcX = 0
            var arcY = 0
            if type == 1{//敌方
                arcX = Int(11 - arc4random()%4)
                arcY =  Int(4 - arc4random()%5)
            }else{
                arcX = Int(arc4random()%4)
                arcY = Int(arc4random()%5)
            }
            let number = arcX + arcY * 100
            if (playCardData[number] == nil){
                return number
            }
        }
    }
    
    
    
    //开始战斗
    func pollingAction(){
        
        var type = -1
        if actionType == 0{
            if enemyHeroSprite.actionCartData.count > 0{
                type = 1
                actionType = 1
            }else if ourHeroSprite.actionCartData.count > 0{
                type = 0
                actionType = 0
            }else{
                thatCard(isFirst: false)
                return
            }
            
        }else if actionType == 1{
            if ourHeroSprite.actionCartData.count > 0{
                type = 0
                actionType = 0
            }else if enemyHeroSprite.actionCartData.count > 0{
                type = 1
                actionType = 1
            }else{
                thatCard(isFirst: false)
                
                return
            }
        }

        
        var cartSprite = TD_CartSprite()
        var heroSprite = TD_HeroSprite()
        if type == 0 {
            heroSprite = ourHeroSprite
        }else{
            heroSprite = enemyHeroSprite
        }
        
        for item in heroSprite.actionCartData{
            if cartSprite.coordinates == -1{
                cartSprite = item.value
            }else if type == 0 && item.value.coordinates > cartSprite.coordinates{
                cartSprite = item.value
            }else if type == 1 && item.value.coordinates < cartSprite.coordinates{
                cartSprite = item.value
            }
        }
        if type == 0 {
            ourHeroSprite.actionCartData.removeValue(forKey: cartSprite.coordinates)
        }else{
            enemyHeroSprite.actionCartData.removeValue(forKey: cartSprite.coordinates)
        }
//        heroSprite.actionCartData.removeValue(forKey: cartSprite.coordinates)
        cartSprite.action()
    }
    //刷新战场布局数据
    func refreshData(oldKey:Int,newKey:Int) {
        if (playCardData[oldKey] != nil){
            let item = playCardData[oldKey]
            playCardData.removeValue(forKey: oldKey)
            playCardData[newKey] = item
        }
        if (ourHeroSprite.playCartData[oldKey] != nil){
            let item = ourHeroSprite.playCartData[oldKey]
            ourHeroSprite.playCartData.removeValue(forKey: oldKey)
            ourHeroSprite.playCartData[newKey] = item
        }
        if (enemyHeroSprite.playCartData[oldKey] != nil){
            let item = enemyHeroSprite.playCartData[oldKey]
            enemyHeroSprite.playCartData.removeValue(forKey: oldKey)
            enemyHeroSprite.playCartData[newKey] = item
        }
        
        
        for item in playCardData {
            let cart = item.value
            for cartSprite in cart.attackTargetEnemy{
                if cartSprite.coordinates == oldKey {
                    cartSprite.coordinates = newKey
                }
            }
            for cartSprite in cart.attackTargetOur{
                if cartSprite.coordinates == oldKey {
                    cartSprite.coordinates = newKey
                }
            }
        }
    }
    func removeSptiye(key:Int)  {
        if (playCardData[key] != nil){
            playCardData.removeValue(forKey: key)
        }
        if (ourHeroSprite.playCartData[key] != nil){
            ourHeroSprite.playCartData.removeValue(forKey: key)
        }
        if (enemyHeroSprite.playCartData[key] != nil){
            enemyHeroSprite.playCartData.removeValue(forKey: key)
        }
        
        if (enemyHeroSprite.actionCartData[key] != nil){
            enemyHeroSprite.actionCartData.removeValue(forKey: key)
        }
        if (ourHeroSprite.actionCartData[key] != nil){
            ourHeroSprite.actionCartData.removeValue(forKey: key)
        }
        
        
        for item in playCardData {
            let cart = item.value
            for cartSprite in cart.attackTargetEnemy{
                if cartSprite.coordinates == key {
                    let index = cart.attackTargetEnemy.index(of: cartSprite)
                    if index != nil{
                        cart.attackTargetEnemy.remove(at: index!)
                    }
                }
            }
            for cartSprite in cart.attackTargetOur{
                if cartSprite.coordinates == key {
                    let index = cart.attackTargetOur.index(of: cartSprite)
                    if index != nil{
                        cart.attackTargetOur.remove(at: index!)
                    }
                }
            }
        }
    }
    
    
    func thereAreUnits(coordinates:Int) -> Bool {
        if (playCardData[coordinates] != nil){
            return true
        }else{
            return false
        }
    }
    
    //判断时候需要继续前进（判断前方战场在行动力结束之前是否有落脚点）
    func performMobile(step:Int,coordinates:Int,mobile:Int) -> Bool {
        var key = coordinates
        let x = coordinates % 100
        var max = 0
        if step > 0 {
            max = min(11 - x, mobile)
        }else{
            max = min(x, mobile)
        }
        for _ in 0..<max {
            
            key = key + step
            if playCardData[key] == nil{
                return true
            }
        }
        return false
    }
    
    //设置物理属性
    func setPhysicsBody(){
        physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)//重力
        physicsWorld.contactDelegate = self
        physicsWorld.speed = 1
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)//物理世界的边界
        //        physicsBody?.contactTestBitMask = TD_ProtagonistCategory | TD_MonsterCategory  //产生碰撞的物理类型
        physicsBody?.categoryBitMask = TD_WorldCategory     //标记自身的物理类型
        //        physicsBody?.friction = 0 //阻力 为零时完全反弹
        
    }
    //开始接触碰撞
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        print("bodyA",bodyA.categoryBitMask)
        print("bodyB",bodyB.categoryBitMask)
        
//        print("bodyB.name:",bodyA.node?.name)
//        print("bodyB.name:",bodyB.node?.name)
        if bodyA.categoryBitMask == TD_OurHeroCategory { //我方英雄
            if bodyB.categoryBitMask == TD_EnemyCartAttackCategory{//敌方卡片攻击范围
                let cartSprite = getCartSprite(body: bodyB)
                cartSprite.isArrackHero = true
            }
        }
        else if bodyA.categoryBitMask == TD_EnemyHeroCategory{//敌方英雄
            if bodyB.categoryBitMask == TD_OurCartAttackCategory{//敌方卡片攻击范围
                let cartSprite = getCartSprite(body: bodyB)
                cartSprite.isArrackHero = true
            }
        }
        else if bodyA.categoryBitMask == TD_OurHeroHomeCategory{//我方主场
            if bodyB.categoryBitMask == TD_OurCartCategory{//我方方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                ourHeroSprite.ourSpriteList.append(cartSpriteB)
            }
            else if bodyB.categoryBitMask == TD_EnemyCartCategory{//敌方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                ourHeroSprite.enemySpriteList.append(cartSpriteB)
            }
        }
        else if bodyA.categoryBitMask == TD_EnemyHeroHomeCategory{//敌方主场
            if bodyB.categoryBitMask == TD_OurCartCategory{//我方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                enemyHeroSprite.ourSpriteList.append(cartSpriteB)
            }
            else if bodyB.categoryBitMask == TD_EnemyCartCategory{//敌方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                enemyHeroSprite.enemySpriteList.append(cartSpriteB)
            }
        }
        else if bodyA.categoryBitMask == TD_OurCartCategory{//我方卡片
            let cartSpriteA = bodyA.node as! TD_CartSprite

            if bodyB.categoryBitMask == TD_OurCartAttackCategory{//我方卡片
                let cartSprite = getCartSprite(body: bodyB)
                cartSprite.attackTargetOur.append(cartSpriteA)
            }else if bodyB.categoryBitMask == TD_EnemyCartAttackCategory{//敌方卡片攻击范围
                let cartSprite = getCartSprite(body: bodyB)
                cartSprite.attackTargetEnemy.append(cartSpriteA)
            }
        }
        else if bodyA.categoryBitMask == TD_EnemyCartCategory{//敌方卡片
            let cartSpriteA = bodyA.node as! TD_CartSprite

            if bodyB.categoryBitMask == TD_OurCartAttackCategory{//我方卡片攻击范围
                let cartSprite = getCartSprite(body: bodyB)
                cartSprite.attackTargetEnemy.append(cartSpriteA)
            }else if bodyB.categoryBitMask == TD_EnemyCartAttackCategory{//敌方卡片攻击范围
                let cartSprite = getCartSprite(body: bodyB)
                cartSprite.attackTargetOur.append(cartSpriteA)
            }
        }else if bodyA.categoryBitMask == TD_OurCartAttackCategory{//我方卡片攻击范围
            let cartSpriteA = getCartSprite(body: bodyA)
            if bodyB.categoryBitMask == TD_OurCartCategory{//我方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                cartSpriteA.attackTargetOur.append(cartSpriteB)
            }else if bodyB.categoryBitMask == TD_EnemyCartCategory{//敌方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                cartSpriteA.attackTargetEnemy.append(cartSpriteB)
            }

        }else if bodyA.categoryBitMask == TD_EnemyCartAttackCategory{//敌方卡片攻击范围
            let cartSpriteA = getCartSprite(body: bodyA)
            if bodyB.categoryBitMask == TD_OurCartCategory{//我方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                cartSpriteA.attackTargetEnemy.append(cartSpriteB)
            }else if bodyB.categoryBitMask == TD_EnemyCartCategory{//敌方卡片
                let cartSpriteB = bodyB.node as! TD_CartSprite
                cartSpriteA.attackTargetOur.append(cartSpriteB)
            }

        }
        

    }
    //结束碰撞
    func didEnd(_ contact: SKPhysicsContact) {
//        let bodyA = contact.bodyA
//        let bodyB = contact.bodyB

    }
    
    /// 根据攻击范围实例获取卡片对象
    ///
    /// - Parameter body: 攻击范围body
    /// - Returns: 卡片对象
    func getCartSprite(body:SKPhysicsBody) -> TD_CartSprite {
        for item in playCardData {
            if item.value.attackScopeSprite.physicsBody == body{
                return item.value
            }
        }
        return TD_CartSprite()
    }

    
    /// 攻击目标
    ///
    /// - Parameters:
    ///   - attack: 攻击力
    ///   - cardSprite: 攻击目标
    ///   - attackType: 伤害类型 1：物理伤害、1:魔法伤害
    /// - Returns: 是否击杀目标
    func target(attack:Int,cardSprite:TD_CartSprite,attackType:Int) -> Bool {
        
        if cardSprite.beingAttacked(attack: attack, attackType: attackType) {
            return true
        }
        
        return false
    }
}
