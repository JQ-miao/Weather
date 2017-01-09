//
//  TodayViewController.swift
//  Today Extension
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2016年 himjq.com. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    //现在
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var temperatureRange: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var city: UILabel!
    
    //今天
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aRange: UILabel!
    //明天
    @IBOutlet weak var bImage: UIImageView!
    @IBOutlet weak var bRange: UILabel!
    //后天
    @IBOutlet weak var cImage: UIImageView!
    @IBOutlet weak var cRange: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        Weather.fetch(city: "dalian") { (w) in
            self.show(w: w)
        }
    }
    
    func show(w:Weather) {
        
        self.image.image = UIImage(named: w.now.imageCode)
        self.desc.text = w.now.desc
        self.city.text = w.name
        self.wind.text = w.dailys[0].wind
        self.temperature.text = w.now.temperature
        self.temperatureRange.text = w.dailys[0].temperatureRange
        
        self.aImage.image = UIImage(named: w.dailys[0].imageCode)
        self.aRange.text = w.dailys[0].temperatureRange
        
        self.bImage.image = UIImage(named: w.dailys[1].imageCode)
        self.bRange.text = w.dailys[1].temperatureRange
        
        self.cImage.image = UIImage(named: w.dailys[2].imageCode)
        self.cRange.text = w.dailys[2].temperatureRange
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize
        }
        else {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 200)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let url = URL(string: "miao:")
        self.extensionContext?.open(url!, completionHandler: nil)
    }
    
}
