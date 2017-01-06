//
//  WENetwork.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/2.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation


public class Network{
    
    typealias Callback = (AnyObject?,NSError?) -> Void
    
    //GET
    class func GET(url:String,pars:Dictionary < String , String >,callback:@escaping Callback){
        
        var urlStr:String!

        if (pars.count) > 0 {
            let list  = NSMutableArray()
            for dic in pars {
                list.add("\(dic.0)=\(dic.1)")
            }
            urlStr = url + "?" + list.componentsJoined(by: "&")
        }
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:NSURL(string:urlStr) as! URL)
        request.httpMethod = "GET"
        request.timeoutInterval = 20.0
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if (error != nil) {
                print(error!.localizedDescription)
            }
//            var responseDic = NSDictionary()
//            responseDic = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
            callback(data as AnyObject?, error as? NSError)
        }
        dataTask.resume()
    }
    
    //POST
}
