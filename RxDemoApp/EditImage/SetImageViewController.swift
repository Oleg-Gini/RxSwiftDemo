//
//  SetImageViewController.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 02/10/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Photos

class SetImageViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    private var imagePicker: ImagePickerController!

    private let disposeBag  = DisposeBag()
    
    //Rx
    var pickedImage = PublishSubject<UIImage>()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonOpenPhotos: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imagePicker = ImagePickerController()
        imageView.af_setImage(withURL: URL(string: UserManager.shared.user.value.image.value)!)
        RxSubscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        
        imageView.layer.cornerRadius  = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
    }

    private func RxSubscribes()
    {
        buttonOpenPhotos.rx.tap.bind{

            self.imagePicker?.present(controller: self)
        }
        .disposed(by: disposeBag)
        
        imagePicker?.pickedImage.subscribe(onNext: { [weak self] image in
            
            self?.imageView.image = image
            self?.pickedImage.onNext(image)
            
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("SetImageViewController imagePicker.pickedImage onCompleted")
        }) {
            print("SetImageViewController imagePicker.pickedImage onDisposed")
        }
        .disposed(by: disposeBag)
    }

}
