//
//  WeatherParse.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/5.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit
import SwiftyJSON

public class Parse: NSObject {
    
//    var city :String = ""
//    var wind :String = ""
//    var image :String = ""
//    var descriptio :String = ""
//    var lastUpdate :String = ""
//    var temperature :String = ""
//    var temperatureRange :String = ""

    class func daily(json:JSON) -> Weather {
        
        let w = Weather()
        let daily = json["results"][0]["daily"].arrayValue
        print(daily[0])
        for _ in daily {

        }
        return w
    }
}
