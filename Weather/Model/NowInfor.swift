//
//  NowInfor.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/8.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation

class NowInfor {

    let temperature :String
    let desc :String
    let imageCode :String
    let lastUpdate :String
    
    //init
    init(temperature: String, desc: String, imageCode: String,lastUpdate:String) {
        self.temperature = temperature
        self.desc = desc
        self.imageCode = imageCode
        self.lastUpdate = lastUpdate
    }
}
