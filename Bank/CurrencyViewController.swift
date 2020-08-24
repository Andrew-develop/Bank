//
//  CurrencyViewController.swift
//  Bank
//
//  Created by Sergio Ramos on 24/08/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CurrencyViewController: UIViewController {
    
    let currencyData = ["EUR","USD","JEP","GBP","IMP","CNY","BAM","AUD","NZD","JOD","CHF","BGN","KWD","MYR","XAU"]
    
    @IBOutlet weak var currencyTable: UITableView!
    @IBOutlet weak var date: UILabel!
    
    
    var currencyValueToday : JSON!
    var currencyValueYesterday : JSON!
    var currencyMean : JSON!
    
    var yesterdayDate = ""
    let constToBuy = -1.3
    let constToSell = 1.7

    override func viewDidLoad() {
        super.viewDidLoad()

        //dateToString()
        //yesterdayInfo()
        todayInfo()
        //meanInfo()
        date.text = currencyValueToday["date"].string
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

}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell") as! RegularTableViewCell
        
        let currencyValue = currencyData[indexPath.row]
        
        cell.currencyCode.text = currencyValue
        cell.currencyName.text = currencyMean["symbols"]["\(currencyValue)"].string
        cell.countryImage.image = UIImage(named: "USD")
        //var todayPrice = currencyValueToday["rates"]["\(currencyValue)"].double
        //var yesterdayPrice = currencyValueYesterday["rates"]["\(currencyValue)"].double
        //todayPrice = roundDown(todayPrice!, toNearest: 0.01)
        //yesterdayPrice = roundDown(yesterdayPrice!, toNearest: 0.01)
        // проблема с unwrap
        cell.buyIndicator.image = UIImage(named: "high")
        cell.sellIndicator.image = UIImage(named: "low")
        //cell.priceToBuy.text = String(todayPrice! + constToBuy)
        //cell.priceToSell.text = String(todayPrice! + constToSell)
        return cell
    }
    
    func roundDown(_ value: Double, toNearest: Double) -> Double {
      return floor(value / toNearest) * toNearest
    }
    
}
