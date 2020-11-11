//
//  TimePickerViewController.swift
//  GoSurf
//
//  Created by Piyush on 29/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//


import Foundation
import UIKit
import Firebase

protocol SetTimeDelegate {
    
    func setTime(fromTime: String, toTime: String, index: Int)
    

}


@available(iOS 13.4, *)
class TimePickerViewController: UIViewController, UINavigationControllerDelegate {
    

    var delegate: SetTimeDelegate?
    //new delegate
    var delegate2: SetTimeDelegate?
    
    var fromTime = "8:00 AM"
    var toTime = "5:00 PM"
    var index: Int?
    
    //-------variables for times----
//----------------------------------
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Create a DatePicker
        var datePicker: UIDatePicker = UIDatePicker()
         view.backgroundColor = .white
         self.title = "Set time"
         datePicker.frame = CGRect(x: 45, y: 200, width: self.view.frame.width, height: 200)
         datePicker.timeZone = NSTimeZone.local
         datePicker.backgroundColor = UIColor.white
         datePicker.datePickerMode = UIDatePicker.Mode.time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minuteInterval = 30
         datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
         self.view.addSubview(datePicker)
        self.view.addSubview(setTimeButton)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(handleCancel))
        
        setTimeButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16).isActive = true
        setTimeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setTimeButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        setTimeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupViews()
         
     }
    
    @objc func handleCancel() {
        print("Back Pressed")
        dismiss(animated: true, completion: nil)
    }
    
    lazy var fromToSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["From", "To"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.backgroundColor = .darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let timeLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.textColor = .darkGray
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lable
    }()
    
    lazy var setTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("SET", for: UIControl.State())
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSetTime), for: .touchUpInside)
        return button
    }()

    
  
    @objc func handleSetTime() {
        //bakcend save to the from times and to times array in swift 
        print("set pressed")
        print(index!)
        let vc = SetBusinessHoursViewController()
        vc.fromTimes[index!] = fromTime
        vc.toTimes[index!] = toTime
        delegate?.setTime(fromTime: fromTime, toTime: toTime, index: index!)
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){

        let dateFormatter: DateFormatter = DateFormatter()

        dateFormatter.dateFormat = "h:mm a"

        let selectedTime: String = dateFormatter.string(from: sender.date)
        
        if fromToSegmentedControl.selectedSegmentIndex == 0 {
            
             fromTime = selectedTime
            
        } else {
            
            toTime = selectedTime
        }
        timeLable.text = "\(fromTime) to \(toTime)"
        
        
        
        print("Selected value \(selectedTime)")
        print(index! as Any)//prints the day in index value for example 0,1,2,3,4,5,6 == mon,tues,wed,thu,fri,sat,sun
        print(fromTime)
        print(toTime)
        
        if fromTime < toTime{
                   print("You are formatted perfectly ")
               }else if fromTime > toTime{
                   print("You are closing before you are opening")
               }else{
                   print("Both times are the same")
               }
         //------------------------------------
       /* print("------------------------------------------------------")
        
       
        print("seconds since 1970")
        print(Date().timeIntervalSince1970)
        print("seconds since now")
        let dateA = Date()
        let dateB = Date.init(timeIntervalSinceNow: (86400 * 5))//seconds multiplied by days
        print(dateA)
        print(dateB)
       let diffInDays = Calendar.current.dateComponents([.day], from: dateA, to: dateB).day
        print(diffInDays!)
        
        let dateFormat = DateFormatter()

        dateFormat.dateStyle = .medium

        dateFormat.timeStyle = .none

        let dateString = dateFormat.string(from: dateA)
        print(dateString)
       
        
        if fromTime < toTime{
            print("You are formatted perfectly ")
        }else if fromTime > toTime{
            print("You are closing before you are opening")
        }else{
            print("Both times are the same")
        }
        */
        //-------------------------
    }
    
    func setupViews() {
        
        view.addSubview(fromToSegmentedControl)
        view.addSubview(timeLable)
        
        fromToSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        fromToSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        fromToSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        timeLable.topAnchor.constraint(equalTo: fromToSegmentedControl.bottomAnchor, constant: 32).isActive = true
        timeLable.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        timeLable.text = "\(fromTime) to \(toTime)"

        
    }
    
    
    func loadHours(){
    
        
          if index == 0 {
               let vc = SetBusinessHoursViewController()
                   vc.fromTimes.insert(fromTime, at: 0)
                   
               
                   print("------fromtimes----")
                   print(vc.fromTimes)
                   vc.toTimes.insert(toTime, at: 0)
                   print("---to Times------")
                   print(vc.toTimes)
                   
               }else if index == 1 {
                   print("Set Tuesday schedule")
                   let vc = SetBusinessHoursViewController()
                   vc.fromTimes.insert(fromTime, at: 1)
                   print("------fromtimes----")
                   print(vc.fromTimes)
                   vc.toTimes.insert(toTime, at: 1)
                   print("---to Times------")
                   print(vc.toTimes)
                   
               }else if index == 2 {
                   print("Set Wednesday schedule")
                   let vc = SetBusinessHoursViewController()
                   vc.fromTimes.insert(fromTime, at: 2)
                   print("------fromtimes----")
                   print(vc.fromTimes)
                   vc.toTimes.insert(toTime, at: 2)
                   print("---to Times------")
                   print(vc.toTimes)
                   
               }else if index == 3 {
                   print("Set Thursday schedule")
                   let vc = SetBusinessHoursViewController()
                   vc.fromTimes.insert(fromTime, at: 3)
                   print("------fromtimes----")
                   print(vc.fromTimes)
                   vc.toTimes.insert(toTime, at: 3)
                   print("---to Times------")
                   print(vc.toTimes)
                   
               }else if index == 4 {
                   print("Set Friday schedule")
                   let vc = SetBusinessHoursViewController()
                   vc.fromTimes.insert(fromTime, at: 4)
                   print("------fromtimes----")
                   print(vc.fromTimes)
                   vc.toTimes.insert(toTime, at: 4)
                   print("---to Times------")
                   print(vc.toTimes)
                   
               }else if index == 5 {
                   print("Set Saturday schedule")
                   let vc = SetBusinessHoursViewController()
                   vc.fromTimes.insert(fromTime, at: 5)
                   print("------fromtimes----")
                   print(vc.fromTimes)
                   vc.toTimes.insert(toTime, at: 5)
                   print("---to Times------")
                   print(vc.toTimes)
                   
               }else if index == 6 {
                   print("Set Sunday schedule")
                   let vc = SetBusinessHoursViewController()
                   vc.fromTimes.insert(fromTime, at: 6)
                   print("------fromtimes----")
                   print(vc.fromTimes)
                   vc.toTimes.insert(toTime, at: 6)
                   print("---to Times------")
                   print(vc.toTimes)
                   
               }
        
        
        
    }
    

       
    
}



