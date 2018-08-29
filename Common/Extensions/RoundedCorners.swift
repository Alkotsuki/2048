//
//  UIButton Extensions.swift
//  2048
//
//  Created by Pavel Koval on 8/16/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
        
    }
}


