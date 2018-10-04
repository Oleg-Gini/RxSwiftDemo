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

    //****Snippet #3 userSignUp ******
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
   
    //****Snippet #4 connectSignupField ******
    func connectSignupField(to container: UIView, viewController: UIViewController) -> Observable<Bool>
    {
        return Observable.create{ [weak self] observable in
            
            ViewControllersFactory.viewController(.signupFieldsViewController)
                .map({$0 as! SignupFieldsViewController})
                .subscribe(onNext: { [weak self] vc in
                    
                    guard let strongSelf = self else { return }
                    
                    strongSelf.signupFields = vc
                    viewController.add(vc, container: container)
                    
                    observable.onNext(true)
                    observable.onCompleted()
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    func showUserProfile(navigationController: UINavigationController)
    {
        //****Snippet #5 showUserProfile ******
        ViewControllersFactory.viewController(.accountViewController)
            .map({$0 as! AccountViewController})
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {  vc in
                
                navigationController.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
