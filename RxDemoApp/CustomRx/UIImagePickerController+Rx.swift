//
//  UIImagePickerController+Rx.swift
//  RxDemoApp
//
//  Created by Oleg Tsibulevsky on 02/10/2018.
//  Copyright © 2018 Oleg Tsibulevsky. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit


class ImagePickerController: NSObject,UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    private var selectedImage = BehaviorRelay<UIImage?>(value: nil)
    
    var pickedImage: Observable<UIImage>
    {
        return selectedImage.asObservable().unwrap().share()
    }
    
    private let imagePicker = UIImagePickerController()
    
    override init()
    {
        super.init()
        
        imagePicker.delegate   = self
        imagePicker.sourceType = .photoLibrary
    }
    
    func present(controller: UIViewController)
    {
        controller.present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ImagePickerController
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage else { dismissPicker(picker); return }
        
        selectedImage.accept(image)
        dismissPicker(picker)
    }
    
    private func dismissPicker(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}

