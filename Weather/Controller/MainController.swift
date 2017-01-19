//
//  MainController.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainController: UITableViewController {
    
    var dataSource:[Weather] = []
    var focusedCitys:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(MainController.addNewCity))
        
        //注册cell
        self.tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "w_cell")
        //监听选择城市
        Utils.observe(name: W_CITY, observer: self, selector: #selector(receiveCityName(notifaction:)))
        
        //加载已关注
        self.loadFocusedCitys()
    }
    
    func loadFocusedCitys(){
        if (UserDefaults.standard.object(forKey: "Focused") != nil) {
            focusedCitys = UserDefaults.standard.object(forKey: "Focused") as!Array
            
            for (_,c) in focusedCitys.enumerated() {
                Weather.fetch(city: c , completition: { (w) in
                    self.dataSource.append(w)
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    func receiveCityName(notifaction: NSNotification) {
        let city = (notifaction.userInfo as? [String : AnyObject])?["msg"] as! String
        let cityName = Utils.transformHanziToPinyin(hanzi: city, deleteSpace: true)
        Weather.fetch(city: cityName) { (w) in
            
            self.dataSource.append(w)
            self.tableView.reloadData()
            self.focusedCitys.append(cityName)
            UserDefaults.standard.set(self.focusedCitys, forKey: "Focused")
        }
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func addNewCity() {
        let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "addController") as! AddController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "w_cell", for: indexPath) as! WeatherCell
        let w = dataSource[indexPath.row]
        cell.w_city.text = w.name
        cell.w_wind.text = w.dailys[0].wind
        cell.w_temperature.text = w.now.temperature
        cell.w_description.text = w.now.desc
        cell.w_temperature_range.text = w.dailys[0].temperatureRange
        cell.w_image.image = UIImage(named:w.now.imageCode)
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
            
            self.focusedCitys = UserDefaults.standard.object(forKey: "Focused") as!Array
            self.focusedCitys.remove(at: indexPath.row)
            UserDefaults.standard.set(self.focusedCitys, forKey: "Focused")
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
