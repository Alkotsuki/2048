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
    
    let backColorMap = [ 2:   UIColor.red,
                         4:   UIColor.red,
                         8:   UIColor.red,
                         16:  UIColor.red,
                         32:  UIColor.red,
                         64:  UIColor.red,
                         128: UIColor.red,
                         256: UIColor.red,
                         512: UIColor.red,
                         1024:UIColor.red,
                         2048:UIColor.red ]
    


    var numberLabel: UILabel!
    
    let pulsator = Pulsator()
    
    var value = 0 {
        didSet {
            numberLabel.text = "\(value)"
            //            numberLabel.attributedText = NSMutableAttributedString(string: "\(value)", attributes: strokeTextAttributes)
            numberLabel.textColor = textColorMap[value]
            numberLabel.backgroundColor = backColorMap[value]
        }
    }
    
    //    let strokeTextAttributes = [
    //        NSAttributedStringKey.strokeColor : UIColor.red,
    //        NSAttributedStringKey.foregroundColor : UIColor.white,
    //        NSAttributedStringKey.strokeWidth : -4.0,
    //        NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 30)]
    //        as [NSAttributedStringKey : Any]
    
    //MARK: - init function
    init(position: CGPoint, width: CGFloat, value: Int) {
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        //        numberLabel.textColor = UIColor.white
        numberLabel.textColor = textColorMap[value]
        numberLabel.text = "\(value)"
        numberLabel.font = UIFont(name:"AvenirNextCondensed-Heavy", size: width * 0.7)
        numberLabel.textAlignment = .center
        numberLabel.minimumScaleFactor = 0.5
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
        pulsator.animationDuration = 0.8
        pulsator.repeatCount = 1
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
