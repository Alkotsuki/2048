//
//  GameViewController.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, RandomsFor2048 {
    
    //MARK: VARIABLES
    let defaults = UserDefaults.standard
    
    var gameboard = Gameboard(dimension: 4)
    
    var cells: [UIView] {
        return [cell0, cell1, cell2, cell3,
                cell4, cell5, cell6, cell7,
                cell8, cell9, cell10, cell11,
                cell12, cell13, cell14, cell15]
    }
    
    var score: Int = 0  {
        didSet {
            scoreLabel.text = "SCORE: \n\(score)"
        }
    }
    
    var record: Int {
        get {
            return defaults.integer(forKey: Keys.record)
        }
        set {
            defaults.set(record, forKey: "Record")
            bestRecordLabel.text = "\(record)"
        }
    }
    
    var scores: [Score] = []
    
    var tileView = [Int:TileView]()
    var tileValue = [Int](repeating: 0, count: 16)
    
    //MARK: NEW GAME
    func newGame() {
        
        for (_, tile) in tileView {
            tile.removeFromSuperview()
        }
        tileView.removeAll()
        tileValue = [Int](repeating: 0, count: 16)
        gameboard.tiles = [Int](repeating: 0, count: 16)
        gameboard.mergeIndex = [Int](repeating: 0, count: 16)
        score = 0
        generateTile()
        generateTile()
        
    }
    
    //MARK: GENERATE NEW TILE
    func generateTile() {
        
        if gameboard.isFull() {
            print("No more free space on gameboard")
            return
        } else {
            let value = random2Or4()
            let index = gameboard.findEmptyCell()
            insertTile(at: index, with: value,  animation: .new)
            if gameboard.isFull() && gameboard.isLost() {
                gameOverAlert()
                print("Game Over")
            }
            
        }
        
        
    }
    
    //MARK: INSERT TILE
    func insertTile(at index:Int, with value:Int, animation type: TileAnimationType ) {
        
        let cell = cells[index]
        let width = cell.frame.width
        let tileCoords = cell.superview!.convert(cell.frame.origin, to: gameboardView)
        let tile = TileView(position: tileCoords, width: width, value: value)
        gameboard.tiles[index] = value
        tileView[index] = tile
        tileValue[index] = value
        
        gameboardView.addSubview(tile)
        gameboardView.bringSubview(toFront: tile)
        
        animateTile(tile, with: type)
        
    }
    
    //MARK: REFRESH UI
    func refreshUI() {
        
        let upperBound = gameboard.dimension * gameboard.dimension
        var counter = 0
        
        
        for index in 0..<upperBound {
            
            if gameboard.tiles[index] != 0 && tileValue[index] == 0 {
                let value = gameboard.tiles[index]
                insertTile(at: index, with: value, animation: .none)
                counter = 1
            }
            
            if gameboard.tiles[index] == 0 && tileValue[index] != 0 {
                tileView[index]!.removeFromSuperview()
                tileView.removeValue(forKey: index)
                tileValue[index] = 0
                counter = 1
            }
            
            if gameboard.tiles[index] > 0 && tileValue[index] > 0 &&
                gameboard.tiles[index] != tileValue[index] {
                let tile = tileView[index]!
                tile.value = gameboard.tiles[index]
                tileValue[index] = gameboard.tiles[index]
                if gameboard.mergeIndex[index] == 1 {
                    animateTile(tile, with: .merge)
                    gameboard.mergeIndex[index] = 0
                    score += gameboard.tiles[index]
                }
            }
            
        }
        
        if counter == 1 {
            generateTile()
        }
        
    }
    
    
    //MARK: SWIPE GESTURE
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        gameboard.shiftTiles(direction)
        refreshUI()
        print("swiped \(direction)")
    }
    
    
    //MARK: OUTLETS
    
    @IBOutlet weak var gameboardView: UIView!
    
    @IBOutlet weak var cell0:  UIView!
    @IBOutlet weak var cell1:  UIView!
    @IBOutlet weak var cell2:  UIView!
    @IBOutlet weak var cell3:  UIView!
    @IBOutlet weak var cell4:  UIView!
    @IBOutlet weak var cell5:  UIView!
    @IBOutlet weak var cell6:  UIView!
    @IBOutlet weak var cell7:  UIView!
    @IBOutlet weak var cell8:  UIView!
    @IBOutlet weak var cell9:  UIView!
    @IBOutlet weak var cell10: UIView!
    @IBOutlet weak var cell11: UIView!
    @IBOutlet weak var cell12: UIView!
    @IBOutlet weak var cell13: UIView!
    @IBOutlet weak var cell14: UIView!
    @IBOutlet weak var cell15: UIView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestRecordLabel: UILabel!
    
    @IBAction func addTilesButtonPressed(_ sender: UIButton) {
        generateTile()
        generateTile()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        newGame()
    }
    
    //MARK: ANIMATIONS
    let tilePopMaxScale: CGFloat = 1.1
    
    enum TileAnimationType {
        case none
        case new
        case merge
    }
    
    func animateTile(_ tile: TileView, with type: TileAnimationType) {
        switch type {
            
        case .none:
            return
            
        case .new:
            tile.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
            tile.alpha = 0
//            UIView.animate(withDuration: 0.18, delay: 0.2, options: .transitionCurlUp, animations: {
//                tile.layer.setAffineTransform(CGAffineTransform(scaleX: self.tilePopMaxScale, y: self.tilePopMaxScale))
//
//            }) { (finished) in
//                UIView.animate(withDuration: 0.08, animations: {
//                    tile.layer.setAffineTransform(CGAffineTransform.identity)
//
//                })
//            }
            UIView.animate(withDuration: 0.2, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
                tile.alpha = 1
                tile.transform = CGAffineTransform.identity
            }, completion: nil)
            
            //        case .merge:
            //            tile.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
            //            UIView.animate(withDuration: 0.05, delay: 0.01, options: .autoreverse , animations: {
            //                tile.layer.setAffineTransform(CGAffineTransform(scaleX: 1.3, y: 1.3))
            //            }) { (finished) in
            //                tile.layer.setAffineTransform(CGAffineTransform.identity)
            //            }
            
        case .merge:
//            let width = tile.frame.width
//            let pulsator = Pulsator()
//            tile.layer.addSublayer(pulsator)
//            pulsator.frame = CGRect(x: width/2, y: width/2, width: 0, height: 0)
//            pulsator.repeatCount = 1
//            pulsator.start()
            tile.pulsator.start()
            
            UIView.animate(withDuration: 0.1, delay: 0.03, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                
                let scaleTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                tile.transform = scaleTransform
                
            }) { (_) in
                tile.transform = CGAffineTransform.identity
            }
            
            
        }
    }
    
    //MARK: GAME OVER
    func gameOverAlert() {
        
        var message: String
        if score > record {
            message = "New record: \(score)"
            record = score
        } else {
            message = "You scored: \(score)"
        }
        
        
        let alertController = UIAlertController(title: "Game over",
                                                message: message,
                                                preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showTop100 {
            let top100VC = segue.destination as! Top100TableViewController
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(score)"
        bestRecordLabel.text = "\(record)"
        generateTile()
        generateTile()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.view.layoutIfNeeded()
        //perform gameboard animation
        //        UIView.animate(withDuration: 2) {
        //            self.gameboardView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        //        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


