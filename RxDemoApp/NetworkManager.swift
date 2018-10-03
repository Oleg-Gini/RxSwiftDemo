//
//  NetworkManager.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 28/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class NetworkManager: NSObject
{
    static func signUp() -> Observable<User>
    {
        return Observable.create({ observable in
            
            _ = Alamofire.DataRequest.rxRequest(url: URL(string: "https://pastebin.com/raw/cBLQVPsS")!, method: .get).asObservable().subscribe(onNext: { (data) in
                
                _=Data().toJsonObject(data: data)
                    .asObservable()
                    .map({$0["user"] as? [String:Any]})
                    .subscribe(onNext: { (json) in
                        
                        guard let user = json else { return }
                        
                        observable.onNext(User(dictionary: user))
                        observable.onCompleted()
                }, onError: { (error) in
                    print(error)
                    observable.onCompleted()
                }, onCompleted: {
                    print("Convert to JSON onCompleted")
                }, onDisposed: {
                    print("Convert to JSON onDisposed")
                })
                
            }, onError: { (error) in
                
                observable.onError(error)
                observable.onCompleted()
                
            }, onCompleted: {
                print("NetworkManager signUp() onCompleted")
            }) {
                print("NetworkManager signUp() disposed")
            }
            
            return Disposables.create()
        })
    }
    
    static func signUpURLSession() -> Observable<User>
    {
        let url     = URL(string: "https://pastebin.com/raw/cBLQVPsS")!
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        
        return URLSession.shared
            .rx
            .json(request: request)
            .retry(3)
            .filter( { guard let json = $0 as? [String: Any],
                let _ = json["user"] as? [String:Any] else { return false }; return true })
            .map({
                let json = $0 as! [String: Any]
                return User(dictionary: json["user"] as! [String:Any])
            })
        
    }
}
