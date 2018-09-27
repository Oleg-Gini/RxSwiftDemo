//
//  SignUpViewModel.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift

class SignUpViewModel: NSObject
{
    private(set) var signupFields: SignupFieldsViewController?
    
    let disposeBag = DisposeBag()
    private let baseViewController: UIViewController
    
    init(_ base: UIViewController)
    {
        self.baseViewController = base
        super.init()
    }
    
    func connectSignupField(to container: UIView) -> Observable<Void>
    {
        return Observable.create{ [weak self] observable in
          
            ViewControllersFactory.viewController(.signupFieldsViewController)
                .map({$0 as! SignupFieldsViewController})
                .subscribe(onNext: { [weak self] vc in
                
                guard let strongSelf = self else { return }
                
                strongSelf.signupFields = vc
                strongSelf.baseViewController.add(vc, container: container)
                
                    observable.onNext(())
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
        
    }
}
