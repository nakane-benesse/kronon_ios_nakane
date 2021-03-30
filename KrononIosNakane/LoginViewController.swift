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
        
        //キーボードのデフォルトを設定したいのに変わらないよ
        inputEmail.keyboardType = .emailAddress
        inputPassword.keyboardType = .emailAddress
        //入力内容を隠す
        inputPassword.isSecureTextEntry = true
        
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
        let email = inputEmail.text!
        let password = inputPassword.text!
        if(email.isEmpty || password.isEmpty ){
            AlertDialog.alert(viewController:self, title:"入力エラー", message:"未入力の項目があるよ。")
            return
        }
        login(email: email, password: password)
        
        //self.performSegue(withIdentifier: "goTabBar", sender: nil)
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showCreateAccountView", sender: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //returnを押したらキーボードを閉じるように
        textField.resignFirstResponder()
        
        return true
    }
    
    
    private func login(email:String, password:String){
        guard let reqestUrl = URL(string: CommonData.IP_ADDRESS+"api/login") else{
            return
        }
        
        let authString = String(format: "%@:%@", email, password)
        let authData = authString.data(using: String.Encoding.utf8)!
        let authBase64 = authData.base64EncodedString()
        
        let data: [String: Any] = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        
        //リクエストに必要な情報を生成
        var request = URLRequest(url: reqestUrl)
        request.httpMethod = "POST"
        
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(authBase64)", forHTTPHeaderField: "Authorization")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            
            if let error = error {
                print("Failed to get item info: \(error)")
                return;
            }
            
            if let response = response as? HTTPURLResponse {
                
                if(response.statusCode == 400){
                    DispatchQueue.main.async {
                        AlertDialog.alert(viewController:self, title:"入力エラー", message:"入力内容が間違っているよ。")
                    }
                    return
                }else if(response.statusCode != 200){
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
                        
                        if let loginData = try? JSONDecoder().decode(LoginData.self, from: jsonData as Data) {
                            UserDefaults.standard.set(loginData.email, forKey:"email")
                            UserDefaults.standard.set(loginData.name, forKey:"name")
                            UserDefaults.standard.set(loginData.token, forKey:"token")
                            //print(loginData.email)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        //self.itemInfoTextView.text = message
                        self.performSegue(withIdentifier: "goTabBar", sender: nil)
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
        
        //データ転送を管理するためのセッションを生成
        //let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //リクエストをタスクとして登録
        //        let task = session.dataTask(with: request, completionHandler: (data, response, error), in
        //
        //        )
        //        let task = session.dataTask(with: request, completionHandler: {
        //            (data , response , error) in
        //            // セッションを終了
        //            session.finishTasksAndInvalidate()
        //            // do try catch エラーハンドリング
        //            do {
        //                // JSONDecoderのインスタンス取得
        //                let decoder = JSONDecoder()
        //                // 受け取ったJSONデータをパース（解析）して格納
        //                //let json = try decoder.decode(Response.self, from: data!)
        //
        //
        //
        //            } catch {
        //                // エラー処理
        //                 print("エラーが出ました")
        //            }
        //        })
        //        // ダウンロード開始
        //        task.resume()
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
    
    struct LoginData: Codable {
        let name: String
        let email: String
        let token: String
    }
    
    
}
