//
//  BookPhotographerViewController.swift
//  GoSurf
//
//  Created by Dominiq Martinez on 8/29/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//


import Foundation
import UIKit
import Firebase


class BookPhotographerViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
   

   var ref: DatabaseReference!
      var user: User? {
          didSet {

              
              if user?.type == "User" {
            
                  navigationItem.title = (user?.name)!
                                
              } else {
               
              }
              
        
          }
      }

    
    var businessType = ["Camp","Coach","Instructor","Photographer","Videographer"]
    var numberOfRides = ["1", "2", "3", "4", "5"]
    var maxLessonLength = ["1 hour","2 hours","3 hours","4 hours"]
    var inWaterOrShoreOptions = ["In Water", "On Shore"]
    var editedOrNotOptions = ["I Would like my photos edited", "I would like my photos raw"]
    var experienceLevels = ["Beginner", "Intermediate", "Expert"]
    var beachesLish = ["-----Admin's Availible Locations-----"]
    
    //these are the id of admin and user
    var userid: String?
    var adminid: String?
    var adminType: String?
     var adminsName: String?
    
    //event strucct
    
    struct event{
        var numOfRiders: String
        var lessonLength: String
        var inShoreOrInWater: String
        var EditedOrRaw: String
        var ExperienceLevel: String
        var location: String
        var admin: String
    }
    
    //------------additional Charges----------
        
    var inWaterCosts : String?
    var EditingCost: String?

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == numberOfRidesPicker {
            return numberOfRides.count
            
        } else if pickerView == lessonLenghtPicker {
            return maxLessonLength.count
            
        } else if pickerView == inWaterOrShorePicker {
            return inWaterOrShoreOptions.count
            
        } else if pickerView == editedOrNotPicker {
            return editedOrNotOptions.count
            
        } else if pickerView == experienceLevelPicker {
            return experienceLevels.count
            
        } else if pickerView == beachPicker {
            return beachesLish.count
            
        } else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == numberOfRidesPicker {
            return numberOfRides[row]
            
        } else if pickerView == lessonLenghtPicker {
            return maxLessonLength[row]
            
        } else if pickerView == inWaterOrShorePicker {
            return inWaterOrShoreOptions[row]
            
        } else if pickerView == editedOrNotPicker {
            return editedOrNotOptions[row]
            
        } else if pickerView == experienceLevelPicker {
            return experienceLevels[row]
            
        } else if pickerView == beachPicker {
            return beachesLish[row]
                   
        } else {
            return nil
        }


    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == numberOfRidesPicker {
            oneNumberOfRidesTextField.text = numberOfRides[row]
            
        } else if pickerView == lessonLenghtPicker {
            twoLessonLengthTextField.text = maxLessonLength[row]
            
        } else if pickerView == inWaterOrShorePicker {
            threeNumberOfBoardsTextField.text = inWaterOrShoreOptions[row]
            
        } else if pickerView == editedOrNotPicker {
            fourNumberOfWetsuitsTextField.text = editedOrNotOptions[row]
            
        } else if pickerView == experienceLevelPicker {
            fiveExperienceTextField.text = experienceLevels[row]
                   
        } else if pickerView == beachPicker {
            sixSelectBeachTextField.text = beachesLish[row]
                   
        }
        
        self.view.endEditing(false)
    }
    
    var numberOfRidesPicker = UIPickerView()
    var lessonLenghtPicker = UIPickerView()
    var inWaterOrShorePicker = UIPickerView()
    var editedOrNotPicker = UIPickerView()
    var experienceLevelPicker = UIPickerView()
    var beachPicker = UIPickerView()
    
    func setupPickerViews()  {
        
        numberOfRidesPicker.dataSource = self
        inWaterOrShorePicker.dataSource = self
        editedOrNotPicker.dataSource = self
        lessonLenghtPicker.dataSource = self
        experienceLevelPicker.dataSource = self
        beachPicker.dataSource = self
        
        numberOfRidesPicker.delegate = self
        inWaterOrShorePicker.delegate = self
        editedOrNotPicker.delegate = self
        lessonLenghtPicker.delegate = self
        experienceLevelPicker.delegate = self
        beachPicker.delegate = self
        
        oneNumberOfRidesTextField.inputView = numberOfRidesPicker
        twoLessonLengthTextField.inputView = lessonLenghtPicker
        threeNumberOfBoardsTextField.inputView = inWaterOrShorePicker
        fourNumberOfWetsuitsTextField.inputView = editedOrNotPicker
        fiveExperienceTextField.inputView = experienceLevelPicker
        sixSelectBeachTextField.inputView = beachPicker
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
        
    }

    
    lazy var cVS = CGSize(width: self.view.frame.width, height: 630)

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.contentSize = cVS
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = cVS
        return view
        
    }()
    
    let oneNumberOfRidesLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "How many riders ?"
        return lable
    }()
    
    let oneNumberOfRidesTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
       tf.font = UIFont.init(name: "Comfortaa-Medium" , size: 18)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    let twoLessonLengthLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "How long ?"
        return lable
    }()
    
    let twoLessonLengthTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.init(name: "Comfortaa-Medium" , size: 18)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    let threeNumberOfBoardsLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "Do you need me on shore or in the water?"
        return lable
    }()
    

    
    let threeSubLable: UILabel = {
        
 
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Medium" , size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.textColor = .gray
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text =  "+20/ hour for in water shoots"
        return lable

    }()
    
    let threeNumberOfBoardsTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.init(name: "Comfortaa-Med" , size: 18)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    let fourNumberOfWetsuitsLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "Do you need your photos edited"
        return lable
    }()
    
    let fourSubLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Medium" , size: 18)
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "+$20 per edited photo"
        return lable

    }()
    
    let fourNumberOfWetsuitsTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.init(name: "Comfortaa-Medium" , size: 18)
        //tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = .lightGray
        return tf
    }()

    let fiveExperienceLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "How experienced are you ?"
        return lable
    }()
    
    let fiveExperienceTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    let sixSelectBeachLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "Which beach ?"
        return lable
    }()
    
    let sixSelectBeachTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.init(name: "Comfortaa-Bold" , size: 18)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    lazy var selectSessionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("Select Session", for: UIControl.State())
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.init(name: "Comfortaa-Medium" , size: 18)
        button.addTarget(self, action: #selector(handleSelectSession), for: .touchUpInside)
         print("Book session button pressed")
        
        return button
    
    }()

    
    @objc func handleSaveChanges() {
        //backend stuff
        print("save pressed")
        
    }
    
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLessontypeData()
        
        self.title = "Select Lesson Type"
         //fetch "lesson set" data
        
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        addDoneButtonOnKeyboard()
        view.backgroundColor = .white
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveChanges))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        setupNavBar()
        setupViews()
        setupPickerViews()
        

        //backend stuff
        
        
    }
    
    // location manager function
   
    func loadLessontypeData() {
    
        ref = Database.database().reference()
        
        //user ID retreival
       //let userID = Auth.auth().currentUser?.uid
        
        //get admin id and pass it throught the first child below
       

        //run admin id through this reference to get the lesson length snapshots and repeat for all other configurations
        
        ref.child("lesson-set").child(adminid!).observeSingleEvent(of: .value, with: { (snapshot) in
         // Get user value
         let value = snapshot.value as? NSDictionary
        //reading in the dictionary
        let lessonLength = value?["LessonLength"] as? String ?? ""
        let beachOne = value?["Beachone"] as? String ?? ""
        let beachTwo = value?["BeachTwo"] as? String ?? ""
        let beachThree = value?["BeachThree"] as? String ?? ""
        let beachFour = value?["BeachFour"] as? String ?? ""
        let beachFive = value?["BeachFive"] as? String ?? ""

        let OffersInWaterShooting = value?["OffersInWaterShooting"] as? String ?? ""
        let numOfRiders = value?["NumberOfRides"] as? String ?? ""
        let OffersEditedPhotos = value?["OffersEditedPhotos"] as? String ?? ""
        let hourlyEditRate = value?["PriceOfEditedSessions"] as? String ?? ""
        let hourlyInWaterRate = value?["PriceOfInWaterShooting"]as? String ?? ""
            

        //see what happend when admin does not offer wet suits
        
        self.inWaterCosts = hourlyInWaterRate
            //will cause an error if the admin does not set the pricce of a board rental. #comment out
       // print(self.boardPrice! + 100)
            
    
        print("The lesson length is \(lessonLength)")
        print("Beach One is \(beachOne)")
        print("Beach two is \(beachTwo)")
        print("Beach three is \(beachThree)")
        print("Beach four is \(beachFour)")
        print("Beach five is \(beachFive)")
        print("Do they offer in water shooting? :\(OffersInWaterShooting)")
        print("Their maximum number of riders is \(numOfRiders)")
        print("Do they offer edited photos ?: \(OffersEditedPhotos)")
        print("Their hourly edit rate is \(hourlyEditRate)")
      print("Their hourly in water rate is \(hourlyInWaterRate)")
        print("LoadLessontypeData func called")
            
            
            //load beach Lists
            //load beaches list
            
            
            if OffersEditedPhotos == "No"{
                self.editedOrNotOptions.removeAll()
                self.editedOrNotOptions.append("Not Availible")
                
            }else{
                print("Is offering")
            }
            
            if  OffersInWaterShooting  == "No"{
                self.inWaterOrShoreOptions.removeAll()
                self.inWaterOrShoreOptions.append("Not Availible")
            }else{
                
            }
            
            
            self.EditingCost = hourlyEditRate
            self.inWaterCosts =  hourlyInWaterRate
    
        
            self.beachesLish.remove(at: 0)
            self.beachesLish.append(beachOne)
            self.beachesLish.append(beachTwo)
            self.beachesLish.append(beachThree)
            self.beachesLish.append(beachFour)
            self.beachesLish.append(beachFive)
            
            //load number of riders
        
            switch (numOfRiders) {
            case "1" :
                self.numberOfRides.remove(at: 4)
                self.numberOfRides.remove(at: 3)
                self.numberOfRides.remove(at: 2)
                self.numberOfRides.remove(at: 1)
            case "2" :
                self.numberOfRides.remove(at: 4)
                self.numberOfRides.remove(at: 3)
                self.numberOfRides.remove(at: 2)
                
            case "3" :
                self.numberOfRides.remove(at: 4)
                self.numberOfRides.remove(at: 3)
            case "4" :
                self.numberOfRides.remove(at: 4)
            case "5" :
                return
            default:
                return
            }
            
        //
    
        //load fetched data into max lesson length
            switch (lessonLength) {
            case "1 hour" :
                self.maxLessonLength.remove(at: 3)
                self.maxLessonLength.remove(at: 2)
                self.maxLessonLength.remove(at: 1)
            case "2 hours" :
                self.maxLessonLength.remove(at: 3)
                self.maxLessonLength.remove(at: 2)
            case "3 hours" :
               self.maxLessonLength.remove(at: 3)
            case "4 hours" :
                return
            default:
                return
            }
         
         // ...
         }) { (error) in
           print(error.localizedDescription)
        }
        
    
    }
    
    
 
    
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
//        fetchUser()
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    func setupNavBar() {

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(r: 22, g: 128, b: 199)
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }
    
    func setupViews()  {
        
        containerView.addSubview(oneNumberOfRidesLable)
        containerView.addSubview(oneNumberOfRidesTextField)
        containerView.addSubview(twoLessonLengthLable)
        containerView.addSubview(twoLessonLengthTextField)
        containerView.addSubview(threeNumberOfBoardsLable)
        containerView.addSubview(threeNumberOfBoardsTextField)
        containerView.addSubview(fourNumberOfWetsuitsTextField)
        containerView.addSubview(fourNumberOfWetsuitsLable)
        containerView.addSubview(fiveExperienceLable)
        containerView.addSubview(fiveExperienceTextField)
        containerView.addSubview(sixSelectBeachLable)
        containerView.addSubview(sixSelectBeachTextField)
        
        containerView.addSubview(threeSubLable)
        containerView.addSubview(fourSubLable)
        
        containerView.addSubview(selectSessionButton)
        
        
        
        oneNumberOfRidesLable.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 16).isActive = true
        oneNumberOfRidesLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        oneNumberOfRidesLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        oneNumberOfRidesTextField.topAnchor.constraint(equalTo: oneNumberOfRidesLable.bottomAnchor, constant: 6).isActive = true
        oneNumberOfRidesTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        oneNumberOfRidesTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        
        twoLessonLengthLable.topAnchor.constraint(equalTo: oneNumberOfRidesTextField.bottomAnchor,constant: 16).isActive = true
        twoLessonLengthLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        twoLessonLengthLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        twoLessonLengthTextField.topAnchor.constraint(equalTo: twoLessonLengthLable.bottomAnchor, constant: 6).isActive = true
        twoLessonLengthTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        twoLessonLengthTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        
        threeNumberOfBoardsLable.topAnchor.constraint(equalTo: twoLessonLengthTextField.bottomAnchor,constant: 16).isActive = true
        threeNumberOfBoardsLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        threeNumberOfBoardsLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        threeSubLable.topAnchor.constraint(equalTo: threeNumberOfBoardsLable.bottomAnchor,constant: 2).isActive = true
        threeSubLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        threeSubLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        threeNumberOfBoardsTextField.topAnchor.constraint(equalTo: threeSubLable.bottomAnchor, constant: 6).isActive = true
        threeNumberOfBoardsTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        threeNumberOfBoardsTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        
        fourNumberOfWetsuitsLable.topAnchor.constraint(equalTo: threeNumberOfBoardsTextField.bottomAnchor,constant: 16).isActive = true
        fourNumberOfWetsuitsLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        fourNumberOfWetsuitsLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        fourSubLable.topAnchor.constraint(equalTo: fourNumberOfWetsuitsLable.bottomAnchor,constant: 2).isActive = true
        fourSubLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        fourSubLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        fourNumberOfWetsuitsTextField.topAnchor.constraint(equalTo: fourSubLable.bottomAnchor, constant: 6).isActive = true
        fourNumberOfWetsuitsTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        fourNumberOfWetsuitsTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        
        fiveExperienceLable.topAnchor.constraint(equalTo: fourNumberOfWetsuitsTextField.bottomAnchor,constant: 16).isActive = true
        fiveExperienceLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        fiveExperienceLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        fiveExperienceTextField.topAnchor.constraint(equalTo: fiveExperienceLable.bottomAnchor, constant: 6).isActive = true
        fiveExperienceTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        fiveExperienceTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        sixSelectBeachLable.topAnchor.constraint(equalTo: fiveExperienceTextField.bottomAnchor,constant: 16).isActive = true
        sixSelectBeachLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        sixSelectBeachLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        sixSelectBeachTextField.topAnchor.constraint(equalTo: sixSelectBeachLable.bottomAnchor, constant: 6).isActive = true
        sixSelectBeachTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        sixSelectBeachTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
       
        selectSessionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        selectSessionButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -60).isActive = true
        selectSessionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectSessionButton.topAnchor.constraint(equalTo: sixSelectBeachTextField.bottomAnchor, constant: 32).isActive =  true
    }
    

    
    func addDoneButtonOnKeyboard(){
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

//        nameTextField.inputAccessoryView = doneToolbar

    }
    
    
 


    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }
    
    @objc func handleSelectSession(){
      
        
        print("-------------select session pressed---------")
        print(user?.longitude ?? "no longitude" )//why is this printing nil?
        print(user?.longitude ?? "no latitude")//why is this printing nil?
        if oneNumberOfRidesTextField.text!.isEmpty || ((twoLessonLengthTextField.text!.isEmpty)) || ((threeNumberOfBoardsTextField.text!.isEmpty)) || ((fourNumberOfWetsuitsTextField.text!.isEmpty)) || ((fiveExperienceTextField.text!.isEmpty)) || ((sixSelectBeachTextField.text!.isEmpty)) {
            
            let alert = UIAlertController(title: "Empty Field", message: "Please fill all the entries to proceed further", preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                (action) in
                
                
            }))
            
            
            self.present(alert,animated: true)
        }else {
            
            let vc = SelectSessionViewController()
          
            
            //---------loading values into next view----------------
            vc.numOfRiders = oneNumberOfRidesTextField.text as Any as! String
            vc.lessonLength = twoLessonLengthTextField.text as Any as! String
            vc.numOfRiders = twoLessonLengthTextField.text as Any as! String
            vc.numOfRiders = threeNumberOfBoardsTextField.text as Any as! String
            vc.numOfWetSuits = fourNumberOfWetsuitsTextField.text as Any as! String
            vc.experience =  fiveExperienceTextField.text as Any as! String
            vc.beach =  sixSelectBeachTextField.text as Any as! String
            //add administrator providing service below
            vc.provider =  adminsName as Any as! String
            vc.adminType = adminType as Any as! String
            vc.adminsName = adminsName as Any as! String
            vc.adminID = adminid as Any as! String
            //------------------------animate in  new view controller --------------------------
            navigationController?.pushViewController(vc, animated: true)
            
            
            
        }
    
        ///store session info on firebase as an event
        
        //make reference
       // print(oneNumberOfRidesTextField.text as Any)
       // print(twoLessonLengthTextField.text as Any)
       // print(threeNumberOfBoardsTextField.text as Any)
       // print(fourNumberOfWetsuitsTextField.text as Any)
       // print(fiveExperienceTextField.text as Any)
       // print(sixSelectBeachTextField.text as Any)
        
        
        
        //------------------get admin's name---------------------
       
        //------------Create booking event -----------------
    appointmentTypeConvert(type: adminType)
    //sendEventToDatabase()

        //create admin events
       
        
        
        
        
        //---------------------------------------------------
      

        
    }
    
    
    func sendEventToDatabase () {
   
       
               guard let uid = Auth.auth().currentUser?.uid else {
                                      //for some reason uid = nil
                              return
                                  }
                   
                   
                     let ref = Database.database().reference().child("user-appointments")
               let childRef = ref.child(uid).child(adminType!)
        print("\(adminsName!) IS THE ADMINISTRATORS NAME SO IT SHOULD BE SAVED INTHE THE USER APPOINTMENTS")
                     let values = [    "Number of riders" : oneNumberOfRidesTextField.text as Any,
                                       "Lesson Length" : twoLessonLengthTextField.text as Any,
                                       "Number of Board rentals" : threeNumberOfBoardsTextField.text as Any,
                                       "Price per Board" : fourNumberOfWetsuitsTextField.text as Any,
                                       "Number of Wet suit rentals" : fiveExperienceTextField.text as Any,
                                       "Location" : sixSelectBeachTextField.text as Any,
                                       //add administrator providing service below
                                        "Service Provider" : adminsName as Any
                                      ]
               
               childRef.updateChildValues(values) { (error, ref) in
                      if error != nil {
                          print(error!)
                          return
                      } else {
                          print("No errors and child added")

                          
                       }
                      
                   }
    }
    
    
    

    func appointmentTypeConvert(type: String?){
        switch (type) {
        case "Photographer" :
            adminType = "Photography Session"
        case "Videographer" :
            adminType = "Videography Session"
        case "Instructor" :
            adminType = "Instructor Session"
        case "Camp" :
            adminType = "Camp Session"
        case "Coach" :
            adminType = "Coach Session"
        default:
            return
        }
    }
    
 
        


        
        
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {

        return
            }
            //fetch snapshot
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
    //                self.navigationItem.title = dictionary["name"] as? String
                    
                    _ = User(dictionary: dictionary)
                    
                }
                
                }, withCancel: nil)
        }



  }

