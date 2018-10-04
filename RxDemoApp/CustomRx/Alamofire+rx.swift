//
//  Alamofire+rx.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 28/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

extension DataRequest
{
    static func rxRequest(url: URL,method: HTTPMethod,parameters: Parameters? = nil,encoding: ParameterEncoding = URLEncoding.default,headers: HTTPHeaders? = nil) -> Observable<Data>
    {
        return Observable.create({ observable in

            Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: { response in
                
                if let status = response.response?.statusCode
                {
                    if status >= 200 && status < 400
                    {
                        if let data = response.data
                        {
                           observable.onNext(data)
                           observable.onCompleted()
                        }
                        else
                        {
                           observable.onError(response.error ?? NSError())
                        }
                    }
                    else
                    {
                        observable.onError(response.error ?? NSError())
                    }
                }
            })
            
            let dispose = Disposables.create()
            return dispose
        })
    }
}

