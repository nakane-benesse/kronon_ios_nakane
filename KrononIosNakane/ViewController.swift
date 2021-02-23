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
        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginView", sender: nil)
    }
    
}

