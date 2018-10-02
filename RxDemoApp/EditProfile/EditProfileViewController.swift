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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewModel  = EditProfileViewModel()
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
            viewModel.connectEditImageView(to: editImageContainer, viewController: self).asObservable().subscribe(onNext: { [weak self] _ in
                self?.setImageViewControllerObservers()
            }, onCompleted: {
                    print("EditProfileViewController viewModel.connectEditImageView onCompleted")
            }, onDisposed: {
                print("EditProfileViewController viewModel.connectEditImageView onDisposed")
            })
            .disposed(by: disposeBag)
        }
    }
}

//MARK: SetImageViewController Observers
extension EditProfileViewController
{
    private func setImageViewControllerObservers()
    {
        
    }
}
