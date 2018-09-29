//
//  UserManager.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 29/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserManager: NSObject
{
    static var shared = UserManager()
    
    private(set) var user = BehaviorRelay<User>(value: User())
    
    func setUser(model: User)
    {
        user.accept(model)
    }
    
    func userSignUp() -> Observable<User>
    {
        return Observable.create({ observer in
            
            _ = NetworkManager.signUp().subscribe(onNext: { (user) in
                observer.onNext(user)
                UserManager.shared.setUser(model: user)
                //observer.onCompleted()
            }, onError: { (error) in
                observer.onError(error)
                observer.onCompleted()
            }, onCompleted: {
                print("UserManager userSignUp onCompleted")
            }) {
                print("UserManager userSignUp onDisposed")
            }
            
            return Disposables.create()
        })
    }
}
