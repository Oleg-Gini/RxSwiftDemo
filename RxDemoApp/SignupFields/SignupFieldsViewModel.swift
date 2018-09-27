//
//  SignupFieldsViewModel.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct SignupFieldsViewModel
{
    private let disposeBag = DisposeBag()
    
    var signupButtonNormalStateColor   = UIColor.blue
    var signupButtonDisabledStateColor = UIColor.blue.withAlphaComponent(0.5)
    
    var email           = Variable<String>("")
    var password        = Variable<String>("")
    var confirmPassword = Variable<String>("")
    var isValid         = Variable<Bool>(false).asObservable().share()
    
    init()
    {
        isValid = Observable.combineLatest(password.asObservable(),confirmPassword.asObservable(), email.asObservable()) { password, confirmPassword, email in
            
            guard password.count >= 6   else { return false }
            guard email.isValidEmail    else { return false }
            
            return password == confirmPassword
        }
    }
}
