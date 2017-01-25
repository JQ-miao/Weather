//
//  WENetwork.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation
import SwiftyJSON


public class Network{
    
    //Http Get
    class func GET(url:String,pars:Dictionary < String , String >,completition:@escaping (JSON?,URLResponse?,Error?) -> Void){
        
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
            
            let json = JSON(data:data!)
            if (error != nil) {
                print("GET:\(urlStr) error:\(error!.localizedDescription)")
            }else{
                completition(json, response,error)
            }
        }
        dataTask.resume()
    }
    
    //POST
    class func POST(url:String,pars:Dictionary< String , String >,completition:@escaping (JSON?,URLResponse?,Error?) -> Void) {
        
    }
}
