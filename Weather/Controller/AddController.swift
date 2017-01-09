//
//  AddController.swift
//  Weather
//
//  Created by himjq.com on 2017/1/4.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit


class AddController: UIViewController,UISearchBarDelegate,
UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:[String] = []
    var result:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataSource = NSArray(array:getCityData()) as! [String]
        result = dataSource
    }
    
    func getCityData() -> NSMutableArray{
        var plistArr: NSArray = NSArray()
        let resultArr:NSMutableArray = NSMutableArray()
        let filePath = Bundle.main.path(forResource: "ProvincesAndCities", ofType:"plist" )
        plistArr = NSArray(contentsOfFile: filePath!)!
        
        
        for dic in plistArr {
            for dic1 in (dic as! NSDictionary)["Cities"] as!NSArray{
                resultArr.add((dic1 as! NSDictionary)["city"] ?? "")
            }
        }
        return resultArr
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Utils.broadcast(name: W_CITY, msg: self.result[indexPath.row] as AnyObject)
        self.navigationController!.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = self.result[indexPath.row]
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.result = []
        for ctrl in self.dataSource {
            if ctrl.hasPrefix(searchText) {
                self.result.append(ctrl)
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        result = dataSource
        self.tableView.reloadData()
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
