//
//  SecondViewController.swift
//  CaTinder
//
//  Created by tom paolini on 22/04/15.
//  Copyright (c) 2015 tom paolini. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func helloWordAction(nameTextField: UITextField) {
        nameLabel.text = "Salut \(nameTextField.text)"
    }

}

