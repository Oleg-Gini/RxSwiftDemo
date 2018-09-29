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

class User
{
    var email : BehaviorRelay<String>
    var image : BehaviorRelay<String>
    
    init(dictionary: [String: Any])
    {
        email = BehaviorRelay<String>(value: dictionary["email"] as? String ?? "")
        image = BehaviorRelay<String>(value: dictionary["image"] as? String ?? "")
    }
    
    init()
    {
        email = BehaviorRelay<String>(value: "")
        image = BehaviorRelay<String>(value: "")
    }
}
