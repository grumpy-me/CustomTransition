//
//  AnimationImageView.swift
//  CustomTransitionPPTProj
//
//  Created by Meghaj  Patil on 25/10/21.
//

import UIKit

class AnimationImageView: UIView {
    
    enum ContentStyle {
        case scaleAspectFit
        case scaleAspectFill
    }
    
    let imageView: UIImageView
    
    init(image: UIImage?) {
        imageView = UIImageView(image: image)
        super.init(frame: .zero)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        imageView = UIImageView(image: nil)
        super.init(coder: aDecoder)
        addSubview(imageView)
    }

    var contentStyle: ContentStyle = .scaleAspectFill {
        didSet {
            guard let image = imageView.image else {return}
            let widthRatio = image.size.width / bounds.size.width
            let heightRatio = image.size.height / bounds.size.height
            switch contentStyle {
            case .scaleAspectFit:
                imageView.frame.size = .init(width: image.size.width/max(widthRatio, heightRatio), height: image.size.height/max(widthRatio, heightRatio))
            case .scaleAspectFill:
                imageView.frame.size = .init(width: image.size.width/min(widthRatio, heightRatio), height: image.size.height/min(widthRatio, heightRatio))
            }
            imageView.center = .init(x: bounds.size.width / 2, y: bounds.size.height / 2)
        }
    }
}
