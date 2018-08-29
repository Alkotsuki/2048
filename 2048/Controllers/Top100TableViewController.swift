//
//  Top100TableViewController.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

class Top100TableViewController: UITableViewController {
    
    var scores: [Score] = []
    
    //MARK: CONFIGURING TABLE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCells.top100CellIdentifier, for: indexPath) as! Top100TableViewCell
        let score = scores[indexPath.row]
        cell.numberLabel.text = "\(indexPath.row + 1)."
        cell.nameLabel.text   = score.name
        cell.scoreLabel.text  = "\(score.score)"
        
        return cell
    }
    
    //MARK: ANIMATING TABLE
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let cellHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: cellHeight)
        }
        
        var delayCounter: Double = 0.0
        
        for cell in cells {
            UIView.animate(withDuration: 1.75,
                           delay: delayCounter * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }
    
}
