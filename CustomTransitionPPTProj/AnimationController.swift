//
//  AnimationController.swift
//  CustomTransitionPPTProj
//
//  Created by Meghaj  Patil on 25/10/21.
//

import UIKit

class AnimationController: NSObject {

    private var animationDuration : Double = 2.25
    private var animationType: AnimationType = .backward
    private var imageViewPassed: UIImageView

    enum AnimationType {
        case forward
        case backward
    }

    init(animationDuration: Double, animationType: AnimationType, animatorImageView: UIImageView ) {
        self.animationDuration = animationDuration
        self.animationType = animationType
        self.imageViewPassed = animatorImageView
    }

}

extension AnimationController: UIViewControllerAnimatedTransitioning {


    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch animationType {
        case .forward:
            animateForward(using: transitionContext)
        case .backward:
            animateBackward(using: transitionContext)
        }
    }


    func animateForward(using transitionContext: UIViewControllerContextTransitioning) {

        let toViewController = transitionContext.viewController(forKey: .to) as! DetailsViewController

        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        containerView.sendSubviewToBack(toViewController.view)

        let animatingView = AnimationImageView(image: imageViewPassed.image)
        animatingView.frame = imageViewPassed.absoluteFrame()
        animatingView.clipsToBounds = true
        animatingView.contentStyle = .scaleAspectFit

        let imageCoverView = UIView()
        imageCoverView.frame = animatingView.frame
        imageCoverView.backgroundColor = .white
       
        let cornerRadius: CGFloat = 10

        let animatingCard = toViewController.cardImage.snapshotView(afterScreenUpdates: true) ?? UIView()
        animatingCard.backgroundColor = .white
        animatingCard.frame.origin.x = animatingView.frame.minX // 0
        animatingCard.frame.origin.y = animatingView.frame.maxY
        animatingCard.layer.cornerRadius = cornerRadius
        animatingCard.alpha = 1

        containerView.addSubview(imageCoverView)
        containerView.addSubview(animatingView)
        containerView.addSubview(animatingCard)


        let duration = transitionDuration(using: transitionContext)


        let containerMask = CAShapeLayer()
        let startFrame = CGRect(x: 0, y: 0, width: animatingView.frame.width, height: 0)
        containerMask.path = path(basedOn: startFrame, cornerRadius:0, corners: .allCorners)
        animatingCard.layer.mask = containerMask

        animatePath(for: containerMask,
                    toPath: path(basedOn: .init(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 350)),
                                 cornerRadius: cornerRadius,
                                 corners: .allCorners),
                    duration: duration, style: .easeInEaseOut)



        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {

            animatingView.frame.origin = CGPoint.zero
            animatingView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 370)
            animatingView.contentStyle = .scaleAspectFill

            animatingCard.frame.origin = .init(x: 0, y: 350)
            animatingCard.alpha = 1

        }) { _ in

            transitionContext.completeTransition(true)
            imageCoverView.removeFromSuperview()
            animatingView.removeFromSuperview()
            animatingCard.removeFromSuperview()

        }

    }


    func animateBackward(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from) as! DetailsViewController
        let toViewController = transitionContext.viewController(forKey: .to) as! ResultsViewController
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        containerView.bringSubviewToFront(toViewController.view)

        let animatingView = AnimationImageView(image: imageViewPassed.image)
        animatingView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 370)
        animatingView.clipsToBounds = true
        animatingView.contentStyle = .scaleAspectFill

        let imageCoverView = UIView()
        imageCoverView.frame = imageViewPassed.absoluteFrame()
        imageCoverView.backgroundColor = .white
       

        let cornerRadius: CGFloat = 10

        let animatingCard = fromViewController.cardImage.snapshotView(afterScreenUpdates: false) ?? UIView()
        animatingCard.backgroundColor = .white
        animatingCard.frame.origin = .init(x: 0, y: 350)
        animatingCard.frame.size = CGSize(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 350)
        animatingCard.layer.cornerRadius = cornerRadius

        containerView.addSubview(imageCoverView)
        containerView.addSubview(animatingView)
        containerView.addSubview(animatingCard)
    
        let duration = transitionDuration(using: transitionContext)


        let containerMask = CAShapeLayer()
        let startFrame = CGRect(x: 0, y: 0, width: animatingView.frame.width, height: UIScreen.main.bounds.height - 350)
        containerMask.path = path(basedOn: startFrame, cornerRadius:10, corners: .allCorners)
        animatingCard.layer.mask = containerMask

        animatePath(for: containerMask,
                    toPath: path(basedOn: .init(origin: CGPoint(x: 0, y: 0), size: CGSize(width: imageViewPassed.frame.width, height: 0)),
                                 cornerRadius: 10,
                                 corners: .allCorners),
                    duration: duration, style: .easeOut)



        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {

            animatingView.frame = self.imageViewPassed.absoluteFrame()
            animatingCard.frame.origin.x = animatingView.frame.minX
            animatingCard.frame.origin.y = animatingView.frame.maxY
            animatingView.contentStyle = .scaleAspectFit

        }) { _ in

            transitionContext.completeTransition(true)
            imageCoverView.removeFromSuperview()
            animatingView.removeFromSuperview()
            animatingCard.removeFromSuperview()

        }

    }

    func path(basedOn rect: CGRect, cornerRadius: CGFloat, corners: UIRectCorner) -> CGPath {
        return UIBezierPath.customRoundedRectanglePath(basedOn: rect, cornerRadius: cornerRadius, corners: corners).cgPath
    }

    func animatePath(for layer: CAShapeLayer, toPath: CGPath, duration: TimeInterval, style: CAMediaTimingFunctionName) {
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.timingFunction = .init(name: style)
        pathAnimation.duration = duration
        pathAnimation.fromValue = layer.path
        pathAnimation.toValue = toPath
        layer.path = toPath
        pathAnimation.isRemovedOnCompletion = true
        layer.add(pathAnimation, forKey: "path")
    }


}


extension UIView{

    func absoluteFrame() -> CGRect {
        return self.superview?.convert(self.frame, to: nil) ?? self.frame
    }
}

