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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        informationFromCurrencyButton()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func exchangerates(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        let vc = storyboard?.instantiateViewController(identifier: "table") as! UIViewController
        self.present(vc, animated: true)
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
        var eur = json["rates"]["RUB"].double
        var usd = json["rates"]["USD"].double
        usd = roundDown(usd!, toNearest: 0.01)
        eur = roundDown(eur!, toNearest: 0.01)
        var usdFromRub = eur! / usd!
        usdFromRub = roundDown(usdFromRub, toNearest: 0.01)
        eurFromButton.text = "EUR \(eur!)"
        usdFromButton.text = "USD \(usdFromRub)"
        dateFromButton.text = "\(json["date"])"
    }
    
    func roundDown(_ value: Double, toNearest: Double) -> Double {
      return floor(value / toNearest) * toNearest
    }

}

