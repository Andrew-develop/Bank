//
//  RegularTableViewCell.swift
//  Bank
//
//  Created by Sergio Ramos on 24/08/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import UIKit

class RegularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var priceToBuy: UILabel!
    @IBOutlet weak var priceToSell: UILabel!
    @IBOutlet weak var buyIndicator: UIImageView!
    @IBOutlet weak var sellIndicator: UIImageView!
    
}
