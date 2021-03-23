//
//  CalendarViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/16.
//

import UIKit

class CalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ここに書いても反映されない（ライフサイクル）
        //NavigationBarのtitleとその色とフォント
        //        navigationItem.title = "カレンダー"
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]
        //
        //        //一部NavigationBarがすりガラス？のような感じになるのでfalseを指定
        //        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.parent?.navigationItem.title = "カレンダー"
        self.navigationController?.navigationBar.isTranslucent = false
        self.parent?.navigationItem.hidesBackButton = true
                
        super.viewWillAppear(animated)
        
        print("calendar willappear")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
        super.viewWillDisappear(animated)
        
        print("calendar willdisappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {

        createButtonAdd()

    }
    
    private func createButtonAdd(){
        //右上のボタン追加
        let button = UIButton(type: .system)
        button.semanticContentAttribute = .forceRightToLeft
        //button.setTitle("検索", for: .normal
        button.setImage(UIImage(named: "create_schedule_icon")!, for: .normal)
        let searchBarButtonItem = UIBarButtonItem(customView: button)
        self.parent?.navigationItem.rightBarButtonItem = searchBarButtonItem
        //ボタンの色
        self.navigationController?.navigationBar.tintColor =  UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
    }
    
}
