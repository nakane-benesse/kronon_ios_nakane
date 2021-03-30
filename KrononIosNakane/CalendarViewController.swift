//
//  CalendarViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/16.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var calendar = Calendar.current
    var currentDate = Date()
    var numberOfItems: Int!
    var daysPerWeek: Int = 7
    var numberOfWeeks:Int = 6
    
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    
    
    var dates : [Date] = []//[Int] = [1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7]
    var schedules : [String] = []//["予定1111１","予定２","","予定４", "", "", "","予定１","予定２","","予定４", "", "", "","予定１","予定２","","予定４", "", "", "","予定１","予定２","","予定４", "", "", "","予定１","予定２","","予定４", "", "", ""]
    
    let SATURDAY_COLOR = UIColor(red: 242/255, green: 246/255, blue: 253/255, alpha: 1.0)
    let SUNDAY_COLOR = UIColor(red: 253/255, green: 237/255, blue: 239/255, alpha: 1.0)
    
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBAction func leftButtonAction(_ sender: Any) {
        
        let add = DateComponents(month: -1)
        currentDate = calendar.date(byAdding: add, to: currentDate)!
        setDate(date: currentDate)
        setSchedule()
        calendarCollectionView.reloadData()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        let add = DateComponents(month: 1)
        currentDate = calendar.date(byAdding: add, to: currentDate)!
        setDate(date: currentDate)
        setSchedule()
        calendarCollectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calendarCollectionView.dataSource = self
        //calendarCollectionView.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCollectionViewCell")
        let date = Date()
        setDate(date:date)
        setSchedule()
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
        // タップされたときのaction
        button.addTarget(self, action: #selector(createScheduleButtonTapped(_:)), for: .touchUpInside)
        
        let searchBarButtonItem = UIBarButtonItem(customView: button)
        self.parent?.navigationItem.rightBarButtonItem = searchBarButtonItem
        //ボタンの色
        self.navigationController?.navigationBar.tintColor =  UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1.0)
    }
    
    @objc func createScheduleButtonTapped(_ sender : Any) {
        self.performSegue(withIdentifier: "goCreateScheduleView", sender: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let cell:CalendarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for :indexPath) as! CalendarCollectionViewCell
        
        // Tag番号を使ってLabelのインスタンス生成
        //        let label = cell.contentView.viewWithTag(1) as! UILabel
        //        label.text = "aaa"//schedules[indexPath.item]
        // cellのlabelに色付け
        cell.dateLabel.text = String(calendar.component(.day, from: dates[indexPath.item]))
        // cellのnameに色の名前を入れる
        cell.scheduleLabel.text = schedules[indexPath.item]
        
        switch indexPath.item % 7{
        case 0:
            cell.backgroundColor = SUNDAY_COLOR
        case 6:
            cell.backgroundColor = SATURDAY_COLOR
        default:
            cell.backgroundColor = UIColor.white
        }
        
        
        let month = calendar.component(.month, from: dates[indexPath.item])
        let currentMonth = calendar.component(.month, from: currentDate)
        if(month != currentMonth){
            cell.dateLabel.textColor = UIColor.lightGray
        }else{
            cell.dateLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横方向のスペース調整
        //let horizontalSpace:CGFloat = 4
        let cellWidth:CGFloat = (calendarCollectionView.bounds.width-1)/7 //- horizontalSpace
        let cellHeight:CGFloat = (calendarCollectionView.bounds.height-1)/CGFloat(numberOfWeeks)//- horizontalSpace
        
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return dates.count;
    }
    
    // セルの行間の設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    private func setDate(date:Date){
        
        //クリア
        dates = []
        
        //年月
        yearLabel.text = String(calendar.component(.year, from: date))
        monthLabel.text = String(calendar.component(.month, from: date))+"月"
        
        //let date = Date()
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        //let weekday = calendar.component(.weekday, from: date)
        // 月初
        let comps = calendar.dateComponents([.year, .month], from: date)
        let firstday = calendar.date(from: comps)
        let firstdayWeekday = calendar.component(.weekday, from: firstday!)//日曜日が1,月曜日が2
        print(firstdayWeekday)
        var counter = firstdayWeekday
        //前月
        while counter > 1 {
            let add = DateComponents(day: -1*(counter-1))
            let date = calendar.date(byAdding: add, to: firstday!)
            dates.append(date!)
            counter -= 1
        }
        
        //月末
        let add = DateComponents(month:1, day: -1)
        let lastday = calendar.date(byAdding: add, to: firstday!)
        let lastdayDay = calendar.component(.day, from: lastday!)
        let lastdayWeekday = calendar.component(.weekday, from: lastday!)
        
        counter = 0
        while counter < lastdayDay {
            let add = DateComponents(day: counter)
            let date = calendar.date(byAdding: add, to: firstday!)
            dates.append(date!)
            counter += 1
        }
        
        counter = 1
        while counter+lastdayWeekday <= 7 {
            let add = DateComponents(day: counter)
            let date = calendar.date(byAdding: add, to: lastday!)
            dates.append(date!)
            counter += 1
        }
        // 週の数 (日曜始まり)
        numberOfWeeks = calendar.range(of: .weekOfMonth, in: .month, for: date)?.count ?? 6 // 5
    }
    
    private func setSchedule(){
        //クリア
        schedules = []
        
        var counter = 0
        while counter < numberOfWeeks * 7 {
            schedules.append("予定")
            counter += 1
            
        }
    }
    
    
    
}



