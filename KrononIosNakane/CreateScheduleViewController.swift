//
//  CreateScheduleViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/24.
//

import UIKit

class CreateScheduleViewController: UIViewController , UITextFieldDelegate, UIScrollViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "予定登録"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        
        inputTitle.delegate = self
        inputPlace.delegate = self
        //inputContent.delegate = self
        scrollView.delegate = self
        

        setupNotifications()
        
        //uiViewのキーボードを閉じる
        setDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    

    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputPlace: UITextField!
    @IBOutlet weak var inputContent: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    

    private func setupNotifications() {
      //キーボードが表示される時呼ばれるNotification
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
      //キーボードが非表示になる時呼ばれるNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        
        //できないよおおおおおおおおお
//        //キーボードのサイズ
//        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
//              //キーボードのアニメーション時間
//              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
//              //キーボードのアニメーション曲線
//              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
//              //Outletで結び付けたScrollViewのBottom制約
//              let scrollViewBottom = self.scrollViewBottom else { return }
//
//        //キーボードの高さ
//        let keyboardHeight = keyboardFrame.height
//        //Bottom制約再設定
//        scrollViewBottom.constant = keyboardHeight
//
//        //アニメーションを利用してキーボードが上がるアニメーションと同じ速度でScrollViewのたBottom制約設定を適応
//        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
//          self.view.layoutIfNeeded()
//        })
      print("キーボード表示")
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
      print("キーボード非表示")
    }
    
    //textfield用
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //returnを押したらキーボードを閉じるように
        textField.resignFirstResponder()
        return true
    }


}

extension UIViewController {
    
    //UIViewで、他の場所をタップした時にキーボードを閉じる
    func setDismissKeyboard() {
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
