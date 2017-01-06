//
//  MainController.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/1.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit
import SwiftyJSON


class MainController: UITableViewController {

    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(MainController.addClick))
        
        self.tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "w_cell")
        
        
        Utils.observe(name: W_CITY, observer: self, selector: #selector(receiveCityName(notifaction:)))
        
        for _ in 1...5 {
            let w = Weather()
            dataSource.add(w)
        }
    }
    
    func receiveCityName(notifaction: NSNotification) {
        var cityName = (notifaction.userInfo as? [String : AnyObject])?["msg"]
        cityName = Utils.transformHanziToPinyin(hanzi: cityName as! String, deleteSpace: true) as AnyObject?
        Network.GET(url:w_server + w_daily , pars: ["key":w_api_key,"location":cityName as Any as! String],callback: {data,error in
            if (data != nil) {
                _ = Parse.daily(json: JSON(data: data as! Data))
            }
        })
    }

    func addClick() {
        let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "addController") as! AddController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "最关注" : "已关注"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ?  1 : dataSource.count - 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "w_cell", for: indexPath) as! WeatherCell
        let w = dataSource[indexPath.row] as!Weather
        cell.w_city.text = w.name
        cell.w_wind.text = w.wind_scale
        cell.w_temperature.text = w.temperature + "°"
        cell.w_description.text = w.text_day
        cell.w_temperature_range.text = w.high + "°/" + w.low + "°"
        cell.w_image.image = UIImage(named:w.code + ".png")
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return indexPath.row == 0&&indexPath.section==0 ?  false : true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.insertRows(at: [indexPath], with: .bottom)
        }    
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        if destinationIndexPath.row == 0 && destinationIndexPath.section == 0{
//            var indexpath = destinationIndexPath

//         tableView.deleteRows(at: [destinationIndexPath], with: .fade)
//        }
        //dataSource.exchangeObject(at: destinationIndexPath.row, withObjectAt: sourceIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        var indexPath = IndexPath()
        indexPath.section = proposedDestinationIndexPath.section
        indexPath.row = proposedDestinationIndexPath.row - 1
        return indexPath
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114.0
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
