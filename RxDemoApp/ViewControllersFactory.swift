//
//  ViewControllersFactory.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift

struct ViewControllersFactory
{
    static func viewController(_ type: AppViewControllers) -> Observable<UIViewController>
    {
        
        return Observable.create{ observable in
            
            switch type
            {
            case .signupFieldsViewController:
                
                observable.onNext(getViewController(from: .main, type: type))
            case .userProfileViewController:
                
                observable.onNext(getViewController(from: .main, type: type))
                
            case .accountViewController:
                
                observable.onNext(getViewController(from: .main, type: type))
            case .editProfileViewController:
                
                observable.onNext(getViewController(from: .main, type: type))
            case .setImageViewController:
                
                observable.onNext(getViewController(from: .main, type: type))
            }
            
            return Disposables.create()
        }
        
    }
    
    private static func getViewController(from storyboard: AppStoryboards, type: AppViewControllers) -> UIViewController
    {
        return getStoryboard(storyboard: storyboard).instantiateViewController(withIdentifier: type.rawValue)
    }
    
    private static func getStoryboard(storyboard: AppStoryboards, bundle: Bundle? = nil) -> UIStoryboard
    {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        return storyboard
    }
}
