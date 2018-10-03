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

protocol SignupFieldsViewModelProtocol
{
    var disposeBag: DisposeBag { get set }
    
    var signupButtonNormalStateColor   : UIColor { get }
    var signupButtonDisabledStateColor : UIColor { get }
    
    var email           : BehaviorRelay<String> { get set }
    var password        : BehaviorRelay<String> { get set }
    var confirmPassword : BehaviorRelay<String> { get set }
    var isValid         : Observable<Bool>      { get set }
}

class SignupFieldsViewModel: SignupFieldsViewModelProtocol
{
    var disposeBag                     = DisposeBag()
    var signupButtonNormalStateColor   = UIColor.blue
    var signupButtonDisabledStateColor = UIColor.blue.withAlphaComponent(0.5)
    
    var email           = BehaviorRelay<String>(value: "")
    var password        = BehaviorRelay<String>(value: "")
    var confirmPassword = BehaviorRelay<String>(value: "")
    var isValid         = BehaviorRelay<Bool>(value: false).asObservable().share()
    
    init()
    {
        // ****Snippet #10 isValid Observable******
    }
}
