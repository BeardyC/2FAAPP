//
//  dTextField.swift
//  2FAiOSApp
//
//  Created by Isabella Van Braeckel on 08/05/2017.
//  Copyright © 2017 BeardyC. All rights reserved.
//

import UIKit
@IBDesignable

class dTextField: UITextField {

    @IBInspectable var leftImage: UIImage?{
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            
            //leftView = UIImageView
        }else{
            leftViewMode = .never
        }
        
        
    }

}
