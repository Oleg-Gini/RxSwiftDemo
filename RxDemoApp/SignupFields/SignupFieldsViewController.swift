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
    private var viewModel: SignupFieldsViewModelProtocol = SignupFieldsViewModel()
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var emailField           : UITextField!
    @IBOutlet weak var passwordField        : UITextField!
    @IBOutlet weak var confirmPasswordField : UITextField!
    @IBOutlet weak var buttonSignup         : UIButton!
    
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
        //****Snippet #6  bind emailField ******

        //****Snippet #7  subscribe passwordField ******
        

        //****Snippet #8  subscribe confirm password field ******

        
        // ****Snippet #9  subscribe isValid ******

    }
}

//MARK: Private Methods
extension SignupFieldsViewController
{
    // ****Snippet #11  setPassword setConfirmPassword ******
    
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
