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
    private var viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var signupFieldsContainer: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //****Snippet #1 connectSignupField ******
      
        
    }

    
}

//MARK: - SignupFieldsViewController Subscribes
extension SignUpViewController
{
    private func subscribeForSignupFieldsViewControllerEvents()
    {
        //****Snippet #2 subscribeForSignupFieldsViewControllerEvents ******
   
    }
    
    private func userConnected()
    {
        guard let navigationController = self.navigationController else { return }
        viewModel.userConnected(navigationController: navigationController)
    }
}

