//
//  Gameboard.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

struct Gameboard: RandomsFor2048 {
    
    var dimension: Int
    var tiles: [Int]
    var mergeIndex: [Int] //store the position where a merge event occur
    
    init(dimension: Int) {
        self.dimension = dimension
        self.tiles = [Int](repeating: 0, count: dimension*dimension)
        self.mergeIndex = [Int](repeating: 0, count: dimension*dimension)
    }
    
    //Check if the gameboard has empty cells
    func isFull() -> Bool {
        for tile in tiles {
            if tile == 0 {
                return false
            }
        }
        return true
    }
    
    //Check cell for existing tile
//    func cellIsAvailable(at index: Int) -> Bool {
//
//        if tiles[index] > 0 {
//            return false
//        } else {
//            return true
//        }
//        
//    }
    
    //MARK: Find empty cell
//    mutating func findEmptyCell() -> Int {
//
//        let row = randomFromZero(to: 3)
//        let column = randomFromZero(to: 3)
//        let index = row * dimension + column
//
//        if self.cellIsAvailable(at: index) == false {
//            print("Tile already set at (\(row),\(column)). Will repeat")
//            return self.findEmptyCell()
//        }
//
//        return index
//
//    }
    
    func findEmptyCell() -> Int {
        
        var freeIndexes: [Int] = []
        var counter = 0
        
        for element in tiles {
            if element == 0 {
                freeIndexes.append(counter)
            }
            counter += 1
        }
        
        return freeIndexes[randomFromZero(to: freeIndexes.count)]

    }
    
    //Check for game over
    func isLost() -> Bool {
        
        var counter = 0
        var flaggedForCheck:[Int] = [Int](repeating: 0, count: 16)
        
        for x in 0..<dimension {
            for y in 0..<dimension {
                
                let index = x * dimension + y
                for i in -1...1 {
                    for j in -1...1 {
                        if abs(i) != abs(j) &&
                            x+i >= 0 && x+i < dimension &&
                            y+j >= 0 && y+j < dimension {
                            
                            let subIndex = (x + i) * dimension + (y + j)
                            if flaggedForCheck[subIndex] == 0 &&
                                self.tiles[subIndex] == self.tiles[index] {
                                counter += 1
                            }
                            
                        }
                    }
                }
                flaggedForCheck[index] = 1
                
            }
        }
        
        return counter == 0
    }
    
    //MARK: Shifting tiles
    mutating func shiftTiles(_ direction: UISwipeGestureRecognizerDirection) {
        
        switch direction {
        case .up:
            shiftUp()
        case .down:
            shiftDown()
        case .left:
            shiftLeft()
        case .right:
            shiftRight()
        default:
            break
        }

    }
    
    mutating func shiftUp() {
        var index: Int
        for r in 1..<dimension {
            for c in 0..<dimension {
                index = r * dimension + c
                
                if tiles[index - dimension] == 0 && tiles[index] > 0 {
                    tiles[index - dimension] = tiles[index]
                    tiles[index] = 0
                }
                else if tiles[index - dimension] == tiles[index] && tiles[index] > 0 {
                    tiles[index - dimension] *= 2
                    tiles[index] = 0
                    mergeIndex[index - dimension] = 1
                }
      
            }
        }
    }
    
    mutating func shiftDown() {
        var index: Int
        for r in (0..<dimension - 1).reversed() {
            for c in 0..<dimension {
                
                index = r * dimension + c
                if tiles[index + dimension] == 0 && tiles[index] > 0 {
                    tiles[index + dimension] = tiles[index]
                    tiles[index] = 0
                }
                else if tiles[index + dimension] == tiles[index] && tiles[index] > 0 {
                    tiles[index + dimension] *= 2
                    tiles[index] = 0
                    mergeIndex[index + dimension] = 1
                }
                
            }
        }
    }
    
    mutating func shiftLeft() {
        var index: Int
        for c in 1..<dimension {
            for r in 0..<dimension {
                
                index = r * dimension + c
                if tiles[index - 1] == 0 && tiles[index] > 0 {
                    tiles[index - 1] = tiles[index]
                    tiles[index] = 0
                }
                else if tiles[index - 1] == tiles[index] && tiles[index] > 0 {
                    tiles[index - 1] *= 2
                    tiles[index] = 0
                    mergeIndex[index - 1] = 1
                }
                
            }
        }
        
        
    }
    
    mutating func shiftRight() {
        var index: Int
        for c in (0..<dimension - 1).reversed() {
            for r in 0..<dimension {
                index = r * dimension + c
                if tiles[index + 1] == 0 && tiles[index] > 0 {
                    tiles[index + 1] = tiles[index]
                    tiles[index] = 0
                }
                else if tiles[index + 1] == tiles[index] && tiles[index] > 0 {
                    tiles[index + 1] *= 2
                    tiles[index] = 0
                    mergeIndex[index + 1] = 1
                }
                
                
            }
        }
        
    }
    
}
