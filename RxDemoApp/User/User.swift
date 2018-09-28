//
//  User.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class User: NSObject
{
    static var shared = User()
    
    private(set) var user = BehaviorRelay<User>(value: User())
    
    func setUser(model: User)
    {
        user.accept(model)
    }
}
