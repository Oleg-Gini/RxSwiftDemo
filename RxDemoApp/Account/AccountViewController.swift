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
    @IBOutlet weak var editProfileContainer: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        connectViews()
    }
    
}

//MARK: Rx UserProfileContainer
extension AccountViewController
{
    private func rxUserProfileContainer()
    {
        viewModel.userProfileView?.buttonEdit.rx.tap.bind{ [weak self] in
            
            guard let strongSelf = self else { return }

            print("tap")
            
        }
        .disposed(by: viewModel.disposeBag)
    }
    
    private func rxEditProfileContainer()
    {
        
    }
    
    private func connectViews()
    {
        guard !viewModel.initViewsConnected else { return }
        
        viewModel.initViewsConnected = true
        
        viewModel.connectUserProfileView(to: userProfileContainer, viewController: self).asObservable().subscribe(onNext: { [weak self] _ in
            self?.rxUserProfileContainer()
        }, onCompleted: {
            print("AccountViewController viewModel.connectUserProfileView onCompleted")
        }, onDisposed: {
            print("AccountViewController viewModel.connectUserProfileView onDisposed")
        })
        .disposed(by: disposeBag)
        
        viewModel.connectEditProfileView(to: editProfileContainer, viewController: self).asObservable().subscribe(onNext: { [weak self] _ in
            self?.rxEditProfileContainer()
        }, onCompleted: {
            print("AccountViewController viewModel.connectEditProfileView onCompleted")
        }, onDisposed: {
            print("AccountViewController viewModel.connectEditProfileView onDisposed")
        })
        .disposed(by: disposeBag)
    }
}
