//
//  AddService.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit

public class AddService: NSObject {
    
    class func getCityData() -> NSMutableArray{
        var plistArr: NSArray = NSArray()
        let resultArr:NSMutableArray = NSMutableArray()
        let filePath = Bundle.main.path(forResource: "ProvincesAndCities", ofType:"plist" )
        plistArr = NSArray(contentsOfFile: filePath!)!
        
        for dic in plistArr {
            for dic1 in (dic as! NSDictionary)["Cities"] as!NSArray{
                resultArr.add((dic1 as! NSDictionary)["city"] ?? "")
            }
        }
        return resultArr
    }
}
