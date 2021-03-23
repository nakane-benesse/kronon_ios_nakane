//
//  ViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func startButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goLoginView", sender: nil)
    }
    
}

