//
//  StartScreenViewController.swift
//  2048
//
//  Created by Pavel Koval on 8/14/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.addParallax(amount: 20)
        backgroundImage.addParallax(amount: -20)

        
        //Pulsator for "New game" button
        let pulse = Pulsator()
        pulse.frame = CGRect(x: startButton.frame.width / 2, y: startButton.frame.height / 2, width: 0, height: 0)
        startButton.layer.addSublayer(pulse)
        pulse.backgroundColor = UIColor.white.cgColor
        pulse.radius = 200
        pulse.animationDuration = 0.8
        pulse.pulseInterval = 2
        pulse.start()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func unwindToStartScreen(with segue: UIStoryboardSegue) {
        
    }
}
