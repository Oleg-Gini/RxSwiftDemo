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
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let      topConstraint = NSLayoutConstraint(item: child.view, attribute: .top     , relatedBy: .equal, toItem: container, attribute: .top     , multiplier: 1.0, constant: 0.0)
        let   bottomConstraint = NSLayoutConstraint(item: child.view, attribute: .bottom  , relatedBy: .equal, toItem: container, attribute: .bottom  , multiplier: 1.0, constant: 0.0)
        let  leadingConstraint = NSLayoutConstraint(item: child.view, attribute: .leading , relatedBy: .equal, toItem: container, attribute: .leading , multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: child.view, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        container.addConstraints([topConstraint,bottomConstraint,leadingConstraint,trailingConstraint])
        
        child.didMove(toParent: self)
    }
    
    func remove()
    {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    var className: String
    {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? ""
    }
    
    func alert(title: String, text: String?) -> Observable<Void>
    {
        return Observable.create { [weak self] observer in
            
            let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: {_ in
                observer.onCompleted()
            }))
            
            self?.present(alertVC, animated: true, completion: nil)
            
            return Disposables.create
                {
                    self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension Data
{
    func toJsonObject(data: Data) -> Observable<[String:Any]>
    {
        return Observable.create({ observer in
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                {
                    observer.onNext(json)
                }
                
                observer.onCompleted()
            }
            catch
            {
                observer.onError(NSError())
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
    }
}

extension String
{
    var isValidEmail:  Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
