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
        return [cell0,  cell1,  cell2,  cell3,
                cell4,  cell5,  cell6,  cell7,
                cell8,  cell9,  cell10, cell11,
                cell12, cell13, cell14, cell15]
    }
    
    var score: Int = 0  {
        
        didSet {
            scoreLabel.text = "SCORE: \n\(score)"
            if score > record {
                personalBestLabel.text = "BEST: \n\(score)"
            }
        }
        
    }
    
    var record: Int {
        
        get {
            return defaults.integer(forKey: Keys.record)
        }
        set {
            defaults.set(newValue, forKey: Keys.record)
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
            let index = gameboard.findRandomEmptyCell()
            insertTile(at: index, with: value,  animation: .new)
            if gameboard.isFull() && gameboard.isLost() {
                gameOverAlert()
                print("Game Over")
            }
        }
        
    }
    
    //MARK: INSERT TILE
    func insertTile(at index:Int, with value:Int, animation type: TileAnimationType ) {
        
        //Finding cell coordinates in gameboard
        let cell = cells[index]
        let width = cell.frame.width
        let height = cell.frame.height
        let tileCoords = cell.bounds.origin
        
        //Creating new TileView
        let tile = TileView(position: tileCoords, width: width, height: height, value: value)
        gameboard.tiles[index] = value
        tileValue[index] = value
        tileView[index] = tile
        
        //Adding created TileView to gameboard
        cell.addSubview(tile)
        cell.bringSubview(toFront: tile)
        
        animateTile(tile, with: type)
        
    }
    
    //MARK: REFRESH UI
    func refreshUI() {
        
        let upperBound = gameboard.dimension * gameboard.dimension
        var counter = 0
        
        for index in 0..<upperBound {
            
            //If tile moved to empty cell
            if gameboard.tiles[index] != 0 && tileValue[index] == 0 {
                let value = gameboard.tiles[index]
                insertTile(at: index, with: value, animation: .none)
                counter = 1
            }
            
            //If tiled moved from cell and we need to "clear" cell
            if gameboard.tiles[index] == 0 && tileValue[index] != 0 {
                tileView[index]!.removeFromSuperview()
                tileValue[index] = 0
                tileView.removeValue(forKey: index)
                counter = 1
            }
            
            //If tile doesn't move and changed value
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
    }
    
    
    
    //MARK: OUTLETS    
    @IBOutlet weak var gameboardView: UIView!
    @IBOutlet weak var backgroundView: UIImageView!
    
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
    @IBOutlet weak var personalBestLabel: UILabel!
    
    @IBAction func addTilesButtonPressed(_ sender: UIButton) {
        generateTile()
        generateTile()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        newGame()
    }
    
    //MARK: BUTTON ANIMATIONS
    @IBAction func buttonTouched(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    //MARK: TILE ANIMATIONS
    enum TileAnimationType {
        case none
        case new
        case merge
    }
    
    func animateTile(_ tile: TileView, with type: TileAnimationType) {
        
        switch type {
            
        //Tile moved to new cell
        case .none:
            return
            
        //New tile added to gameboard
        case .new:
            tile.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            tile.alpha = 0
            
            UIView.animate(withDuration: 0.18, delay: 0.2, animations: {
                
                tile.alpha = 1
                tile.transform = CGAffineTransform.identity
                
            }, completion: nil)
            
        //Tiles merged in a cell
        case .merge:
            tile.pulsator.start()
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            
                            let scaleTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                            tile.transform = scaleTransform
                            
            }) { (_) in
                
                UIView.animate(withDuration: 0.01,
                               animations: {
                                
                                tile.transform = CGAffineTransform.identity
                                
                })
                
            }
            
        }
        
    }
    
    //MARK: GAME OVER ALERT
    enum AlertControllerStyle {
        case worldwideRecord
        case personalRecord
        case notARecord
    }
    
    func presentGameOverAlert(withMessage message: String, andStyle style: AlertControllerStyle) {
        
        let alertController = TextEnabledAlertController(title: "Game over",
                                                         message: message,
                                                         preferredStyle: .alert)
        
        switch style {
            
        case .worldwideRecord:
            let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) in
                if let name = alertController.textFields?.first?.text {
                    let newHighScore = Score(name: name, score: self.score)
                    DatabaseController.shared.uploadToFirestore(newHighScore)
                    self.scores.append(newHighScore)
                    self.scores = self.scores.sorted(by: { $0.score > $1.score })
                    self.performSegue(withIdentifier: Segues.showTop100, sender: self)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            saveAction.isEnabled = false
            
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Your name"
                textField.autocapitalizationType = .words
            }) { (textField) in
                saveAction.isEnabled = (textField.text?.count ?? 0) > 0
            }
            
        case .personalRecord:
            let saveAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(saveAction)
            
        case .notARecord:
            let saveAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(saveAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    private func gameOverAlert() {
        
        switch true {
            
        //World top-100
        case score > (scores.last?.score)!:
            presentGameOverAlert(withMessage: "You made it to Top-100 worldwide with score: \(score)",
                andStyle: .worldwideRecord)
            if score > record {
                record = score
            }
            
        //Personal best
        case score > record:
            presentGameOverAlert(withMessage: "New personal best: \(score)",
                andStyle: .personalRecord)
            record = score
            
        //Not even close to new best
        default:
            presentGameOverAlert(withMessage: "You scored: \(score)",
                andStyle: .notARecord)
        }
        
    }
    
    //MARK: SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showTop100 {
            let top100VC = segue.destination as! Top100TableViewController
            top100VC.scores = scores
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting score labels
        scoreLabel.text = "SCORE: \n\(score)"
        personalBestLabel.text = "BEST: \n\(record)"
        
        //Loading Top-100 from Firestore
        DatabaseController.shared.downloadTop100FromFirestore { (scores) in
            if scores.count != 0 {
                self.scores = scores
            } else {
                self.scores = Score.loadSampleTop100()
            }
        }
        
        backgroundView.addParallax(amount: -20)
        
        //Animating gameboard
        gameboardView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2 )
        gameboardView.alpha = 0
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [], animations: {
            self.gameboardView.alpha = 1
            self.gameboardView.transform = CGAffineTransform.identity
        }) { (_) in
            self.generateTile()
            self.generateTile()
        }
        
    }
    
}


