//
//  AlertDialog.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/31.
//

import Foundation
import UIKit

//参考：https://qiita.com/funacchi/items/b76e62eb82fc8d788da5

class AlertDialog{
    public static func alert(viewController:UIViewController, title:String, message:String){
        //アラートのタイトル
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //ボタンのタイトル
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //実際に表示させる
        viewController.present(dialog, animated: true, completion: nil)
    }
}
