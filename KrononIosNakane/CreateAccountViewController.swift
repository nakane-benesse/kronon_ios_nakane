//
//  CreateAccountViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/10.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var inputName: MyTextField!
    @IBOutlet weak var inputMail: MyTextField!
    @IBOutlet weak var inputPassword1: MyTextField!
    @IBOutlet weak var inputPassword2: MyTextField!
    
    @IBAction func createAccountAction(_ sender: Any) {
        //入力チェック
        if(!isCheckInput()){
            return
        }
        //APIを叩く
        createAccount(name: inputName.text!, email: inputMail.text!, password: inputPassword1.text!)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goLoginView", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationBarのtitleとその色とフォント
        navigationItem.title = "アカウント作成"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        
        //NavigationBarの色
        //self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        //一部NavigationBarがすりガラス？のような感じになるのでfalseを指定
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        setKeyboad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.parent?.navigationItem.hidesBackButton = false
    }
    
    private func setKeyboad(){
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //returnを押したらキーボードを閉じるように
        textField.resignFirstResponder()
        return true
    }
    
    private func isCheckInput()->Bool{
        if(inputName.text!.isEmpty || inputMail.text!.isEmpty || inputPassword1.text!.isEmpty || inputPassword2.text!.isEmpty){
            AlertDialog.alert(viewController:self, title:"入力エラー", message:"未入力の項目があるよ。")
            return false
        }
        if(inputPassword1.text! != inputPassword2.text!){
            AlertDialog.alert(viewController:self, title:"入力エラー", message:"パスワードが一致してないよ")
            return false
        }
        
        if(!isPasswordCheck(password: inputPassword1.text!)){
            AlertDialog.alert(viewController:self, title:"入力エラー", message:"パスワードの入力規則を満たしていないよ。")
            return false
        }
        return true
    }
    
    private func isPasswordCheck(password:String)->Bool{
        var result = false
        let pattern = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,20}$")
        if(pattern.evaluate(with: password)){
            result = true
        }
        return result
    }
    
    
    
    private func createAccount(name:String, email:String, password:String){
        guard let reqestUrl = URL(string: CommonData.IP_ADDRESS+"api/users") else{
            return
        }
        
        
        let data: [String: Any] = ["name":name, "email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        
        //リクエストに必要な情報を生成
        var request = URLRequest(url: reqestUrl)
        request.httpMethod = "POST"
        
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("Basic \(authBase64)", forHTTPHeaderField: "Authorization")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            
            if let error = error {
                print("Failed to get item info: \(error)")
                return;
            }
            
            if let response = response as? HTTPURLResponse {
                
                if(response.statusCode == 400){
                    DispatchQueue.main.async {
                        AlertDialog.alert(viewController:self, title:"入力エラー", message:"メールアドレスが被っているよ")
                    }
                    return
                }else if(response.statusCode != 201){
                    DispatchQueue.main.async {
                        AlertDialog.alert(viewController:self, title:"予期せぬエラー", message:"問題が発生しちゃったよ。")
                    }
                    return
                }
                
            }
            
            if let data = data {
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    let success = jsonDict!["success"] as! Bool
                    //let loginData = jsonDict!["data"] as! LoginData
                    
                    
                    if(success) {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonDict!["data"]!, options: .prettyPrinted)
                        
                        if let createUserData = try? JSONDecoder().decode(CreateUserData.self, from: jsonData as Data) {
                            UserDefaults.standard.set(createUserData.email, forKey:"email")
                            UserDefaults.standard.set(createUserData.name, forKey:"name")
                            UserDefaults.standard.set(createUserData.token, forKey:"token")
                            //print(loginData.email)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        //self.itemInfoTextView.text = message
                        //self.performSegue(withIdentifier: "goTabBar", sender: nil)
                        AlertDialog.createUserDialog(viewController: self, title: "登録が完了したよ。", message: "")
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        AlertDialog.alert(viewController:self, title:"予期せぬエラー", message:"問題が発生しちゃったよ。")
                    }
                    print("Error parsing the response.")
                }
            } else {
                print("Unexpected error.")
                DispatchQueue.main.async {
                    AlertDialog.alert(viewController:self, title:"予期せぬエラー", message:"問題が発生しちゃったよ。")
                }
                return
            }
            
        }.resume()
        
    }
    
    //Modelの使い方わからず
    //    struct Response: Codable {
    //        let succcess: Bool
    //        let code: Int
    //        let data: LoginData
    //    }
    //
    //    struct ErrorResoinse: Codable {
    //        let succcess: Bool
    //        let code: Int
    //        let message: String
    //    }
    
    struct CreateUserData: Codable {
        let name: String
        let email: String
        let token: String
    }
    
    
}
