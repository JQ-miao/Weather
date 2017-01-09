//
//  WeatherInfor.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Weather:NSObject{
    
    let name: String
    let now: NowInfor
    let dailys: Array<DailyInfor>
    
    class func fetch(city:String,completition: @escaping ((Weather) -> Void)) {
        
        Network.GET(url:w_server + w_now , pars: ["key":w_api_key,"location":city]) { (nowJson, response, error) in
            
            let name = (nowJson?["results",0,"location","name"].stringValue)!
            let temperature = (nowJson?["results",0,"now","temperature"].stringValue)! + "°"
            let desc = (nowJson?["results",0,"now","text"].stringValue)!
            let imageCode = (nowJson?["results",0,"now","code"].stringValue)! + ".png"
            let lastUpdate = (nowJson?["results",0,"last_update"].stringValue)!
            let now = NowInfor.init(temperature: temperature, desc: desc, imageCode: imageCode, lastUpdate: lastUpdate)
            
            Network.GET(url:w_server + w_daily , pars: ["key":w_api_key,"location":city]) { (dailyJson, response, error) in
                
                var dailys :Array<DailyInfor> = []
                let arr = dailyJson?["results",0,"daily"].arrayValue
                for json:JSON in arr!{
                    let imageCode:String
                    let desc:String
                    let temperatureRange :String
                    let wind:String
                    if Utils.isNight() {
                        imageCode = json["code_night"].stringValue + ".png"
                        desc = json["text_night"].stringValue
                        
                    }else{
                        imageCode = json["code_day"].stringValue + ".png"
                        desc = json["text_day"].stringValue
                    }
                    temperatureRange = json["high"].stringValue + "°/" + json["low"].stringValue + "°"
                    wind = json["wind_direction"].stringValue + "风" + json["wind_scale"].stringValue + "级"
                    let daily = DailyInfor.init(imageCode: imageCode, desc: desc, temperatureRange: temperatureRange, wind: wind)
                    dailys.append(daily)
                }
                let weather = Weather.init(name: name, now: now, dailys: dailys)
                completition(weather)
            }
        }
    }
    
    //init
    init(name: String, now: NowInfor, dailys:Array<DailyInfor>) {
        self.name = name
        self.now = now
        self.dailys = dailys
    }
}
