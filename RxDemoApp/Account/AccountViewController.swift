//
//  AccountViewController.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 29/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxSwift

class AccountViewController: UIViewController
{
    private let viewModel  = AccountViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var userProfileContainer: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        viewModel.connectUserProfileView(to: userProfileContainer, viewController: self).asObservable().subscribe(onNext: { [weak self] _ in
            
        }, onCompleted: {
            print("AccountViewController viewModel.connectUserProfileView onCompleted")
        }, onDisposed: {
            print("AccountViewController viewModel.connectUserProfileView onDisposed")
        })
        .disposed(by: disposeBag)
    }
    
}
