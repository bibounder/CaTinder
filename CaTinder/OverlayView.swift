//
//  OverlayView.swift
//  testing swiping
//
//  Created by Mohamed Mahmoud HAMA on 24/04/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

import Foundation
import UIKit

enum GGOverlayViewMode : Int {
    case GGOverlayViewModeLeft
    case GGOverlayViewModeRight
}

class OverlayView : UIView {
    var mode : GGOverlayViewMode
    var imageView : UIImageView
    
    
    override init(frame: CGRect) {
        mode = GGOverlayViewMode.GGOverlayViewModeRight // tmp init
        imageView = UIImageView()
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        imageView = UIImageView(image: UIImage(named: "noButton"))
        self.addSubview(imageView)
    }
    
    required init(coder aDecoder: (NSCoder!)) {
        mode = GGOverlayViewMode.GGOverlayViewModeRight // tmp init
        imageView = UIImageView()
        super.init(coder: aDecoder) //ajout de coder: aDecoder
    }
    
    func setMode(mode: GGOverlayViewMode){
        //      if (_ mode == mode) {
        //            return
        //        }
        //
        //        _mode = mode;
        
        if(mode == GGOverlayViewMode.GGOverlayViewModeLeft) {
            imageView.image = UIImage(named: "noButton")
        } else {
            imageView.image = UIImage(named: "yesButton")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectMake(50, 50, 100, 100)
        imageView.backgroundColor = UIColor(red:72/255, green:145/255,blue:206/255,alpha:1)
    }
}