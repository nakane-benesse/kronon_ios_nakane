//
//  Test.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/31.
//

import UIKit

public protocol KrononApiProtocol {
    func login(username: String, password: String) -> Bool
}

class HogeViewController : UIViewController {
    var delegate: KrononApiProtocol
    
    init(_ delegate: KrononApiProtocol) {
        self.delegate = delegate
    }
    
    func buttonClicked() {
        self.delegate.login()
    }
}
