//
//  CalendarCollectionViewCell.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/29.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // cellの枠の太さ
        self.layer.borderWidth = 0.5
        // cellの枠の色
        self.layer.borderColor = UIColor.systemGray2.cgColor
        // cellを丸くする
        //self.layer.cornerRadius = 3.0
        //
        //self.bounds.width = self.view.bounds.width / 7
    }
}
