//
//  ScheduleViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/16.
//

import UIKit

class ScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.parent?.navigationItem.title = "予定表"
        self.navigationController?.navigationBar.isTranslucent = false
        self.parent?.navigationItem.hidesBackButton = true
        
        //右上のボタン追加
        let button = UIButton(type: .system)
        button.semanticContentAttribute = .forceRightToLeft
        //button.setTitle("検索", for: .normal
        button.setImage(UIImage(named: "create_schedule_icon")!, for: .normal)
        let searchBarButtonItem = UIBarButtonItem(customView: button)
        self.parent?.navigationItem.rightBarButtonItem = searchBarButtonItem
        //ボタンの色
        self.navigationController?.navigationBar.tintColor =  UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
        super.viewWillDisappear(animated)
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
