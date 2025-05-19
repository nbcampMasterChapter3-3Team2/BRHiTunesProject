//
//  CardExpandAnimator.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/15/25.
//

import UIKit

final class CardExpandAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame: CGRect = .zero

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else { return }

        let containerView = transitionContext.containerView

        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)

        toView.frame = initialFrame
        toView.layer.cornerRadius = 20
        toView.clipsToBounds = true

        containerView.addSubview(toView)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.frame = finalFrame
            toView.layer.cornerRadius = 0
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}

final class CardTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    var originFrame: CGRect = .zero

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = CardExpandAnimator()
        animator.originFrame = originFrame
        return animator
    }
}
