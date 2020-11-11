//
//  SelectSessionViewController.swift
//  GoSurf
//
//  Created by Piyush on 28/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//


import Foundation
import Firebase
import UIKit
import PassKit

class SelectSessionViewController: UIViewController {

    var numOfRiders: String = ""
    var lessonLength: String = ""
    var numOfBoards: String = ""
    var numOfWetSuits: String = ""
    var experience: String = ""
    var beach: String = ""
    var provider: String = ""
    var adminType: String = ""
    var adminsName: String = ""
    var adminID: String = ""
    var userIS: String = ""
    var fromTimes: [String] = ["8:00 AM","8:00 AM","8:00 AM","8:00 AM","8:00 AM","8:00 AM","8:00 AM"]
    
    var toTimes: [String] = ["5:00 PM","5:00 PM","5:00 PM","5:00 PM","5:00 PM","5:00 PM","5:00 PM"]

    var toggles: [String] = ["on", "on", "on", "on", "on", "on", "on"]
  
    var Availibletimes: [String] = ["0", "0", "0","0", "0", "0","0"]
    
    var liveDates: [String] = ["0","0","0","0","0","0","0"]
    
    var dateComponents: [Date] = []
    
  //  var CurrentDates: [NSDate] =
    
    //---for sending to the database
    var date: String = ""
    var TimeOfEvent: String = ""
    var priice: String = ""
    
    
    //var days : [String] = ["M", "W", "T" "Sun"]
    
    
  
    
    override func viewDidLoad() {
        
        
        
        loadliveDates()
        print("the live dates list after loading is \(liveDates)")
        super.viewDidLoad()
        Settimes()
        print(fromTimes,toTimes,toggles)
        DatesHorizontalCollectionView.dataSource = self
        DatesHorizontalCollectionView.delegate = self
        TimeHorizontalCollectionView.dataSource = self
        TimeHorizontalCollectionView.delegate = self
        
        view.backgroundColor = .white
        self.title = "Select Session"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupViews()
    }
    
    


    
    fileprivate let DatesHorizontalCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ToggleButtonCollectinViewCell.self, forCellWithReuseIdentifier: "verticalCell" )
        cv.backgroundColor = UIColor(white: 1, alpha: 1)
        cv.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        cv.showsVerticalScrollIndicator = false
        return cv
        
    }()
    
    
    fileprivate let TimeHorizontalCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ToggleButtonCollectinViewCell.self, forCellWithReuseIdentifier: "verticalCell" )
        cv.backgroundColor = UIColor(white: 1, alpha: 1)
        cv.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        cv.showsVerticalScrollIndicator = false
        return cv
        
    }()
    
    let dateTitleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Select Date"
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let timeTitleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Select Time slot"
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var bookSessionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("Book Session", for: UIControl.State())
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleBookSession), for: .touchUpInside)
        
        return button
    }()
    
   
    
    func setupViews() {
        
        view.addSubview(DatesHorizontalCollectionView)
        view.addSubview(TimeHorizontalCollectionView)
        view.addSubview(dateTitleLable)
        view.addSubview(timeTitleLable)
        view.addSubview(bookSessionButton)
        
        
        dateTitleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        dateTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dateTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        DatesHorizontalCollectionView.topAnchor.constraint(equalTo: dateTitleLable.bottomAnchor, constant: 0).isActive = true
        DatesHorizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        DatesHorizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        DatesHorizontalCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        timeTitleLable.topAnchor.constraint(equalTo: DatesHorizontalCollectionView.bottomAnchor, constant: 16).isActive = true
        timeTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        timeTitleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        TimeHorizontalCollectionView.topAnchor.constraint(equalTo: timeTitleLable.bottomAnchor, constant: 0).isActive = true
        TimeHorizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        TimeHorizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        TimeHorizontalCollectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        bookSessionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookSessionButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        bookSessionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bookSessionButton.topAnchor.constraint(equalTo: TimeHorizontalCollectionView.bottomAnchor, constant: 32).isActive =  true
        
    }
    
    @objc func handleBookSession() {
        
        
        
        
        
        PhotogOrVideogDatabaseSend()
        //make payment------------------------------------------
        paymentrequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Photographer Session", amount: 100)]
        let controller = PKPaymentAuthorizationViewController(paymentRequest:  paymentrequest)
        
        if controller !=   nil{
            controller!.delegate = self
            present(controller!, animated: true, completion: nil)
        }
        
      //  let vc = Payments()

      //  present(vc, animated: true, completion: nil)
    //-----------------------------------------------------
      //  dismiss(animated: true, completion: nil)
      
         
    }
    
    
    
    private var paymentrequest: PKPaymentRequest = {
           let request = PKPaymentRequest()
           request.merchantIdentifier = "merchant.gosurf.com"
           request.supportedNetworks = [.masterCard, .visa, .discover,.vPay, .privateLabel, .quicPay]
           request.supportedCountries = ["US"]
           request.merchantCapabilities = .capability3DS
           request.countryCode = "US"
           request.currencyCode = "USD"
          // request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Photography Session", amount: 55.00)]
           return request
       
       
   }()
 
 
    
    func loadliveDates(){
        var date = Date()
        print("\(date) is the current date \n\n\n\n\n\n\n\n")
    
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
             dateFormatter.timeStyle = .none
             dateFormatter.locale = Locale(identifier: "en_US")
            var dayComponent    = DateComponents()
        let theCalendar     = Calendar.current
        dayComponent.day    = 1 // For removing one day (yesterday): -1
        // just load the current date to live dates by incrementing seconds to the inital date which has already beed added
    
        for i in 0...6{
            var currentDate = dateFormatter.string(from: date)
            liveDates[i] = currentDate
            var backToDate = dateFormatter.date(from: currentDate)
            dateComponents.append(backToDate!)
            date  = theCalendar.date(byAdding: dayComponent, to: backToDate!)!
    
        }
        
        print("\(liveDates)\n\n\n\n\n\n\n\n\n")
    }
    
}

extension SelectSessionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            if collectionView == DatesHorizontalCollectionView {
                
                return CGSize(width: 160, height: 100)
    
                
            } else {
    
                return CGSize(width: 160, height: 50)
                 }
                
            }
            
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == DatesHorizontalCollectionView {
            //return th eamount of days avilible with their desired date.
            
            //returns the amount of slots in the horizontal date picker
            
            //print("\(loadSlots(toggles: toggles)) is the number of loaded toggles being loaded")
            
             return loadSlots(toggles: toggles)
            
            
        } else {
            return Availibletimes.count
        }
           
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // do something
    }
    
//sets all the cells in the date selector
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       //["July 28"]
        var times : [String] = self.Availibletimes
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalCell", for: indexPath) as! ToggleButtonCollectinViewCell
        
        if collectionView == DatesHorizontalCollectionView {
            
         cell.button.tag = indexPath.row
         cell.button.addTarget(self, action: #selector(self.updateTimes(_:)), for: .allEvents)
         //----------leaving off on trying to get the cells who are not tapped to -------------------
            
            if indexPath.row == 0{
                cell.button.setTitle(liveDates[0], for: .normal)
                print("Idex Path row is 0")
                
            }else if indexPath.row == 1{
                
                cell.button.setTitle(liveDates[1], for: .normal)
                print("indexPath.row is 1")
            }else if indexPath.row == 2{
                
                cell.button.setTitle(liveDates[2], for: .normal)
                print("indexPath.row is 1")
            }
            else if indexPath.row == 3{
                
                cell.button.setTitle(liveDates[3], for: .normal)
                print("indexPath.row is 1")
            }
            else if indexPath.row == 4{
                
                cell.button.setTitle(liveDates[4], for: .normal)
                print("indexPath.row is 1")
            }
            else if indexPath.row == 5{
                
                cell.button.setTitle(liveDates[5], for: .normal)
                print("indexPath.row is 1")
            }
            else if indexPath.row == 6{
                
                cell.button.setTitle(liveDates[6], for: .normal)
                print("indexPath.row is 1")
            }
        
        
            
            
            
            //time cell collectionview
            
        } else if collectionView == TimeHorizontalCollectionView {
            
            cell.button.setTitle(times[0], for: .normal)
            
        
            

            print("Cell Button title Initialized")
           // cell.button.setTitle("20:00 am", for: .normal)
            cell.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }else
        {
            
        }

        return cell
        
    }
    
    @objc func updateTimes(_ sender: ToggleButton!){
        
        print("\(Availibletimes) Are the availible times")
        
        switch sender.tag {
        case 0:
       // Availibletimes = ["2:00 AM", "11:00 AM"]
            
            print("the availible times are \(Availibletimes)")
        case 1:
            Availibletimes = ["5:00 AM", "11:00 AM", "12:00 AM"]
                print("the availible times are \(Availibletimes)")
        case 2:
            print("present Wednesday Times")
            Availibletimes = ["1:00 AM", "2:00 AM", "3:00 AM"]
           
                print("the availible times are \(Availibletimes)")
        case 3:
            print("present Thursday Times")
            Availibletimes = ["10:00 AM", "11:00 AM", "12:00 AM"]
            print("the availible times are \(Availibletimes)")
        case 4:
            print("present Friday Times")
            Availibletimes = ["10:00 AM", "11:00 AM", "12:00 AM"]
            print("the availible times are \(Availibletimes)")
        case 5:
            print("present Saturday Times")
            Availibletimes = ["10:00 AM", "11:00 AM", "12:00 AM"]
        case 6:
            print("present Sunday Times")
            Availibletimes = ["9:00 AM", "10:00 AM", "11:00 AM"]
        default:
            print("Sender never caught")
        }
        print("\(sender.tag) is the senders tag")
        TimeHorizontalCollectionView.reloadData()
    }
    

     
    
  
    
    func PhotogOrVideogDatabaseSend () {
     //use this link to understnd how to work with dates.
    //http://ios-tutorial.com/working-dates-swift/
        
                guard let uid = Auth.auth().currentUser?.uid else {
                                       //for some reason uid = nil
                               return
                                   }
        //-------------------------
        
        let dateFormatter = DateFormatter()
             dateFormatter.dateStyle = .full
             dateFormatter.timeStyle = .none
         let seconds = Date().timeIntervalSince1970
             let date = Date(timeIntervalSince1970: seconds)
             dateFormatter.locale = Locale(identifier: "en_US")
           let fullDate = dateFormatter.string(from: date)
        //prints current date

        //--------------------------
                    
                      let ref = Database.database().reference().child("Admins-needsToApprove")
                let childRef = ref.child(adminID).child(uid)
        
        
         print("\(adminsName) IS THE ADMINISTRATORS NAME SO IT SHOULD BE SAVED INTHE THE USER APPOINTMENTS")
        
        
                      let values = [    "Number of riders" : numOfRiders as Any,
                                        "TimeofEvent" : TimeOfEvent as Any,
                                        "InShoreOrInWater" : numOfBoards as Any,
                                        //"Price per Board" :  as Any,
                                        "PhotosEditedOrRaw" : numOfWetSuits as Any,
                                        "Location" : beach as Any,
                                        //add administrator providing service below
                                        "Service Provider" : provider as Any,
                                        "adminID" : adminID as Any,
                                        "Time Stamp": fullDate,
                                        "Date" :  "Some Date PLaceholder",
                                        "LessonLength": lessonLength as Any,
                                        "LessonTime":  "12:00 - 1:00"
                      ]
        
        
        
        print("lessons set")
    
                childRef.updateChildValues(values) { (error, ref) in
                       if error != nil {
                           print(error!)
                           return
                       } else {
                           print("No errors and child added")

                           
                        }
                       
                    }
     }
    
    func loadSlots(toggles: [String]) -> Int{
        var n = 7
        for i in 0...6{
            if toggles[i] == "Off"{
                n -= 0
            }
        }
        return n
    }
    
    // Left off here
    
    func initTimesOfDay(indexPathRow : Int){
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
             dateFormatter.locale = Locale(identifier: "en_US")
            var dayComponent    = DateComponents()
        let theCalendar     = Calendar.current
        dayComponent.hour    = 1 // For removing one day (yesterday): -1
        // just load the current date to live dates by incrementing seconds to the inital date which has already beed added
        
        let currentDay = dateComponents[indexPathRow]
        var currentDayString = dateFormatter.string(from: currentDay)
        var SelectedDate = dateFormatter.date(from:currentDayString)!
        //-------------now have a date in its components form-----------------------------
        self.Availibletimes = []
        
        var date = Calendar.current.date(bySettingHour: 8, minute: 30, second: 0, of: SelectedDate)!
        
        for i in 0...6{
            var stringcurrentDate = dateFormatter.string(from: date)
            Availibletimes[i] = stringcurrentDate
            var backToDate = dateFormatter.date(from: stringcurrentDate)
            date = theCalendar.date(byAdding: dayComponent, to: backToDate!)!
    
        }
        
        
    }
    
    
    
    
    
    func Settimes(){
         
         var ref: DatabaseReference!

         ref = Database.database().reference()
         
        let userID = Auth.auth().currentUser?.uid
         
        ref.child("adminSchedules").child(adminID).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let MondayAva = value?["isDayOpen 0"] as? String ?? ""
         let TuesdayAva = value?["isDayOpen 1"] as? String ?? ""
         let WednesdayAva = value?["isDayOpen 2"] as? String ?? ""
         let ThursdayAva = value?["isDayOpen 3"] as? String ?? ""
         let FridayAva = value?["isDayOpen 4"] as? String ?? ""
         let SaturdayAva = value?["isDayOpen 5"] as? String ?? ""
         let SundayAva = value?["isDayOpen 6"] as? String ?? ""
         let FromTime0 = value?["fromTime 0"] as? String ?? ""
         let FromTime1 = value?["fromTime 1"] as? String ?? ""
         let FromTime2 = value?["fromTime 2"] as? String ?? ""
         let FromTime3 = value?["fromTime 3"] as? String ?? ""
         let FromTime4 = value?["fromTime 4"] as? String ?? ""
         let FromTime5 = value?["fromTime 5"] as? String ?? ""
         let FromTime6 = value?["fromTime 6"] as? String ?? ""
         let ToTime0 = value?["toTime 0"] as? String ?? ""
         let ToTime1 = value?["toTime 1"] as? String ?? ""
         let ToTime2 = value?["toTime 2"] as? String ?? ""
         let ToTime3 = value?["toTime 3"] as? String ?? ""
         let ToTime4 = value?["toTime 4"] as? String ?? ""
         let ToTime5 = value?["toTime 5"] as? String ?? ""
         let ToTime6 = value?["toTime 6"] as? String ?? ""
         
          // ...
         print("\(FromTime6) is what comes back from the database as FromTime 6")
     
         self.fromTimes[0] = FromTime0
         self.fromTimes[1] = FromTime1
         self.fromTimes[2] = FromTime2
         self.fromTimes[3] = FromTime3
         self.fromTimes[4] = FromTime4
         self.fromTimes[5] = FromTime5
         self.fromTimes[6] = FromTime6
         self.toTimes[0] = ToTime0
         self.toTimes[1] = ToTime1
         self.toTimes[2] = ToTime2
         self.toTimes[3] = ToTime3
         self.toTimes[4] = ToTime4
         self.toTimes[5] = ToTime5
         self.toTimes[6] = ToTime6
         self.toggles[0] = MondayAva
         self.toggles[1] = TuesdayAva
         self.toggles[2] = WednesdayAva
         self.toggles[3] = ThursdayAva
         self.toggles[4] = FridayAva
         self.toggles[5] = SaturdayAva
         self.toggles[6] = SundayAva
         
         
         print(self.fromTimes)
         print(self.fromTimes[0])
         print(self.fromTimes)
         print(self.toTimes)
         print(self.toggles)
        //self.reloadInputViews()
         print(self.fromTimes)
         print(self.toTimes)
         print(self.toggles)
         print("database setter is the final init of arrays")
         //---------------------------
          }) { (error) in
            print(error.localizedDescription)
        }
     
         
     }
    
}
//create fuinction to create array.
//cell.button.titlelabel = array[indexpath.row]
//indexpath.row = the current index of the cell


//check if button is on or off in time picekr

//cell.button.isOn


extension SelectSessionViewController: PKPaymentAuthorizationViewControllerDelegate{
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    @objc func buttonClicker(sender : UIButton){
        
    }
    
    
    
    
}





