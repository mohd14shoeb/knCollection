//
//  File.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/6/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

protocol knWorker {
    func execute()
}

class fxSelectPhotoWorker : knWorker {
    
    var successResponse : ((UIImage) -> Void)? = nil
    var selectedImage : UIImage?
    var profilePicker: PhotoSelector?
    
    init(finishSelection: ((UIImage) -> Void)?) {
        successResponse = finishSelection
    }
    
    func execute() {
        profilePicker = PhotoSelector()
        profilePicker?.delegate = self
        profilePicker?.showSelection()
    }
    
}

extension fxSelectPhotoWorker : PhotoSelectorDelegate {
    
    func present(_ controller: UIViewController) {
  
        let topController = UIApplication.topViewController()
        topController?.present(controller, animated: true, completion: nil)
    }
    
    func didSelect(_ image: UIImage) {
        
        selectedImage = image
        successResponse?(image)
        profilePicker = nil
    }
}
