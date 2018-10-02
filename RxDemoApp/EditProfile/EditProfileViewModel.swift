//
//  EditProfileViewModel.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditProfileViewModel: NSObject
{
    private(set) var setImageViewController: SetImageViewController?
    
    let disposeBag = DisposeBag()
    
    func connectEditImageView(to container: UIView, viewController: UIViewController) -> Observable<Bool>
    {
        return Observable.create{ [weak self] observable in
            
            let disposables = Disposables.create()
            
            guard let strongSelf = self else { return disposables }
            
            ViewControllersFactory.viewController(.setImageViewController)
                .map({$0 as! SetImageViewController})
                .subscribe(onNext: { [weak self] vc in
                    
                    guard let strongSelf = self else { observable.onCompleted() ; return }
                    
                    strongSelf.setImageViewController = vc
                    viewController.add(vc, container: container)
                    
                    observable.onNext(true)
                    observable.onCompleted()
                })
                .disposed(by: strongSelf.disposeBag)
            
            return disposables
        }
    }
}
