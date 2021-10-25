//
//  ViewController.swift
//  CustomTransitionPPTProj
//
//  Created by Meghaj  Patil on 25/10/21.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var slowAnimationView: UIView!
    @IBOutlet weak var slowImage: UIImageView!
    @IBOutlet weak var fastAnimationView: UIView!
    @IBOutlet weak var fastImage: UIImageView!
    
    var animationData: (UIImageView, TimeInterval)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.delegate = self
        navigationController?.navigationBar.isHidden = true
        
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
        guard let sender = sender else {return}
        animationData = (fastImage, 0.30)
        handleTap(sender: sender)
    }

    @objc func handleTap2(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {return}
        animationData = (slowImage, 2.25)
        handleTap(sender: sender)
    }
    
    @objc func handlePan1(_ sender: UIPanGestureRecognizer? = nil) {
        guard let sender = sender else {return}
        handlePan(sender: sender)
    }

    @objc func handlePan2(_ sender: UIPanGestureRecognizer? = nil) {
        guard let sender = sender else {return}
        handlePan(sender: sender)
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        let gesture = sender
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else {
            return
        }
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ResultsViewController: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            return AnimationController(animationDuration: animationData!.1, animationType: .forward , animatorImageView: animationData!.0)
        case .pop:
            return AnimationController(animationDuration: animationData!.1, animationType: .backward , animatorImageView: animationData!.0)
        default: return nil
        }

    }
}
