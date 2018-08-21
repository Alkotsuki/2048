//
//  RandomNumber.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import Foundation

//extension Int {
//    func randomFromOne(to max: Int) -> Int {
//        return Int(arc4random_uniform(UInt32(max)) + 1)
//    }
//    
//    func random2Or4() -> Int {
//        let randomValue = Int(arc4random() % 10)
//        if randomValue == 1 {
//            return 4
//        } else {
//            return 2
//        }
//    }
//}

protocol RandomsFor2048 {
    func randomFromZero(to max: Int) -> Int
    func randomFromOne(to max: Int) -> Int
    func random2Or4() -> Int
}

extension RandomsFor2048 {
    
    func randomFromZero(to max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    func randomFromOne(to max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)) + 1)
    }
    
    func random2Or4() -> Int {
        let randomValue = Int(arc4random() % 10)
        if randomValue == 1 {
            return 4
        } else {
            return 2
        }
    }    
    
}
