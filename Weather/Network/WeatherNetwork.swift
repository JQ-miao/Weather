//
//  WENetwork.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/2.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation

public class WeatherNetwork{
    
    class func GET(url:String,parsDic:NSDictionary){
        
        var urlStr:String!
        var responseDic = NSDictionary()
        
        if parsDic.count > 0 {
            let list  = NSMutableArray()
            for subDic in parsDic {
                list.add("\(subDic.0)=\(subDic.1)")
            }
            urlStr = url + "?" + list.componentsJoined(by: "&")
        }
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:NSURL(string:urlStr) as! URL)
        request.httpMethod = "GET"
        request.timeoutInterval = 20.0
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            responseDic = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
            print(responseDic)
        }
        dataTask.resume()
    }
    
//    class func POST(url:String,parsDic:NSDictionary){
//
//    }
    
}
