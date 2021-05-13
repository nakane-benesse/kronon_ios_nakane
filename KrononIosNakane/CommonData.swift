//
//  CommonData.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/31.
//

import Foundation

class CommonData{
    
    static let IP_ADDRESS = "http://13.230.179.27/"
    static let DISPLAY_DATE_FORMAT = "yyyy年MM月dd日"
    static let API_DATE_FORMAT = "yyyy-MM-dd"

    static let placeDictionary = ["オフィス": 0, "在宅": 1, "外出": 2 ]
    
    static func changeDateFormat(date:String)->String{
        //日付形式の変換
        let displayFormatter: DateFormatter = DateFormatter()
        displayFormatter.calendar = Calendar(identifier: .gregorian)
        displayFormatter.dateFormat = CommonData.DISPLAY_DATE_FORMAT
        
        let apiFormatter: DateFormatter = DateFormatter()
        apiFormatter.calendar = Calendar(identifier: .gregorian)
        apiFormatter.dateFormat = CommonData.API_DATE_FORMAT
        
        return apiFormatter.string(from: displayFormatter.date(from: date)!)
    }
}
