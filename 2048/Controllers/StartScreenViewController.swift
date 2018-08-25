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
    @IBOutlet weak var glitchLabel: GlitchLabel!
    
    var transition: JTMaterialTransition?
    
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
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyboard.instantiateViewController(withIdentifier: ViewControllers.gameNavigation)
        gameViewController.modalPresentationStyle = .custom
        gameViewController.transitioningDelegate = self.transition
        self.present(gameViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Parallax for views
        glitchLabel.addParallax(amount: 20)
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
        
        self.transition = JTMaterialTransition(animatedView: self.startButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func unwindToStartScreen(with segue: UIStoryboardSegue) {
        
    }
}
