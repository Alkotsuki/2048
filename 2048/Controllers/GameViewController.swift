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
    var gameboard = Gameboard(dimension: 4)
    
    var cells: [UIView] {
        return [cell0, cell1, cell2, cell3,
                cell4, cell5, cell6, cell7,
                cell8, cell9, cell10, cell11,
                cell12, cell13, cell14, cell15]
    }
    
    var score: Int = 0  {
        didSet {
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    
//    var flagForCheck = [Int](repeating: 0, count: 16)
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
    
    func insertTile(at index:Int, with value:Int, animation type: TileAnimationType ) {
        
        let newPosition = findPosition(for: index)
        let tile = TileView(position: newPosition, width: 50, value: value)
        
        gameboard.tiles[index] = value
        tileView[index] = tile
        tileValue[index] = value
        
        gameboardView.addSubview(tile)
        gameboardView.bringSubview(toFront: tile)
        
        animateTile(tile, with: type)
        
//        if gameboard.isFull() && gameboard.isLost() {
//            print("Game Over")
//        }

    }
    
    func findPosition(for index: Int) -> CGPoint {
        let cell = cells[index]
        return cell.superview!.convert(cell.frame.origin,
                                       to: gameboardView)
    }
    
    

    //MARK: REFRESH UI
    func refreshUI() {
        
        //        var index: Int
        //        var tile: TileView
        //        var counter = 0
        
        let upperBound = gameboard.dimension * gameboard.dimension
        var counter = 0
        
        
        for index in 0..<upperBound {
            
            if gameboard.tiles[index] != 0 && tileValue[index] == 0 {
                let value = gameboard.tiles[index]
                insertTile(at: index, with: value, animation: .none)
                counter = 1
            }
            
            if gameboard.tiles[index] == 0 && tileValue[index] != 0 {
                //                let tile = tileView[index]!
                //                tile.removeFromSuperview()
                
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
    
    @IBAction func addTilesButtonPressed(_ sender: UIButton) {
        generateTile()
        generateTile()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        newGame()
    }
    
    func gameOverAlert() {
        let alertController = UIAlertController(title: "Game over", message: "Your score: \(score)", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
            UIView.animate(withDuration: 0.18, delay: 0.05, options: .transitionCurlUp, animations: {
                tile.layer.setAffineTransform(CGAffineTransform(scaleX: self.tilePopMaxScale, y: self.tilePopMaxScale))
                
            }) { (finished) in
                UIView.animate(withDuration: 0.08, animations: {
                    tile.layer.setAffineTransform(CGAffineTransform.identity)
                })
            }
            
        case .merge:
            tile.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
            UIView.animate(withDuration: 0.05, delay: 0.01, options: .curveEaseIn, animations: {
                tile.layer.setAffineTransform(CGAffineTransform(scaleX: 2.3, y: 2.3))
            }) { (finished) in
                tile.layer.setAffineTransform(CGAffineTransform.identity)
            }
            
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTile()
        generateTile()
        

        //        let origin = cell0.superview!.convert(cell0.frame.origin, to: gameboardView) COORDS CONVERT
        
        //        let someView = UIView(frame: CGRect(x: origin.x, y: origin.y, width: 50, height: 50))
        //        someView.backgroundColor = .yellow
        //        gameboardView.addSubview(someView)
        //        gameboardView.bringSubview(toFront: someView)
        //        UIView.animate(withDuration: 4) {
        //            someView.frame = CGRect(x: origin.x+30, y: origin.y, width: 50, height: 50)
        //        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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


