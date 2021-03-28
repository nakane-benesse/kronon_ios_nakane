//
//  CreateScheduleViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/24.
//

import UIKit

class CreateScheduleViewController: UIViewController , UITextFieldDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var inputStartTime: UITextField!
    @IBOutlet weak var inputEndTime: UITextField!
    @IBOutlet weak var inputPlace: UITextField!
    @IBOutlet weak var inputContent: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func CreateScheduleAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goTabBar", sender: nil)
    }
    
    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    
    //UIDatePickerを定義するための変数
    var datePicker: UIDatePicker = UIDatePicker()
    var timePicker: UIDatePicker = UIDatePicker()    
    var pickerView: UIPickerView = UIPickerView()
    let placeList = ["オフィス", "在宅", "外出"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "予定登録"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        
        inputTitle.delegate = self
        inputStartTime.delegate = self
        inputEndTime.delegate = self
        inputPlace.delegate = self
        //inputContent.delegate = self
        scrollView.delegate = self
        
        
        setupNotifications()
        
        //uiViewのキーボードを閉じる
        setDismissKeyboard()
        
        //DatePicker設定
        setDatePicker()
        
        //時間のdatePickerの設定
        setTimePicker()
        setStartTimeField()
        setEndTimeField()
        
        //場所
        placePullDownSet()
        
        
    }
    
    
    // https://qiita.com/ryomaDsakamoto/items/ab4ae031706a8133f193
    private func setDatePicker(){
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale(identifier: "ja_JP") //Locale.current
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        //inputDate.inputView = datePicker
        
        // 決定バーの生成
        //let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.farame.size.width, height: 35))
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        inputDate.inputView = datePicker
        inputDate.inputAccessoryView = toolbar
    }
    
    // UIDatePickerのDoneを押したら発火
    @objc func datePickerDone() {
        inputDate.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "yyyy年MM月dd日"
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        inputDate.text = "\(formatter.string(from: datePicker.date))"
    }
    
    //時間用のdatePickerの設定
    private func setTimePicker(){
        // ピッカー設定
        timePicker.datePickerMode = UIDatePicker.Mode.time
        timePicker.timeZone = NSTimeZone.local
        timePicker.locale = Locale(identifier: "ja_JP") //Locale.current
        timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        timePicker.minuteInterval = 15
        
        //        let formatter = DateFormatter()
        //        formatter.dateFormat =  "HH:mm"
        //        let min = formatter.date(from: "8:00")      //createing min time
        //        let max = formatter.date(from: "20:00") //creating max time
        //        datePicker.minimumDate = min  //setting min time to picker
        //        datePicker.maximumDate = max  //setting max time to picker
        //inputDate.inputView = datePicker
        
        //8:00-20:00の制約
        // https://stackoverflow.com/questions/49520781/restricting-enabled-time-to-a-specific-time-span-in-uidatepicker-swift-4/49521457
        let cal = Calendar.current
        let now = Date()  // get the current date and time (2018-03-27 19:38:44)
        let components = cal.dateComponents([.day, .month, .year], from: now)  // extract the date components 28, 3, 2018
        let today = cal.date(from: components)!  // build another Date value just with date components, without the time (2018-03-27 00:00:00)
        timePicker.minimumDate = today.addingTimeInterval(60 * 60 * 8)  // adds 9h
        timePicker  .maximumDate = today.addingTimeInterval(60 * 60 * 20) // adds 21h
        
    }
    
    //開始時間fieldにpickerの指定
    private func setStartTimeField(){
        // 決定バーの生成
        //let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.farame.size.width, height: 35))
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        //let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.timePickerDone(textField:)))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.startTimePickerDone))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        inputStartTime.inputView = timePicker
        inputStartTime.inputAccessoryView = toolbar
    }
    //pickerで指定した時間を、開始時間fieldに反映する
    @objc func startTimePickerDone() {
        inputStartTime.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "H:mm"
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        inputStartTime.text = "\(formatter.string(from: timePicker.date))"
    }
    
    //終了時間fieldにpickerの指定
    private func setEndTimeField(){
        // 決定バーの生成
        //let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.farame.size.width, height: 35))
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        //let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.timePickerDone(textField:)))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.endTimePickerDone))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        inputEndTime.inputView = timePicker
        inputEndTime.inputAccessoryView = toolbar
    }
    //pickerで指定した時間を、終了時間fieldに反映する
    @objc func endTimePickerDone() {
        inputEndTime.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "H:mm"
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        inputEndTime.text = "\(formatter.string(from: timePicker.date))"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // https://qiita.com/naoki_koreeda/items/6f3057012b52979fcd9c
    //place list プルダウン
    private func placePullDownSet(){
        
        pickerView.delegate = self
        pickerView.dataSource = self
        //pickerView.showsSelectionIndicator = true
        self.inputPlace.text = placeList[0]
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.placePickerDone))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        //let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        self.inputPlace.inputView = pickerView
        self.inputPlace.inputAccessoryView = toolbar
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return placeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return placeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.inputPlace.text = placeList[row]
    }
    
    @objc func placePickerDone() {
        self.inputPlace.endEditing(true)
    }
    //place list プルダウン ここまで
    
    
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
