//
//  AddController.swift
//  Weather
//
//  Created by vndjqmia on 2017/1/2.
//  Copyright © 2017年 himjq.com. All rights reserved.
//

import UIKit

class AddController: UIViewController,UISearchBarDelegate,
UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:[String] = []

    var ctrlsel:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataSource = NSArray(array: AddService.getCityData()) as! [String]
        ctrlsel = dataSource
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ctrlsel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Utils.broadcast(name: W_CITY, msg: self.ctrlsel[indexPath.row] as AnyObject)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = self.ctrlsel[indexPath.row]
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.ctrlsel = []
        for ctrl in self.dataSource {
            if ctrl.hasPrefix(searchText) {
                self.ctrlsel.append(ctrl)
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     searchBar.resignFirstResponder()
     }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ctrlsel = dataSource
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
