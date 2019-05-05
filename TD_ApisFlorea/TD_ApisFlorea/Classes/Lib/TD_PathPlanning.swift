//
//  TD_PathPlanning.swift
//  TD_AttackAndDefence
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit
import SpriteKit

class TD_PathPlanning: NSObject {
    var obstaclesRectList = [CGRect]()                  //障碍物rect数组
    var startRect = CGRect()
    var endRect = CGRect()
    
    let width = TD_Block_Width
    
    
    var formattingStartRect = CGRect()
    var formattingEndRect = CGRect()
    
    var mapStartPoint = CGPoint()
    
    var mapData = [NSArray]()
    //swift中闭包传值
    func getPathPlanning(completion: @escaping (_ result : [Any])->()) -> () {
        
        
        
        
        
        
        
        //这里有一个很重要的参数 @escaping，逃逸闭包
        //简单来说就是 闭包在这个函数结束前内被调用，就是非逃逸闭包，调用的地方超过了这函数的范围，叫逃逸闭包
        //一般网络请求都是请求后一段时间这个闭包才执行，所以都是逃逸闭包。
        // 在Swift3.0中所有的闭包都默认为非逃逸闭包，所以需要用@escaping来修饰
        DispatchQueue.global().async {
            print("耗时操作\(Thread.current)")
            if (self.mapData.count < 1){
                self.mapData = self.getMapDict(width: self.width)
            }
            
            let paths = self.getPathPlanning()
            
            //            Thread.sleep(forTimeInterval: 2)
            //            let json=["1","2"]
            
            DispatchQueue.main.async {
                //                print("主线程更新\(Thread.current)")
                
                completion(paths as! [Any])
                //函数在执行完后俩秒，主线程才回调数据，超过了函数的范围，这里就是属于逃逸闭包，如果不用@escaping，编译器是编译不过的
            }
        }
    }
    
    /// 获取地图数据
    ///
    /// - Parameter width: 前进最小单位
    /// - Returns: 地图数据
    func getMapDict(width:CGFloat) -> [NSArray] {
        let mapData = NSMutableArray()
        
        for index_x in 0..<18 {
            let lineData = NSMutableArray()
            mapData.add(lineData)
            for index_y in 0..<9 {
                lineData.add(0)
                
                
                let rc = CGRect(x: width * CGFloat(index_x) + 10, y: CGFloat(index_y) * width + TD_Game_TopClearance, width: width, height: width)
                for index in 0..<obstaclesRectList.count {
                    let rect = obstaclesRectList[index]
                    if rc.intersects(rect){
                        lineData.removeLastObject()
                        lineData.add(1)
                        break
                    }
                }
            }
        }
        return mapData as! [NSArray]
    }
    
    /// 获取路径规划
    ///
    /// - Returns: 路径数组
    func getPathPlanning() -> NSArray {
        
        
        let startI = Int((startRect.origin.x - mapStartPoint.x) / width + 0.5)
        let startJ = Int((startRect.origin.y - mapStartPoint.y) / width + 0.5)
        
        let endI = Int((endRect.origin.x - mapStartPoint.x) / width + 0.5)
        let endJ = Int((endRect.origin.y - mapStartPoint.y) / width + 0.5)
        
        formattingStartRect = CGRect(x: width * CGFloat(startI) , y: CGFloat(startJ) * width , width: width, height: width)
        formattingEndRect = CGRect(x: width * CGFloat(endI) , y: CGFloat(endJ) * width , width: width, height: width)
        
        let H = getDistance(point1: CGPoint(x: CGFloat(startI) * width, y: CGFloat(startJ) * width), point2: CGPoint(x: CGFloat(endI) * width, y: CGFloat(endJ) * width))
        let startData = NSMutableArray()
        startData.add([startI * 100 + startJ:["G":0.0,"H":H,"F":H]])
        let paths = pathPlanning(openData:startData,closedDict: NSMutableDictionary())
        
        return paths
    }
    
    
    /// 路径规划z递归执行方法
    ///
    /// - Parameters:
    ///   - openData:算法筛选到的路径数组扩散（closedDict + 周围一层）
    ///   - closedDict: 算法筛选到的路径数组 周围一圈只取F值最小并且H最小
    /// - Returns: 路径数组
    func pathPlanning(openData:NSMutableArray,closedDict:NSMutableDictionary) ->  NSArray{
        
        var minData = getDictMinValueList(key: "F", openData: openData as! [[Int : [String : Double]]],closedDict: closedDict as! [Int : Any])
        
        minData = getDictMinValueList(key: "H", openData: minData,closedDict: closedDict as! [Int : Any])
        
        var min_x = 0
        var min_y = 0
        
        let data = minData.first
        
        for item in data! {
            closedDict[item.key] = item.value
            min_x = item.key / 100
            min_y = item.key % 100
        }
        
        
        for i in 0..<4 {
            var index_i = min_x
            var index_j = min_y
            var isEffective = true
            switch i {
            case 0://上
                
                index_j = index_j + 1
                
                if mapData.count <= index_j {
                    isEffective = false
                }
                break
            case 1://下
                index_j = index_j - 1
                if index_j < 0 {
                    isEffective = false
                }
                break
            case 2://左
                index_i = index_i - 1
                if index_i < 0 {
                    isEffective = false
                }
                break
            case 3://右
                index_i = index_i + 1
                if mapData[index_j].count <= index_i {
                    isEffective = false
                }
                break
            default:
                break
            }
            let point =  CGPoint(x: width * CGFloat(index_i), y: CGFloat(index_j) * width)
            if point.x == formattingEndRect.origin.x && point.y == formattingEndRect.origin.y{//到达目的地
                closedDict[index_i * 100 + index_j] = ["G":0.0,"H":0,"F":0]
                return getOptimalPath(closedDict: closedDict)
            }else if isEffective && mapData[index_j][index_i] as! Character == "0"{
                
                
                let G = getDistance(point1: point, point2: CGPoint(x: formattingStartRect.origin.x, y: formattingStartRect.origin.y))
                let H = getDistance(point1: point, point2: CGPoint(x: formattingEndRect.origin.x, y: formattingEndRect.origin.y))
                
                let data = [index_i * 100 + index_j:["G":G,"H":H,"F":G+H]]
                if openData.contains(data) == false{
                    openData.add([index_i * 100 + index_j:["G":G,"H":H,"F":G+H]])
                }
            }
        }
        
        if closedDict.count > 200 {
            print("openData.count",openData.count)
            print("closedDict.count",closedDict.count)
        }
        
        return pathPlanning(openData:openData, closedDict:closedDict)
    }
    
    
    /// 得到最优路径
    ///
    /// - Parameter closedDict:算法筛选到的路径数组
    /// - Returns: 最优路径
    func getOptimalPath(closedDict:NSDictionary) -> NSArray {
        
        let paths = NSMutableArray()
        
        
        var X = Int(formattingEndRect.origin.x / width)
        var Y = Int(formattingEndRect.origin.y / width)
        paths.add(100 * X + Y)
        for _ in 0..<closedDict.count {
            var minF = 1000.0
            
            
            var type = 0
            
            for i in 0..<4 {
                var index_j = Y
                var index_i = X
                switch i {
                case 0://上
                    index_j = Y + 1
                    
                    break
                case 1://下
                    index_j = Y - 1
                    
                    break
                case 2://左
                    index_i = X - 1
                    
                    break
                case 3://右
                    index_i = X + 1
                    
                    break
                default:
                    break
                }
                if closedDict[index_i * 100 + index_j] != nil{
                    
                    let data = closedDict[index_i * 100 + index_j] as! [String:Double]
                    
                    if minF - data["G"]! > 0 && !paths.contains( index_i * 100 + index_j){
                        minF = data["G"]!
                        type = i
                    }
                }
            }
            var index_j = Y
            var index_i = X
            switch type {
            case 0://上
                index_j = Y + 1
                
                break
            case 1://下
                index_j = Y - 1
                
                break
            case 2://左
                index_i = X - 1
                
                break
            case 3://右
                index_i = X + 1
                
                break
            default:
                break
            }
            X = index_i
            Y = index_j
            paths.add(index_i * 100 + index_j)
            
            let point =  CGPoint(x: width * CGFloat(index_i) , y: CGFloat(index_j) * width)
            
            if point.x == formattingStartRect.origin.x && point.y == formattingStartRect.origin.y{
                return getPaths(paths: paths)
            }
        }
        return []
    }
    
    
    /// 路径转成实际父视图的坐标路径
    ///
    /// - Parameter paths: 最优路径
    /// - Returns: 最优路径数组
    func getPaths(paths:NSArray) -> NSArray {
        let rcList = NSMutableArray()
        
        //        let lastItem = paths.lastObject as! Int
        //        let startPoint = CGPoint(x: CGFloat(lastItem / 100) * width, y: CGFloat(lastItem % 100) * width)
        for index in 0..<paths.count {
            let item = paths[paths.count - 1 - index] as! Int
            let point = CGPoint(x: CGFloat(item / 100) * width, y: CGFloat(item % 100) * width)
            //            rcList.add(CGRect(x: point.x, y: point.y, width: width, height: width))
            rcList.add(point)
        }
        
        
        return rcList
    }
    
    
    /// 获取2点之间的距离
    ///
    /// - Parameters:
    ///   - point1: 点1
    ///   - point2: 点2
    /// - Returns: 距离
    func getDistance(point1:CGPoint,point2:CGPoint) -> Double {
        
        
        let distance = sqrt(pow(Double(point1.x - point2.x),2) + pow(Double(point1.y - point2.y),2))
        
        return distance
    }
    
    
    /// 在字典中找到key值最小成员列表
    ///
    /// - Parameters:
    ///   - key: key
    ///   - openData: 算法筛选到的路径数组扩散（closedDict + 周围一层）
    ///   - closedDict: 算法筛选到的路径数组
    /// - Returns: key值最小的成员数组
    func getDictMinValueList(key:String,openData:[[Int:[String:Double]]],closedDict:[Int:Any]) -> [[Int:[String:Double]]] {
        
        var minValue = 1000.0
        var minList = [[Int:[String:Double]]]()
        for i in 0..<openData.count {
            let dict = openData[i]
            
            for data in dict{
                let d = data.value
                if closedDict[data.key] == nil {
                    if  minValue - d[key]! > 0{
                        minValue = d[key]!
                    }
                }
            }
        }
        for i in 0..<openData.count {
            let dict = openData[i]
            for data in dict{
                let d = data.value
                if closedDict[data.key] == nil {
                    if  minValue == d[key]!{
                        minList.append(dict)
                    }
                }
                
            }
        }
        return minList
    }
    
    
}
