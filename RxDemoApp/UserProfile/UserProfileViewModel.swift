//
//  UserProfileViewModel.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserProfileViewModel: NSObject
{
    let disposeBag = DisposeBag()
    private(set) var userModel =  BehaviorRelay<User>(value: UserManager.shared.user.value)

    override init()
    {
        super.init()
        
        UserManager.shared.user.subscribe(onNext: { [weak self] (user) in
            
            guard let strongSelf = self else { return }
            strongSelf.userModel.accept(user)
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("UserProfileViewModel user subscribe onCompleted")
        }) {
            print("UserProfileViewModel user subscribe onDisposed")
        }
        .disposed(by: disposeBag)
    }
}
