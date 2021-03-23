//
//  UIView+ibinspectable.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/02/26.
//

import Foundation
import UIKit

extension UITextField {

    @IBInspectable
    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

    
}



