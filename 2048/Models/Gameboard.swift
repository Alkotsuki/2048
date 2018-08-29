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
    var tiles: [Int] //Store values for tiles
    var mergeIndex: [Int] //Store the position where a merge event occur
    
    init(dimension: Int) {
        self.dimension = dimension
        self.tiles = [Int](repeating: 0, count: dimension*dimension)
        self.mergeIndex = [Int](repeating: 0, count: dimension*dimension)
    }
    
    //MARK: CHECK IF GAMEBOARD IS FULL
    func isFull() -> Bool {
        
        for tile in tiles {
            if tile == 0 {
                return false
            }
        }
        return true
        
    }
    
    //MARK: FIND RANDOM EMPTY CELL
    func findRandomEmptyCell() -> Int {
        
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
    
    //MARK: CHECK FOR GAME OVER
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
    
    //MARK: SHIFTING TILES
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
        for row in 1..<dimension {
            for column in 0..<dimension {
                index = row * dimension + column
                
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
        for row in (0..<dimension - 1).reversed() {
            for column in 0..<dimension {
                
                index = row * dimension + column
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
        for column in 1..<dimension {
            for row in 0..<dimension {
                
                index = row * dimension + column
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
        for column in (0..<dimension - 1).reversed() {
            for row in 0..<dimension {
                index = row * dimension + column
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
