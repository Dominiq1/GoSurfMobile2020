
//  SetBusinessHoursViewController.swift
//  GoSurf
//
//  Created by Piyush on 29/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

@available(iOS 13.4, *)
class SetBusinessHoursViewController: UITableViewController, UINavigationControllerDelegate {
    
    
    var days: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var fromTimes: [String] = ["8:00 AM","8:00 AM","8:00 AM","8:00 AM","8:00 AM","8:00 AM","8:00 AM"]
 
     var toTimes: [String] = ["5:00 PM","5:00 PM","5:00 PM","5:00 PM","5:00 PM","5:00 PM","5:00 PM"]

    var toggles: [String] = ["on", "on", "on", "on", "on", "on", "on"]
    
    //hours availible will go in here.
    var mondayAvailibility: [Int: String] = [:]
    var MondayHours: [Int] = [0]
    var MondayMinutes: [Int] = [0]
    var meridiems: [String] = ["Time"]
    var adminid: String?

    let cellID = "TimeCellId"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Set Business Hours"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        tableView.register(BusinessHoursTableViewCell.self, forCellReuseIdentifier: cellID)
        
     
       Settimes(fromtimes: fromTimes, totimes: toTimes)
      
        fetchUser()
       
        setupNavBar()
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleSave))
        
    }
    

   
    
    
    @objc func handleSave() {
        //backend stuff
        sendDatesToDatabse()
        Settimes(fromtimes: fromTimes, totimes: toTimes)
    
    print("Save Pressed")
//---------------------------------------------------------------
        
    
        sendDatesToDatabse()
//----------------------------------------------------------
        
        
    dismiss(animated: true, completion: nil)
        
       //
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.estimatedRowHeight = 72
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    

    

    var userCoordinates: CLLocation!
    
    
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {

        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {

                    let user = User(dictionary: dictionary)
                    if user.latitude != nil {
                    self.userCoordinates = CLLocation(latitude: user.latitude!, longitude: user.longitude!)
                    }
                }
                
                }, withCancel: nil)
        }
    
    func setupNavBar() {

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.4, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(r: 22, g: 128, b: 199)
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }


    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        return 7

    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BusinessHoursTableViewCell
        
        cell.dayLable.text = days[indexPath.row]
        //Cell day Label = "Monday"
       // print(cell.dayLable.text as Any)
        
        cell.timeLable.text = fromTimes[indexPath.row] + " to " + toTimes[indexPath.row]
     
        //Cell Time Label = "8:00 AM to 5:00 PM"
       cell.toggleButton.tag = indexPath.row
        
        cell.toggleButton.addTarget(self, action: #selector(self.SwitchChanged (_:) ), for: .valueChanged)
        
        //check if toggle is on or off
        //initialize toggles to on if they have never been touched
        
        if toggles[indexPath.row] == "on"{
            cell.toggleButton.isOn = true
        }else{
            cell.toggleButton.isOn = false
        }
    
    
      //  print(cell.timeLable.text as Any)
      //  print("\(indexPath.row) is the current row tapped")
        
        return cell
        
        
    }
    
    
    @objc func SwitchChanged(_ sender: UISwitch!){
        print("Table Row switch changed \(sender.tag)")
        print("The Switch is\(sender.isOn ? "on": "Off") ...")
        switch sender.isOn {
        case true:
            toggles[sender.tag] = "on"
        case false:
            toggles[sender.tag] = "Off"
        default:
            print("error checking toggle")
        }
        print("Toggles after it is pressed")
        print(toggles)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 72
//    }  // how to check if toggle is on -> cell.toggleButton.isOn
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = TimePickerViewController()
        viewController.index = indexPath.row
        viewController.fromTime = fromTimes[indexPath.row]
        viewController.toTime = toTimes[indexPath.row]
        viewController.delegate = self
        viewController.delegate2 = self
        
        
        
        let vc = UINavigationController(rootViewController: viewController)
        present(vc, animated: true, completion: nil)
        
        print(indexPath.row)
        
    }
    
   
    
    
    
    func Settimes(fromtimes: [String], totimes:[String]){
        
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
       let userID = Auth.auth().currentUser?.uid
        
       ref.child("adminSchedules").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
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
        self.tableView.reloadData()
        print(self.fromTimes)
        print(self.toTimes)
        print(self.toggles)
        print("database setter is the final init of arrays")
        //---------------------------
         }) { (error) in
           print(error.localizedDescription)
       }
    
        
    }
    
    
    
      func sendDatesToDatabse(){
          
          
                guard let uid = Auth.auth().currentUser?.uid else {
                                          //for some reason uid = nil
                                  return
                                      }
                       
                       
                let ref = Database.database().reference().child("adminSchedules")
                             let childRef = ref.child(uid)
                   
                for i in 0...6{
                        let values = [
                                          "isDayOpen \(i)": toggles[i] as Any,
                                          "fromTime \(i)" : fromTimes[i] as Any,
                                          "toTime \(i)" : toTimes[i] as Any
                                          ]
                       
                       
                           print("Schedule sent to the database")
                           
                          childRef.updateChildValues(values) { (error, ref) in
                          if error != nil {
                              print(error!)
                              return
                          } else {
                              print("No errors and child added")

                              
                           }
                            
                          }
                          
            }
          
      }
    
}

@available(iOS 13.4, *)
extension SetBusinessHoursViewController: SetTimeDelegate {
    
    
    
    func setTime(fromTime: String, toTime: String, index: Int) {
        print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
        print("Set Time Pressed ")
        print("\(fromTime) is from time")
        print("\(toTime) is to time")
        print("\(index) is the current index")
        self.fromTimes[index] = fromTime
        self.toTimes[index] = toTime
        self.tableView.reloadData()
        print("----from times----")
        print(fromTimes)
        print("-----to times-------")
        print(toTimes)
        
        
    }
    


    
    
}






//



