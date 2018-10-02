//
//  EditProfileViewController.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditProfileViewController: UIViewController
{
    private let disposeBag = DisposeBag()
    private var viewModel: EditProfileViewModel!

    @IBOutlet weak var editImageContainer: UIView!
    @IBOutlet weak var buttonSaveChanges : UIButton!
    @IBOutlet weak var emailField        : UITextField!
    
    var finishedEditing = PublishSubject<Void?>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewModel  = EditProfileViewModel()
        
        RxObservers()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        connectViews()
    }

    private func connectViews()
    {
        if viewModel.setImageViewController == nil
        {
            viewModel.connectEditImageView(to: editImageContainer, viewController: self).asObservable().subscribe(onNext: {  _ in
        
            }, onCompleted: {
                    print("EditProfileViewController viewModel.connectEditImageView onCompleted")
            }, onDisposed: {
                print("EditProfileViewController viewModel.connectEditImageView onDisposed")
            })
            .disposed(by: disposeBag)
        }
    }
    
    private func showAlert()
    {
        alert(title: "Wrong Email", text: "Please enter correct email address").asObservable().subscribe().disposed(by: disposeBag)
    }
}

//MARK: Rx Observers
extension EditProfileViewController
{
    private func RxObservers()
    {
        emailField.rx.text
            .orEmpty
            .bind(to: viewModel.emailField)
            .disposed(by: disposeBag)
        
        buttonSaveChanges
            .rx
            .controlEvent(.touchUpInside)
            .asObservable()
            .filter({
                guard let _ = self.viewModel.newUserData  else { return false }
                return true
            })
            .map({self.viewModel.newUserData!})
            .subscribe(onNext: { newUser in
            
                UserManager.shared.setUser(model: newUser)
                self.finishedEditing.onNext(nil)
            
        }).disposed(by: disposeBag)
        
        buttonSaveChanges.rx.tap.bind{ [weak self] in
            
            guard let strongSelf = self else { return }
            guard let email = strongSelf.viewModel.emailField.value else { return }
            
            if !email.isValidEmail
            {
                strongSelf.showAlert()
            }
        }
        .disposed(by: disposeBag)

    }
}
