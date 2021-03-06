//
//  AccountViewModel.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 29/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift

class AccountViewModel: NSObject
{
    private(set) var userProfileView: UserProfileViewController?
    private(set) var editProfileView: EditProfileViewController?
    var initViewsConnected = false
    
    let disposeBag = DisposeBag()
    
    func connectUserProfileView(to container: UIView, viewController: UIViewController) -> Observable<Bool>
    {
        return Observable.create{ [weak self] observable in
            
            let disposables = Disposables.create()
            
            guard let strongSelf = self else { return disposables }
            
            ViewControllersFactory.viewController(.userProfileViewController)
                .map({$0 as! UserProfileViewController})
                .subscribe(onNext: { [weak self] vc in
                    
                    guard let strongSelf = self else { observable.onCompleted() ; return }
                    
                    strongSelf.userProfileView = vc
                    viewController.add(vc, container: container)
                    
                    observable.onNext(true)
                    observable.onCompleted()
                })
                .disposed(by: strongSelf.disposeBag)
            
            return disposables
        }
    }
    
    func connectEditProfileView(to container: UIView, viewController: UIViewController) -> Observable<Bool>
    {
        return Observable.create{ [weak self] observable in
            
            let disposables = Disposables.create()
            
            guard let strongSelf = self else { return disposables }
            
            ViewControllersFactory.viewController(.editProfileViewController)
                .map({$0 as! EditProfileViewController})
                .subscribe(onNext: { [weak self] vc in
                    
                    guard let strongSelf = self else { observable.onCompleted() ; return }
                    
                    strongSelf.editProfileView = vc
                    viewController.add(vc, container: container)
                    
                    observable.onNext(true)
                    observable.onCompleted()
                })
                .disposed(by: strongSelf.disposeBag)
            
            return disposables
        }
    }
}
