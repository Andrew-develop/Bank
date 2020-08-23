//
//  TableTableViewController.swift
//  Bank
//
//  Created by Sergio Ramos on 22/08/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    let currencyData = ["EUR","USD","JEP","GBP","IMP","CNY","BAM","AUD","NZD","JOD","CHF","BGN","KWD","MYR","XAU"]
    
    var currencyValueToday : JSON = []
    var currencyValueYesterday : JSON = []
    var currencyMean : JSON = []
    
    var yesterdayDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateToString()
        
        //todayInfo()
        //yesterdayInfo()
        //meanInfo()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return currencyData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell", for: indexPath)
            return cell
        }
    }
    
    func yesterdayInfo() {
        AF.request("http://data.fixer.io/api/\(yesterdayDate)?access_key=eb10647117f5075162ee60ec9b2a3fb1").responseJSON {
            responceJSON in
            switch responceJSON.result {
            case .success(let value):
                print("Success got the yesterday value")
                self.currencyValueYesterday = JSON(responceJSON.value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func todayInfo() {
        AF.request("http://data.fixer.io/api/latest?access_key=eb10647117f5075162ee60ec9b2a3fb1").responseJSON {
            responceJSON in
            switch responceJSON.result {
            case .success(let value):
                print("Success got the today value")
                self.currencyValueToday = JSON(responceJSON.value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func meanInfo() {
        AF.request("http://data.fixer.io/api/symbols?access_key=eb10647117f5075162ee60ec9b2a3fb1").responseJSON {
            responceJSON in
            switch responceJSON.result {
            case .success(let value):
                print("Success got the mean value")
                self.currencyMean = JSON(responceJSON.value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func dateToString() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        yesterdayDate = dateFormatter.string(from: yesterday!)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
