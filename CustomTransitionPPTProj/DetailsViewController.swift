//
//  DetailsViewController.swift
//  CustomTransitionPPTProj
//
//  Created by Meghaj  Patil on 25/10/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBAction func backTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardImage.layer.cornerRadius = 10
    }
    
}
