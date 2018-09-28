//
//  SignupFieldsViewController.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SignupFieldsViewController: UIViewController
{
    private var viewModel  = SignupFieldsViewModel()
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var buttonSignup: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        subscribe()
    }
}

extension SignupFieldsViewController
{
    func subscribe()
    {
        //email
        emailField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        //password
        passwordField.rx.value.asObservable().subscribe(onNext: {[weak self] value in
            self?.setPassword(value)
        })
        .disposed(by: disposeBag)

        //confirm password
        confirmPasswordField.rx.value.asObservable().subscribe(onNext: { [weak self] value in
            self?.setConfirmPassword(value)
        })
        .disposed(by: disposeBag)
        
        // validadtion state
        viewModel.isValid
            .filter({ [weak self] (isValid) -> Bool in
                
                guard let strongSelf = self                        else { return false }
                guard strongSelf.buttonSignup.isEnabled != isValid else { return false }
                
                return true
            })
            .subscribe(onNext: { [weak self] isValid in
                
                self?.signupButtonState(enable: isValid)
        })
        .disposed(by: viewModel.disposeBag)
    }
}

//MARK: Private Methods
extension SignupFieldsViewController
{
    private func setPassword(_ text: String?)
    {
        guard let text = text else { return }
        
        viewModel.password.accept(text)
    }
    private func setConfirmPassword(_ text: String?)
    {
        guard let text = text else { return }
        
        viewModel.confirmPassword.accept(text)
    }
    
    private func signupButtonState(enable: Bool)
    {
        buttonSignup.isEnabled = enable
    }
    
    private func setupViews()
    {
        buttonSignup.setTitleColor(viewModel.signupButtonDisabledStateColor, for: .disabled)
        buttonSignup.setTitleColor(viewModel.signupButtonNormalStateColor, for: .normal)
    }
}
