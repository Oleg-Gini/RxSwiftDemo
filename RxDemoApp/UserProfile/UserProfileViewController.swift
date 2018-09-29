//
//  UserProfileViewController.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevskiy on 27/09/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import AlamofireImage
import RxSwift

class UserProfileViewController: UIViewController
{
    private let disposeBag = DisposeBag()
    private let viewModel  = UserProfileViewModel()
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userEmail : UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        rxSubscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userImage.layer.cornerRadius  = userImage.frame.height / 2
        userImage.layer.masksToBounds = true
    }
    
    private func rxSubscribes()
    {
        viewModel.userModel.subscribe(onNext: { [weak self] (user) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.setUserData(user: user)
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("UserProfileViewController userModel.subscribe onCompleted")
        }) {
            print("UserProfileViewController userModel.subscribe onDisposed")
        }
        .disposed(by: disposeBag)
    }
    
    private func setUserData(user: User)
    {
        userEmail.text = user.email.value
        
        guard let imageURl = URL(string:user.image.value) else { return }
        userImage.af_setImage(withURL: imageURl)
    }
}
