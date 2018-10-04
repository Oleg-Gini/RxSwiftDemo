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
 
    
    func showUserProfile(navigationController: UINavigationController)
    {
        //****Snippet #5 showUserProfile ******

    }
}
