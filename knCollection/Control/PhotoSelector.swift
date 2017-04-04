//
//  ImageSelector.swift
//  WorkshopFixir
//
//  Created by Ky Nguyen on 2/28/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit


protocol PhotoSelectorDelegate: class {
    
    func present(_ controller: UIViewController)
    
    func didSelect(_ image: UIImage)
    
}

class PhotoSelector : NSObject {

    var delegate: PhotoSelectorDelegate?

    func showSelection() {
        
        let pickPhoto = UIAlertAction(title: "Choose from Gallery", style: .default) { (action) in
            self.pickImageFromPhotoLibrary()
        }
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            self.takePhoto()
        }
        
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menu.addAction(pickPhoto)
        menu.addAction(takePhoto)
        menu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        delegate?.present(menu)
    }
    
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
}


extension PhotoSelector: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        var pickedImage : UIImage
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            pickedImage = image
        }
        else {
            pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        delegate?.didSelect(pickedImage)
    }
    
    func takePhoto() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        delegate?.present(imagePicker)
    }
    
    func pickImageFromPhotoLibrary() {
        
        isStatusBarHidden = false
        UIApplication.shared.isStatusBarHidden = isStatusBarHidden
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        delegate?.present(imagePicker)
    }
    
}

