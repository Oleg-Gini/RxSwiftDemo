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
    
    let disposeBag  = DisposeBag()
    var emailField  = BehaviorRelay<String?>(value:nil)
    var pickedImage = BehaviorRelay<UIImage?>(value:nil)
    
    var newUserData: User?
    {
        guard let email = emailField.value  else { return nil }
        guard email.isValidEmail            else { return nil }
        
        let user = User()
        
        user.email.accept(emailField.value ?? "")
        user.image.accept("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF0bqDwBtHtNK7hBsG53X_qI0JA458QjRMeMlpI0hwsYlvUmz_")
        
        return user
    }
    
    private func subscribeForImageChanges()
    {
        setImageViewController?.pickedImage.asObservable().subscribe(onNext: { [weak self] image in
            
            self?.pickedImage.accept(image)
        })
        .disposed(by: disposeBag)
    }
    
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
                    
                    strongSelf.subscribeForImageChanges()
                    
                    observable.onNext(true)
                    observable.onCompleted()
                })
                .disposed(by: strongSelf.disposeBag)
            
            return disposables
        }
    }
}
