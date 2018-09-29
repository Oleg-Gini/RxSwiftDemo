//
//  ViewController.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SignUpViewController: UIViewController
{
    private var viewModel: SignUpViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var signupFieldsContainer: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewModel = SignUpViewModel(self)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        viewModel.connectSignupField(to: signupFieldsContainer).asObservable().subscribe(onNext: { [weak self] _ in
            self?.subscribeForSignupFieldsViewControllerEvents()
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        })
        .disposed(by: disposeBag)
    }

    
}

//MARK: - SignupFieldsViewController Subscribes
extension SignUpViewController
{
    private func subscribeForSignupFieldsViewControllerEvents()
    {
        viewModel.signupFields?.buttonSignup.rx.tap
            .bind
            {[weak self] in
                
                guard let strongSelf = self else { return }
                
                _ = strongSelf.viewModel.userSignUp().subscribe(onNext: { _ in
                    print("User signed up")
                }, onError: { (error) in
                    print("viewModel.userSignUp() error \(error)")
                }, onCompleted: {
                    print("viewModel.userSignUp() onCompleted")
                }, onDisposed: {
                    print("viewModel.userSignUp() onDisposed")
                })
            }
            .disposed(by: viewModel.disposeBag)
    }
}

