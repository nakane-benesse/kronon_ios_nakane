//
//  CalendarViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/16.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController , FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance{
    
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
        calendarSetUp()

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
    
    
    @IBOutlet weak var calendar: FSCalendar!
    
    private func calendarSetUp(){
        // calendarの色の設定
        calendar.appearance.todayColor = UIColor.red
        calendar.appearance.headerTitleColor = UIColor.darkGray
        
        //曜日を日本語に
        self.calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        self.calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        self.calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        self.calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        self.calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        self.calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        self.calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        
        //色を変える
        self.calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        self.calendar.calendarWeekdayView.weekdayLabels[1].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[2].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[3].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[4].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[5].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor.blue
        
        

        //特定の日付を選択したいが使い方がわからず
        //let calPosition = Calendar.current
        //ここの日付の指定はInt型
        //let selectDay = calPosition.date(from: DateComponents(year: 2021, month: 3, day: 5))
        //let cell = calendar.select(selectDay)

        
    }
    
    //FSCalendar公式サンプルより
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var datesWithEvent = ["2021-03-03", "2021-03-06"]
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {

            let labelMy2 = UILabel(frame: CGRect(x: 10, y: 20, width: cell.bounds.width, height: 20))
            labelMy2.font = UIFont(name: "Henderson BCG Sans", size: 10)
            labelMy2.text = "abc"
            labelMy2.layer.cornerRadius = cell.bounds.width/2
            labelMy2.textColor = UIColor.red
            cell.addSubview(labelMy2)

    }
    
//    override func loadView() {
//        let view = UIView(frame: UIScreen.main.bounds)
//        //view.backgroundColor = UIColor.groupTableViewBackground
//        self.view = view
//
//        //let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 450 : 300
//        //let calendar = FSCalendar(frame: CGRect(x:0, y:64, width:self.view.bounds.size.width, height:height))
//        calendar.dataSource = self
//        calendar.delegate = self
//        calendar.allowsMultipleSelection = true
//        calendar.swipeToChooseGesture.isEnabled = true
//        calendar.backgroundColor = UIColor.white
//        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
//        self.view.addSubview(calendar)
//        //self.calendar = calendar
//        //calendar.select(self.dateFormatter1.date(from: "2015/10/03"))
//        //let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
//        //self.navigationItem.rightBarButtonItem = todayItem
//
//        // For UITest
//        //self.calendar.accessibilityIdentifier = "calendar"
//    }
    
    
}
