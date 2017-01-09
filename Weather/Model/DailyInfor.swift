//
//  DailyInfor.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/8.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation

class DailyInfor {
    
    let imageCode:String
    let desc:String
    let temperatureRange :String
    let wind:String
    
    //init
    init(imageCode: String, desc: String, temperatureRange: String,wind:String) {
        self.imageCode = imageCode
        self.desc = desc
        self.temperatureRange = temperatureRange
        self.wind = wind
    }
}
