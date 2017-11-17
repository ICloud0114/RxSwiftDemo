//
//  NavBarTransparent.swift
//  NavBarTransparent
//
//  Created by Topband on 2017/4/1.
//  Copyright © 2017年 Topband. All rights reserved.
//

import UIKit

extension UIColor {
    open class var defaultNavBarTintColor: UIColor {
        return UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
    }
}

extension DispatchQueue {
    private static var onceTracker = [String]()
    
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if onceTracker.contains(token) {
            return
        }
        onceTracker.append(token)
        block()
    }
}

extension UIViewController {
    fileprivate struct AssociatedKeys {
        static var navBarBgAlpha: CGFloat = 1.0
        static var navBarTintColor: UIColor = UIColor.defaultNavBarTintColor
    }
    
    open var navBarBGAlpha: CGFloat {
        get {
            let alpha = objc_getAssociatedObject(self, &AssociatedKeys.navBarBgAlpha) as? CGFloat
            guard let alphaValue = alpha else {
                return 1.0
            }
            return alphaValue
        }
        set {
            var alpha = newValue
            if alpha > 1 {
                alpha = 1
            } else if alpha < 0 {
                alpha = 0
            }
            objc_setAssociatedObject(self, &AssociatedKeys.navBarBgAlpha, alpha, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            navigationController?.setNeedsNavigationBackground(alpha: alpha)
        }
    }
    
    open var navBarTintColor: UIColor {
        get {
            guard let tintColor = objc_getAssociatedObject(self, &AssociatedKeys.navBarTintColor) as? UIColor else {
                return UIColor.defaultNavBarTintColor
            }
            return tintColor
        }
        set {
            navigationController?.navigationBar.tintColor = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.navBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UINavigationController {
    fileprivate func setNeedsNavigationBackground(alpha: CGFloat) {
        let barBackgroundView = navigationBar.subviews[0]
        let valueForKey = barBackgroundView.value(forKey:)
        
        if let shadowView = valueForKey("_shadowView") as? UIView {
            shadowView.alpha = alpha
        }
        if navigationBar.isTranslucent {
            if #available(iOS 10.0, *) {
                if let backgroundEffectView = valueForKey("_backgroundEffectView") as? UIView,
                    navigationBar.backgroundImage(for: .default) == nil {
                    backgroundEffectView.alpha = alpha
                    return
                }
            } else {
                if let adaptiveBackdrop = valueForKey("_adaptiveBackdrop") as? UIView,
                    let backdropEffectView = adaptiveBackdrop.value(forKey: "_backdropEffectView") as? UIView {
                    backdropEffectView.alpha = alpha
                    return
                }
            }
        }
        barBackgroundView.alpha = alpha
    }
}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    private static let onceToken = UUID().uuidString
    
    open override class func initialize() {
        guard self == UINavigationController.self else {
            return
        }
        
        DispatchQueue.once(token: onceToken) {
            let needSwizzleSelectorArr = [
                NSSelectorFromString("_updateInteractiveTransition:"),
                #selector(popToViewController),
                #selector(popToRootViewController)
            ]
            
            for selector in needSwizzleSelectorArr {
                let str = ("et_" + selector.description).replacingOccurrences(of: "__", with: "_")
                let originalMethod = class_getInstanceMethod(self, selector)
                let swizzledMethod = class_getInstanceMethod(self, Selector(str))
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    func et_updateInteractiveTransition(_ percentComplete: CGFloat) {
        guard let topViewController = topViewController, let coordinator = topViewController.transitionCoordinator else {
            et_updateInteractiveTransition(percentComplete)
            return
        }
        
        let fromViewController = coordinator.viewController(forKey: .from)
        let toViewController = coordinator.viewController(forKey: .to)
        
        // Bg Alpha
        let fromAlpha = fromViewController?.navBarBGAlpha ?? 0
        let toAlpha = toViewController?.navBarBGAlpha ?? 0
        let newAlpha = fromAlpha + (toAlpha - fromAlpha) * percentComplete
        
        setNeedsNavigationBackground(alpha: newAlpha)
        
        // Tint Color
        let fromColor = fromViewController?.navBarTintColor ?? .blue
        let toColor = toViewController?.navBarTintColor ?? .blue
        let newColor = averageColor(fromColor: fromColor, toColor: toColor, percent: percentComplete)
        navigationBar.tintColor = newColor
        et_updateInteractiveTransition(percentComplete)
    }
    
    func et_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(alpha: viewController.navBarBGAlpha)
        navigationBar.tintColor = viewController.navBarTintColor
        return et_popToViewController(viewController, animated: animated)
    }
    
    func et_popToRootViewControllerAnimated(_ animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(alpha: viewControllers.first?.navBarBGAlpha ?? 0)
        navigationBar.tintColor = viewControllers.first?.navBarTintColor
        return et_popToRootViewControllerAnimated(animated)
    }
    
    // Calculate the middle Color with translation percent
    private func averageColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        let nowRed = fromRed + (toRed - fromRed) * percent
        let nowGreen = fromGreen + (toGreen - fromGreen) * percent
        let nowBlue = fromBlue + (toBlue - fromBlue) * percent
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent
        
        return UIColor(red: nowRed, green: nowGreen, blue: nowBlue, alpha: nowAlpha)
    }
}

extension UINavigationController: UINavigationBarDelegate {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if let topVC = topViewController, let coor = topVC.transitionCoordinator, coor.initiallyInteractive {
            if #available(iOS 10.0, *) {
                coor.notifyWhenInteractionChanges({ (context) in
                    self.dealInteractionChanges(context)
                })
            } else {
                coor.notifyWhenInteractionEnds({ (context) in
                    self.dealInteractionChanges(context)
                })
            }
            return true
        }
        
        let itemCount = navigationBar.items?.count ?? 0
        let n = viewControllers.count >= itemCount ? 2 : 1
        let popToVC = viewControllers[viewControllers.count - n]
        
        popToViewController(popToVC, animated: true)
        return true
    }
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        setNeedsNavigationBackground(alpha: topViewController?.navBarBGAlpha ?? 0)
        navigationBar.tintColor = topViewController?.navBarTintColor
        return true
    }
    
    private func dealInteractionChanges(_ context: UIViewControllerTransitionCoordinatorContext) {
        let animations: (UITransitionContextViewControllerKey) -> () = {
            let nowAlpha = context.viewController(forKey: $0)?.navBarBGAlpha ?? 0
            self.setNeedsNavigationBackground(alpha: nowAlpha)
            
            self.navigationBar.tintColor = context.viewController(forKey: $0)?.navBarTintColor
        }
        
        if context.isCancelled {
            let cancelDuration: TimeInterval = context.transitionDuration * Double(context.percentComplete)
            UIView.animate(withDuration: cancelDuration) {
                animations(.from)
            }
        } else {
            let finishDuration: TimeInterval = context.transitionDuration * Double(1 - context.percentComplete)
            UIView.animate(withDuration: finishDuration) {
                animations(.to)
            }
        }
    }
}
