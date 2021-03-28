//
//  CustomDatePicker.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/28.
//

import UIKit

class CustomDatePicker: UIDatePicker {

    let label = UILabel()
    
    func updateLabel() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.setLocalizedDateFormatFromTemplate("yyyy年 M月 d日")
        label.text = formatter.string(from: date)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addSubview(label)
    }
    
    func makeTransparent(view: UIView) {
        if view === label { return }
        if view.backgroundColor != nil {
            view.isHidden = true
        } else {
//            for subview in view.subviews {
//                //customize(view: subview)
//            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeTransparent(view: self)
        label.frame = CGRect(origin: .zero, size: frame.size)
        updateLabel()
    }
}
