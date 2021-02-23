//
//  LoginViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/02/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //これがないと角丸にならない
        inputEmail.layer.masksToBounds = true
        inputEmail.layer.cornerRadius = 20.0
        
        inputPassword.layer.masksToBounds = true
        inputPassword.layer.cornerRadius = 20.0
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 20.0
        
        // UITextFieldの左右に余白を入れる
        //UITextFieldクラスを継承した独自のクラスを作るのが本当は丸そうだが、よく分からないので一旦個別に指定してみる
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 0.0))
        inputEmail.leftView = paddingView
        inputEmail.leftViewMode = .always
        inputEmail.rightView = paddingView
        inputEmail.rightViewMode = .always
        
        //なぜかpaddingViewをもう一回使おうとするとフリーズするので再定義
        let paddingView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 0.0))
        inputPassword.leftView = paddingView2
        inputPassword.leftViewMode = .always
        inputPassword.rightView = paddingView2
        inputPassword.rightViewMode = .always
        
        
        inputEmail.delegate = self
        inputPassword.delegate = self
    }

    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginAction(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //returnを押したらキーボードを閉じるように
        textField.resignFirstResponder()
        
        return true
    }
    


}
