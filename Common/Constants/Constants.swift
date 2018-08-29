//
//  Constants.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import Foundation

struct ViewControllers {
    static let start  = "StartScreenViewController"
    static let gameNavigation = "GameNavigationController"
    static let game   = "GameViewController"
    static let top100 = "Top100TableViewController"
}

struct TableCells {
    static let top100CellIdentifier = "scoreCell"
}

struct Segues {
    static let newGame       = "newGameSegue"
    static let showTop100    = "showTop100"
    static let unwindToStart = "unwindToStartScreen"
}

struct Keys {
    static let record = "Record"
}

struct AlertMessages {
    static let top100 = "You made it to Top-100 worldwide!"
    static let personalBest = "New personal best"
    static let youScored = "You scored"
}
