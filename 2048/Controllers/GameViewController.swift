//
//  GameViewController.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, RandomsFor2048 {
    
    
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
    
    var flagForCheck = [Int](repeating: 0, count: 16)
    var tileView = [Int:TileView]()
    var tileValue = [Int](repeating: 0, count: 16)
    
    //MARK: Generate new tile
    func generateTile() {
        
        let value = random2Or4()
        
        if gameboard.isFull() {
            print("No more free space on gameboard")
            return
        } else {
            let index = gameboard.findEmptyCell()
            insertTile(at: index, with: value)
        }
        
    }
    
    func insertTile(at index:Int, with value:Int) {
        
        let newPosition = findPosition(for: index)
        let tile = TileView(position: newPosition, width: 50, value: value)
        
        gameboard.tiles[index] = value
        tileView[index] = tile
        tileValue[index] = value
        
        gameboardView.addSubview(tile)
        gameboardView.bringSubview(toFront: tile)
        
        //        animateTile
        
//        if gameboard.isFull() && gameboard.isLost() {
//            print("Game Over")
//        }
    }
    
    func findPosition(for index: Int) -> CGPoint {
        let cell = cells[index]
        return cell.superview!.convert(cell.frame.origin,
                                       to: gameboardView)
    }
    
    
    //MARK: Swipe gesture
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        gameboard.shiftTiles(direction)
        print("swiped \(direction)")
    }
    
    //MARK: Outlets
    @IBOutlet var globalView: UIView!
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
    
    //MARK: Animations
    enum TileAnimation {
        case none
        case new
        case merge
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let origin = cell0.superview!.convert(cell0.frame.origin, to: gameboardView) COORDS CONVERT
        
        //        let someView = UIView(frame: CGRect(x: origin.x, y: origin.y, width: 50, height: 50))
        //        someView.backgroundColor = .yellow
        //        gameboardView.addSubview(someView)
        //        gameboardView.bringSubview(toFront: someView)
        //        UIView.animate(withDuration: 4) {
        //            someView.frame = CGRect(x: origin.x+30, y: origin.y, width: 50, height: 50)
        //        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


