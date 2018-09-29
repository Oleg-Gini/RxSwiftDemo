//
//  SignUpViewModel.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

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
    
    func userSignUp() -> Observable<Void>
    {
        return Observable.create({ [weak self] observer in
            
            guard let strongSelf = self else { return Disposables.create()}
            
            UserManager.shared.userSignUp().subscribe(onNext: { (user) in
                observer.onNext(())
                observer.onCompleted()
            }, onError: { (error) in
                print(error)
                observer.onCompleted()
            }, onCompleted: {
                print("SignUpViewModel userSignUp() onCompleted")
            }) {
                print("SignUpViewModel userSignUp() onDisposed")
            }
            .disposed(by: strongSelf.disposeBag)
            
            return Disposables.create()
        })
    }
    
    func connectSignupField(to container: UIView) -> Observable<Bool>
    {
        return Observable.create{ [weak self] observable in
          
            ViewControllersFactory.viewController(.signupFieldsViewController)
                .map({$0 as! SignupFieldsViewController})
                .subscribe(onNext: { [weak self] vc in
                
                guard let strongSelf = self else { return }
                
                strongSelf.signupFields = vc
                strongSelf.baseViewController.add(vc, container: container)
                
                observable.onNext(true)
                observable.onCompleted()
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    func pushAccoutViewController()
    {
        
    }
}
