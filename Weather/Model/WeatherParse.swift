//
//  WeatherParse.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/2.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation

class WeatherParse{
    
    var dataArr :NSMutableArray = []
    
    func parse(pars:NSDictionary) -> WeatherParse {
        let parse = WeatherParse()
        for dic in pars {
            parse.dataArr.add(dic)
        }
        return parse
    }

}

