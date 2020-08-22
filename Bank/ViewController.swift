//
//  ViewController.swift
//  Bank
//
//  Created by Sergio Ramos on 21/08/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func exchangerates(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        let vc = storyboard?.instantiateViewController(identifier: "table") as! UITableViewController
        self.present(vc, animated: true)
    }
    
    func addBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

}

