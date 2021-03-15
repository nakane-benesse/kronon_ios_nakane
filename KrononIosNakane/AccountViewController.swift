//
//  AccountViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/16.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.parent?.navigationItem.title = "アカウント"
        self.navigationController?.navigationBar.isTranslucent = false
        self.parent?.navigationItem.hidesBackButton = true
        super.viewWillAppear(animated)
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
