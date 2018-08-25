//
//  TileView.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    let textColorMap = [ 2:   UIColor.white,
                         4:   UIColor.white,
                         8:   UIColor.white,
                         16:  UIColor.white,
                         32:  UIColor.white,
                         64:  UIColor.white,
                         128: UIColor.white,
                         256: UIColor.white,
                         512: UIColor.white,
                         1024:UIColor.white,
                         2048:UIColor.black ]
    
    let backColorMap = [ 2:   UIColor.black,
                         4:   UIColor.darkGray,
                         8:   UIColor(red: 0.48, green: 0.60, blue: 0.48, alpha: 1),
                         16:  UIColor(red: 0.55, green: 0.82, blue: 0.60, alpha: 1),
                         32:  UIColor(red: 0.79, green: 0.82, blue: 0.54, alpha: 1),
                         64:  UIColor(red: 0.97, green: 0.66, blue: 0.19, alpha: 1),
                         128: UIColor(red: 0.91, green: 0.24, blue: 0.05, alpha: 1),
                         256: UIColor(red: 0.91, green: 0.05, blue: 0.62, alpha: 1),
                         512: UIColor(red: 0.33, green: 0.05, blue: 0.91, alpha: 1),
                         1024:UIColor(red: 0.44, green: 0.63, blue: 1.00, alpha: 1),
                         2048:UIColor.white ]
    


    var numberLabel: UILabel!
    
    let pulsator = Pulsator()
    
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
        numberLabel.textColor = textColorMap[value]
        numberLabel.text = "\(value)"
//        numberLabel.font = UIFont(name:"AvenirNextCondensed-Heavy", size: width * 0.7)
//        numberLabel.font = UIFont(name: "GothamPro-Black", size: width * 0.6)
        numberLabel.font = UIFont.systemFont(ofSize: width * 0.6, weight: .black)
        numberLabel.textAlignment = .center
        numberLabel.minimumScaleFactor = 0.4
        numberLabel.adjustsFontSizeToFitWidth = true
        super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
        addSubview(numberLabel)
        layer.cornerRadius = 6
        clipsToBounds = true
        self.value = value
        backgroundColor = backColorMap[value]
        
        layer.addSublayer(pulsator)
        pulsator.frame = CGRect(x: width/2, y: width/2, width: 0, height: 0)
        pulsator.radius = width
        pulsator.backgroundColor = UIColor.white.cgColor
        pulsator.animationDuration = 0.8
        pulsator.repeatCount = 1
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
