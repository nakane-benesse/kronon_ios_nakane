//
//  ScheduleViewController.swift
//  KrononIosNakane
//
//  Created by 中根悠 on 2021/03/16.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    
    @IBOutlet weak var blackboardView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let step_y = 20;
    private let offset_top_border = 20
    private let offset_top_time = 5
    private let offset_left_border = 40
    private let offset_left_time = 10
    private let offset_right = 15
    
    let member_num = 3
    let margin_x = 10
    
    let OFFICE_COLOR = UIColor(red: 255/255, green: 216/255, blue: 214/255, alpha: 1.0)
    let HOME_COLOR = UIColor(red: 255/255, green: 240/255, blue: 141/255, alpha: 1.0)
    let AWAY_COLOR = UIColor(red: 225/255, green: 251/255, blue: 255/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.parent?.navigationItem.title = "予定表"
        self.navigationController?.navigationBar.isTranslucent = false
        self.parent?.navigationItem.hidesBackButton = true
        
        
        super.viewWillAppear(animated)
        
        print("schedule willappear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createButtonAdd()
        //時間の追加
        timeAdd(parentView: scrollView)
        //線の追加
        borderAdd(parentView: scrollView)
        //スケジュールの追加
        scheduleAdd(parentView: scrollView)
        
        print("schedule didappear")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
        super.viewWillDisappear(animated)
        
        print("schedule willdisappear")
    }
    
    
//    private func scrollViewSizeSet(){
//        scrollView.contentSize.height = CGFloat(step_y*4*12+offset_top_border*2)
//        //scrollView.frame.size = CGSize(width:scrollView.frame.maxX, height:step_y*4*12+offset_top_border*2)
//        //scrollView.frame.maxX = blackboardView.frame.maxX
//    }
    
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
    
    private func timeAdd(parentView : UIView){
    
        
        for i in 0..<13 {
            let label = UILabel()
            label.frame = CGRect(x: offset_left_time, y: offset_top_time+i*step_y*4, width: 200, height: 30)
            label.text = String(i+8)+":00"
            label.textColor = .white
            label.font = label.font.withSize(8)
            //  文字位置を Center にする
            label.textAlignment = NSTextAlignment.left
            // 表示する
            parentView.addSubview(label)

        }

    }
    
    private func borderAdd(parentView : UIView){
        
        let parent_x = Int(parentView.frame.maxX)//384
        
        for i in 0..<13 {
            
            let borderView = UIView.init(frame: CGRect.init(x: Double(offset_left_border), y: Double(offset_top_border+i*step_y*4), width: Double(parent_x - offset_left_border-offset_right), height: 0.5))
            borderView.borderWidth = 0.25
            borderView.borderColor = .white
            parentView.addSubview(borderView)
            
            
        }

    }
    
    private func scheduleAdd(parentView : UIView){
        
        //let parent_x = Int(parentView.frame.maxX)//384
        let parent_width = Int(parentView.frame.maxX) - Int(parentView.frame.minX)
        let step_x = (parent_width-margin_x*(member_num+1)-offset_left_border) / member_num //101

        //swiftではタプルというらしい
        let schedule_array = [
            (start:8*60, end:9*60, place:OFFICE_COLOR, title:"iOS頑張る", member:0),
            (start:9*60+30, end:12*60, place:OFFICE_COLOR, title:"iOS頑張る", member:0),
            (start:10*60, end:11*60+45, place:AWAY_COLOR, title:"会議", member:1),
            (start:9*60, end:16*60, place:HOME_COLOR, title:"OTA確認", member:2)
        ]
        
        for schedule in schedule_array{
            
            let label = UILabel()
            label.frame = CGRect.init(
                x: offset_left_border+margin_x*(schedule.member+1)+step_x*schedule.member,
                y: offset_top_border+step_y*(schedule.start-8*60)/15,
                width: step_x,
                height: step_y*(schedule.end - schedule.start)/15)
            label.text = schedule.title
            label.textColor = .darkGray
            label.font = label.font.withSize(10)
            label.backgroundColor = schedule.place
            //  文字位置を Center にする
            label.textAlignment = NSTextAlignment.center
            // 表示する
            parentView.addSubview(label)
            
            
        }
        

    }
    
}
