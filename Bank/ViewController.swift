//
//  ViewController.swift
//  Bank
//
//  Created by Sergio Ramos on 21/08/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var dateFromButton: UILabel!
    @IBOutlet weak var usdFromButton: UILabel!
    @IBOutlet weak var eurFromButton: UILabel!
    
    var yesterdayDate = ""
    
    var currencyValueToday : JSON!
    var currencyValueYesterday : JSON!
    var currencyMean : JSON!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        informationFromCurrencyButton()
        dateToString()
        yesterdayInfo()
        todayInfo()
        meanInfo()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CurrencyViewController {
            dest.currencyMean = currencyMean
            dest.currencyValueToday = currencyValueToday
            dest.currencyValueYesterday = currencyValueYesterday
        }
    }
    
    func addBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func informationFromCurrencyButton() {
        AF.request("http://data.fixer.io/api/latest?access_key=eb10647117f5075162ee60ec9b2a3fb1&symbols=RUB,USD").responseJSON {
            responceJSON in
            switch responceJSON.result {
            case .success(let value):
                print("Success got the currency value")
                let currencyValueJSON : JSON = JSON(responceJSON.value)
                self.updateinformationFromCurrencyButton(json: currencyValueJSON)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateinformationFromCurrencyButton(json : JSON) {
        var eur = json["rates"]["RUB"].doubleValue
        var usd = json["rates"]["USD"].doubleValue
        usd = roundDown(usd, toNearest: 0.01)
        eur = roundDown(eur, toNearest: 0.01)
        var usdFromRub = eur / usd
        usdFromRub = roundDown(usdFromRub, toNearest: 0.01)
        eurFromButton.text = "EUR \(eur)"
        usdFromButton.text = "USD \(usdFromRub)"
        dateFromButton.text = "\(json["date"])"
    }
    
    func roundDown(_ value: Double, toNearest: Double) -> Double {
      return floor(value / toNearest) * toNearest
    }
    
    func yesterdayInfo() {
        AF.request("http://data.fixer.io/api/\(yesterdayDate)?access_key=eb10647117f5075162ee60ec9b2a3fb1").responseJSON {
            responceJSON in
            switch responceJSON.result {
            case .success(let value):
                print("Success got the yesterday value")
                let currencyJSON : JSON = JSON(responceJSON.value)
                self.updateYesterday(json: currencyJSON)
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
                let currencyJSON : JSON = JSON(responceJSON.value)
                self.updateToday(json: currencyJSON)
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
                let currencyJSON : JSON = JSON(responceJSON.value)
                self.updateMean(json: currencyJSON)
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
    
    func updateYesterday(json : JSON) {
        currencyValueYesterday = json
    }
    func updateToday(json : JSON) {
        currencyValueToday = json
    }
    func updateMean(json : JSON) {
        currencyMean = json
    }

}

