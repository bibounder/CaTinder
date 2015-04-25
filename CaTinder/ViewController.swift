//
//  ViewController.swift
//  testing swiping
//
//  Created by Mohamed Mahmoud HAMA on 24/04/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

import Foundation
import UIKit

class SwipeViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var draggableBackground = DraggableViewBackground(frame: self.view.frame)
        self.view.addSubview(draggableBackground)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}