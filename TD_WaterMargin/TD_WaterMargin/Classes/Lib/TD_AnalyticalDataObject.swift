//
//  TD_AnalyticalDataObject.swift
//  TD_AttackAndDefence
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit

class TD_AnalyticalDataObject: NSObject {
    
    var dFilePath =  NSHomeDirectory() + "/Library/Caches/"

    func getFileData(fileName:String) -> NSDictionary {
        var dict = NSDictionary()
        
        let ud =  UserDefaults()
        let fileCache = ud.value(forKey: "fileCache")
        var fileData = NSMutableDictionary()
        if fileCache != nil{
            fileData = NSMutableDictionary(dictionary: fileCache as! NSDictionary )
        }
        
        let path = dFilePath + fileName
        if fileData.value(forKey: fileName) != nil{
            dict = NSDictionary.init(contentsOfFile: path)!
        }else{
            let filePath = Bundle.main.path(forResource: fileName, ofType: "plist")
            dict = NSDictionary(contentsOfFile: filePath!)!
            NSDictionary(dictionary: dict).write(toFile: path, atomically: true)
            fileData.setValue("1", forKey: fileName)
            ud.set(fileData, forKey: "fileCache")
        }
        
        
        
        
        return dict
    }
    func saveFileData(fileName:String,data:NSDictionary) {
        let path = dFilePath + fileName
        NSDictionary(dictionary: data).write(toFile: path, atomically: true)
    }
}
