//
//  ViewController.swift
//  CustomTransitionPPTProj
//
//  Created by Meghaj  Patil on 25/10/21.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var slowAnimationView: UIView!
    @IBOutlet weak var fastAnimationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fastAnimationView.layer.borderWidth = 2
        fastAnimationView.layer.borderColor = UIColor.black.cgColor
        
        slowAnimationView.layer.borderWidth = 2
        slowAnimationView.layer.borderColor = UIColor.black.cgColor
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        fastAnimationView.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        slowAnimationView.addGestureRecognizer(tap2)
        
        let pan1 = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan1(_:)))
        fastAnimationView.addGestureRecognizer(pan1)

        let pan2 = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan2(_:)))
        slowAnimationView.addGestureRecognizer(pan2)
    }

    @objc func handleTap1(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
    }

    @objc func handleTap2(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
    }
    
    @objc func handlePan1(_ sender: UIPanGestureRecognizer? = nil) {
        handlePan(sender: sender!)
    }

    @objc func handlePan2(_ sender: UIPanGestureRecognizer? = nil) {
        handlePan(sender: sender!)
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        let gesture = sender
        let translation = gesture.translation(in: view)

        // 2
        guard let gestureView = gesture.view else {
            return
        }

        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )

        // 3
        gesture.setTranslation(.zero, in: view)

    }
}

