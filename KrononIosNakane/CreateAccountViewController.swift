//
//  CreateAccountViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/10.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate  {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationBarのtitleとその色とフォント
        navigationItem.title = "アカウント作成"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        
        //NavigationBarの色
        //self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        //一部NavigationBarがすりガラス？のような感じになるのでfalseを指定
        self.navigationController?.navigationBar.isTranslucent = false
        
        //キーボードのデフォルトを設定したいのに変わらないよ
        inputName.keyboardType = .default
        inputMail.keyboardType = .emailAddress
        inputPassword1.keyboardType = .emailAddress
        inputPassword2.keyboardType = .emailAddress
        //入力内容を隠す
        inputPassword1.isSecureTextEntry = true
        inputPassword2.isSecureTextEntry = true
        
        inputName.delegate = self
        inputMail.delegate = self
        inputPassword1.delegate = self
        inputPassword2.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.parent?.navigationItem.hidesBackButton = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //returnを押したらキーボードを閉じるように
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var inputName: MyTextField!
    
    @IBOutlet weak var inputMail: MyTextField!
    
    @IBOutlet weak var inputPassword1: MyTextField!
    
    @IBOutlet weak var inputPassword2: MyTextField!
    
    @IBAction func createAccountAction(_ sender: Any) {
        self.performSegue(withIdentifier: "tabBarShow", sender: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginView", sender: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
