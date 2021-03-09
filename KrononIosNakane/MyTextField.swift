//
//  MyTextField.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/09.
//

import UIKit

//カスタムクラスのサンプル


class MyTextField: UITextField {
    
    //初期化するメソッドをオーバーライドする

    //styleとかの情報はここに書く
    //controllerにはstyleの情報は書かないほうが綺麗かな

    /// テキストの内側の余白
        @IBInspectable var padding: CGPoint = CGPoint(x: 20.0, y: 0.0)

        // MARK: Internal Methods

        override func textRect(forBounds bounds: CGRect) -> CGRect {
            // テキストの内側に余白を設ける
            return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            // 入力中のテキストの内側に余白を設ける
            return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
        }

        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            // プレースホルダーの内側に余白を設ける
            return bounds.insetBy(dx: self.padding.x, dy: self.padding.y)
        }

}
