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
        
        inputEmail.delegate = self
        inputPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goTabBar", sender: nil)
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showCreateAccountView", sender: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //returnを押したらキーボードを閉じるように
        textField.resignFirstResponder()
        
        return true
    }
    
    //private, protected, publicは意識しょう
    private func viewSetUp(){
        
    }
    
    //メソッドの中でやる処理は１つが良い
    //メソッドにわけよう
    private func uiTextFieldRound(){
        
    }
    
    
    
    
    
}
