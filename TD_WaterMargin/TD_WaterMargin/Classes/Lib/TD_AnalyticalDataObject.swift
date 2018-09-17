//
//  TD_AnalyticalDataObject.swift
//  TD_AttackAndDefence
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 DAA. All rights reserved.
//

import UIKit

class TD_AnalyticalDataObject: NSObject {

    func getFileData(fileName:NSString) -> NSDictionary {
        let filePath = Bundle.main.path(forResource: fileName as String, ofType: "plist")
        let dict = NSDictionary(contentsOfFile: filePath!)
        
        return dict!
    }
}
