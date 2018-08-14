//
//  TileView.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    let textColorMap = [ 2:   UIColor.black,
                         4:   UIColor.black,
                         8:   UIColor.black,
                         16:  UIColor.black,
                         32:  UIColor.black,
                         64:  UIColor.black,
                         128: UIColor.black,
                         256: UIColor.black,
                         512: UIColor.black,
                         1024:UIColor.black,
                         2048:UIColor.black ]
    
    let backColorMap = [ 2:   UIColor.white,
                         4:   UIColor.white,
                         8:   UIColor.white,
                         16:  UIColor.white,
                         32:  UIColor.white,
                         64:  UIColor.white,
                         128: UIColor.white,
                         256: UIColor.white,
                         512: UIColor.white,
                         1024:UIColor.white,
                         2048:UIColor.white ]
    
    var numberLabel: UILabel!
    
    var value = 0 {
        didSet {
            numberLabel.text = "\(value)"
            numberLabel.textColor = textColorMap[value]
            numberLabel.backgroundColor = backColorMap[value]
        }
    }
    
    //MARK: - init function
    init(position: CGPoint, width: CGFloat, value: Int) {
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        //        numberLabel.textColor = UIColor.white
        numberLabel.textColor = textColorMap[value]
        numberLabel.text = "\(value)"
        numberLabel.font = UIFont(name:"Arial-BoldMT", size: 40)
        numberLabel.textAlignment = .center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.adjustsFontSizeToFitWidth = true
        super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
        addSubview(numberLabel)
        layer.cornerRadius = 6
        self.value = value
        backgroundColor = backColorMap[value]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
