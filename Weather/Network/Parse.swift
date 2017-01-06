//
//  WeatherParse.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit
import SwiftyJSON

public class Parse: NSObject {

    class func daily(json:JSON) -> Weather {
        
        let w = Weather()
        let daily = json["results"][0]["daily"].arrayValue
        print(daily[0])
        for _ in daily {
            //...
        }
        return w
    }
}
