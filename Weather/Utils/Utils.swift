//
//  Utils.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import Foundation
import UIKit


public class Utils{
    //汉字转拼音
    class func transformHanziToPinyin(hanzi:String,deleteSpace:Bool) ->String{
        let str = (hanzi as NSString).mutableCopy() as! CFMutableString
        CFStringTransform(str,nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        var result = str as String
        if deleteSpace {
            result = result.replacingOccurrences(of: " ", with: "")
        }
        return result ;
    }
    //发送广播
    class func broadcast(name:String,msg:AnyObject){
        let broadcast = NSNotification.Name(rawValue: name)
        NotificationCenter.default.post(name:broadcast, object: nil, userInfo:["msg" : msg])
    }
    //监听广播
    class func observe(name:String,observer:AnyObject,selector:Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    class func isNight() ->Bool{
        let d = Date()
        let f = DateFormatter()
        f.dateFormat = "HH"
        let hour = Int(f.string(from: d))!
        return (hour > 6 && hour < 18) ? false : true
    }
    
    //alert
//    class func alert(msg:String ) {
//        let alertController = UIAlertController(title: "天气",
//                                                message: msg, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        UIApplication.shared.windows[0].rootViewController?.present(alertController, animated: true, completion: nil)
//    }
    
}
