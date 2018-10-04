//
//  RxUnwrapOptional.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 02/10/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import RxSwift

extension ObservableType
{
    public func unwrap<T>() -> Observable<T> where E == T? {
        
        return self.filter { $0 != nil }.map { $0! }
    }
}
