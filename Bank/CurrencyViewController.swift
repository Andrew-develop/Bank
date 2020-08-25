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
    
    let currencyData = ["EUR","USD","GBP", "JPY","CNY","BAM","AUD","NZD","JOD","CHF", "CAD","ALL","AMD","BIF","BND","BOB","BGN","KWD","MYR","XAU"]
    
    @IBOutlet weak var currencyTable: UITableView!
    @IBOutlet weak var date: UILabel!
    
    
    var currencyValueToday : JSON!
    var currencyValueYesterday : JSON!
    var currencyMean : JSON!
    
    var yesterdayDate = ""
    let constToBuy = -1.3
    let constToSell = 1.7
    var eur = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.text = "\(currencyValueToday["date"])"
        eur = currencyValueToday["rates"]["RUB"].doubleValue
    }
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regularCell") as! RegularTableViewCell
        
        cell.currencyCode.text = currencyData[indexPath.row]
        cell.currencyName.text = "\(currencyMean["symbols"]["\(currencyData[indexPath.row])"])"
        cell.countryImage.image = UIImage(named: "\(currencyData[indexPath.row])")
        var todayPrice = currencyValueToday["rates"]["\(currencyData[indexPath.row])"].doubleValue
        var yesterdayPrice = currencyValueYesterday["rates"]["\(currencyData[indexPath.row])"].doubleValue
        todayPrice = roundDown(todayPrice, toNearest: 0.01)
        yesterdayPrice = roundDown(yesterdayPrice, toNearest: 0.01)
        let valueFromRub = eur / todayPrice
        if todayPrice > yesterdayPrice {
            cell.buyIndicator.image = UIImage(named: "high")
            cell.sellIndicator.image = UIImage(named: "high")
        }
        else {
            cell.buyIndicator.image = UIImage(named: "low")
            cell.sellIndicator.image = UIImage(named: "low")
        }
        cell.priceToBuy.text = String(valueFromRub + constToBuy)
        cell.priceToSell.text = String(valueFromRub + constToSell)
        return cell
    }
    
    func roundDown(_ value: Double, toNearest: Double) -> Double {
      return floor(value / toNearest) * toNearest
    }
    
}
