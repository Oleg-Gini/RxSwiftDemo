//
//  Extentions.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//
import UIKit
import RxSwift

extension UIViewController
{
    func add(_ child: UIViewController, frame: CGRect? = nil, container: UIView)
    {
        addChild(child)
        
        child.view.frame = container.bounds
        
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove()
    {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? ""
    }
}
