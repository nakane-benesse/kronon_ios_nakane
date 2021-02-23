//
//  LoginViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/02/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //これがないと角丸にならない
        inputEmail.layer.masksToBounds = true
        inputEmail.layer.cornerRadius = 20.0
        inputPassword.layer.masksToBounds = true
        inputPassword.layer.cornerRadius = 20.0
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 20.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var inputEmail: UITextField!
    
 
    @IBOutlet weak var inputPassword: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func loginAction(_ sender: Any) {
    }
}
