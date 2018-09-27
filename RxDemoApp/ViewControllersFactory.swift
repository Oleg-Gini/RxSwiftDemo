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
                
                let vc = getStoryboard(storyboard: .main).instantiateViewController(withIdentifier: type.rawValue)
                observable.onNext(vc)
                
            }
            
            return Disposables.create()
        }
        
    }
    
    private static func getStoryboard(storyboard: AppStoryboards, bundle: Bundle? = nil) -> UIStoryboard
    {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        return storyboard
    }
}
