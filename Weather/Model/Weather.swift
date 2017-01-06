//
//  WeatherInfor.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit

public class Weather: NSObject {
    
    var name :String = "大连"
    var lastUpdate :String = "2016-01-05 20：00"
    
    //now
    var temperature :String = "-2°"
    var text :String = "2"
    var code :String = "2"
    
    //daily
    var code_day :String = "30"
    var high :String = "5"
    var wind_direction_degree :String = "0"
    var text_night :String = "晴"
    var date :String = "2017-01-08"
    var low :String = "-3"
    var wind_direction :String = "北"
    var code_night :String = "0"
    var wind_scale :String = "2"
    var wind_speed :String = "10"
    var precip :String = ""
    var text_day :String = "雾"
}
