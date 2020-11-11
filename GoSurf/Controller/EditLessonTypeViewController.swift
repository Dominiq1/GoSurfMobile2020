//
//  EditLessonTypeViewController.swift
//  GoSurf
//
//  Created by Piyush on 27/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit
import Firebase


class EditLessonTypeViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    //camps can book how many people max?
    var businessType = ["Camp","Coach","Instructor","Photographer","Videographer"]
    var numberOfRides:[String] = []
    var maxLessonLength = ["1 hour","2 hours","3 hours","4 hours"]
    var numberOfBoards = ["0", "1", "2", "3", "4", "5", "6","7","8","9","10"]
    var numberOfWetsuits = ["0", "1", "2", "3", "4", "5", "6","7","8","9","10"]
   // var beachesLish = ["Blacks Beach","Beach 2","Beach 3","Beach 4","Beach 5"]
    var beachesLish = ["BLACK'S BEACH","BONITA COVE", "CARDIFF STATE BEACH", "CARLSBAD STATE BEACH", "CARLSBAD STATE BEACH - SOUTH", "CHILDREN'S POOL/CASA COVE", "CORONADO BEACH - NORTH", "CORONADO BEACH - SOUTH", "D STREET BEACH", "DEL MAR BEACH", "DOG BEACH (AT OCEAN BEACH)", "FLETCHER COVE", "GARBAGE BEACH", "HARBOR BEACH", "IMPERIAL BEACH", "LA JOLLA COVE & ELLEN BROWNING SCRIPPS PARK; ECOLOGICAL RESERVE", "LA JOLLA SHORES", "LEUCADIA (GRANDVIEW)", "MOONLIGHT BEACH", "MISSION BEACH - NORTH", "MISSION BEACH - SOUTH", "OCEAN BEACH - NORTH", "OCEAN BEACH - SOUTH", "OCEANSIDE PIER BEACH", "PACIFIC BEACH", "SAN ELIJO STATE BEACH", "SEASCAPE BEACH", "SILVER STRAND STATE BEACH", "SWAMI'S BEACH PARK", "TORREY PINES STATE BEACH"]
    var gosurfstations : [goSurfStation] = []
    
    struct goSurfStation {
         var Longitude :Double = 0.0
         var Latitude : Double = 0.0
         var beachName: String! = ""
         var beachStation: Int = 0
     }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func buildStations(){
        //-------------install gosurf stations availible---------
        
        let gosurfstationvc = MapViewController()
        
        var list = gosurfstationvc.BeachIdentity
        
        for i in 0...list.count{
            beachesLish.append(list[i].beachName)
            print("-----------------------------")
            print(list[0].beachName!)
            print("-----------------------------")
        }
        
        //-------------------------------------------------------
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == numberOfRidesPicker {
            return numberOfRides.count
            
        } else if pickerView == maxLessonLenghtPicker {
            return maxLessonLength.count
            
        } else if pickerView == numberOfBoardsPicker {
            return numberOfBoards.count
            
        } else if pickerView == numberOfWetsuitsPicker {
            return numberOfWetsuits.count
            
        } else {
            return beachesLish.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == numberOfRidesPicker {
            return numberOfRides[row]
            
        } else if pickerView == maxLessonLenghtPicker {
            return maxLessonLength[row]
            
        } else if pickerView == numberOfBoardsPicker {
            return numberOfBoards[row]
            
        } else if pickerView == numberOfWetsuitsPicker {
            return numberOfWetsuits[row]
            
        } else {
            return beachesLish[row]
        }


    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == numberOfRidesPicker {
            oneNumberOfRidesTextField.text = numberOfRides[row]
            
        } else if pickerView == maxLessonLenghtPicker {
            twoLessonLengthTextField.text = maxLessonLength[row]
            
        } else if pickerView == numberOfBoardsPicker {
            threeNumberOfBoardsTextField.text = numberOfBoards[row]
            
        } else if pickerView == numberOfWetsuitsPicker {
            fiveNumberOfWetsuitsTextField.text = numberOfWetsuits[row]
            
        } else if pickerView == beachPickerOne {
            sixBeachOneTextField.text = beachesLish[row]
            
        } else if pickerView == beachPickerTwo {
                   sixBeachTwoTextField.text = beachesLish[row]
            
        } else if pickerView == beachPickerThree {
                   sixBeachThreeTextField.text = beachesLish[row]
            
        } else if pickerView == beachPickerFour {
                   sixBeachFourTextField.text = beachesLish[row]
            
        } else if pickerView == beachPickerFive {
                   sixBeachFiveTextField.text = beachesLish[row]
               }
        
        self.view.endEditing(false)
    }
    
    var numberOfRidesPicker = UIPickerView()
    var maxLessonLenghtPicker = UIPickerView()
    var numberOfBoardsPicker = UIPickerView()
    var numberOfWetsuitsPicker = UIPickerView()
    var beachPickerOne = UIPickerView()
    var beachPickerTwo = UIPickerView()
    var beachPickerThree = UIPickerView()
    var beachPickerFour = UIPickerView()
    var beachPickerFive = UIPickerView()
    
    func setupPickerViews()  {
        
        numberOfRidesPicker.dataSource = self
        numberOfBoardsPicker.dataSource = self
        numberOfWetsuitsPicker.dataSource = self
        maxLessonLenghtPicker.dataSource = self
        beachPickerOne.dataSource = self
        beachPickerTwo.dataSource = self
        beachPickerThree.dataSource = self
        beachPickerFour.dataSource = self
        beachPickerFive.dataSource = self
        
        
        numberOfRidesPicker.delegate = self
        numberOfBoardsPicker.delegate = self
        numberOfWetsuitsPicker.delegate = self
        maxLessonLenghtPicker.delegate = self
        beachPickerOne.delegate = self
        beachPickerTwo.delegate = self
        beachPickerThree.delegate = self
        beachPickerFour.delegate = self
        beachPickerFive.delegate = self
        
        oneNumberOfRidesTextField.inputView = numberOfRidesPicker
        twoLessonLengthTextField.inputView = maxLessonLenghtPicker
        threeNumberOfBoardsTextField.inputView = numberOfBoardsPicker
        fiveNumberOfWetsuitsTextField.inputView = numberOfWetsuitsPicker
        
        sixBeachOneTextField.inputView = beachPickerOne
        sixBeachTwoTextField.inputView = beachPickerTwo
        sixBeachThreeTextField.inputView = beachPickerThree
        sixBeachFourTextField.inputView = beachPickerFour
        sixBeachFiveTextField.inputView = beachPickerFive
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
        
    }

    
    lazy var cVS = CGSize(width: self.view.frame.width, height: 650)

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
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "Maximum no. of participants per lesson"
        return lable
    }()
    
    let oneNumberOfRidesTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor =  UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let twoLessonLengthLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "Maximum lesson length"
        return lable
    }()
    
    let twoLessonLengthTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let threeNumberOfBoardsLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "How many boards can you provide?"
        return lable
    }()
    
    let threeNumberOfBoardsTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let fourPriceOfABoadLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "How much for a student to rent one of your boards?"
        return lable
    }()
    
    let fourPriceOfABoadTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()

    let fiveNumberOfWetsuitsLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "How many wetsuits can you provide?"
        return lable
    }()
    
    let fiveNumberOfWetsuitsTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let sixWhichBeach: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "Which beaches can you teach at?"
        return lable
    }()
    
    let sixSubLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        lable.lineBreakMode = NSLineBreakMode.byWordWrapping
        lable.text = "( can be changed anytime )"
        return lable

    }()
    
    let sixBeachOneTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let sixBeachTwoTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let sixBeachThreeTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let sixBeachFourTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()
    
    let sixBeachFiveTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.textColor = .white
        tf.textAlignment = .center
        tf.font = UIFont.boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(red: 22/255, green: 122/255, blue: 199/255, alpha: 1.0)
        return tf
    }()




//Dominiq Martinez
    @objc func handleSaveChanges() {
        //backend stuff
        //this is the data ratreived from the edit lesson type form on admin side

        //create databse ref
    
        
        guard let uid = Auth.auth().currentUser?.uid else {
                           //for some reason uid = nil
                   return
                       }
        
        
            let ref = Database.database().reference().child("lesson-set")
              let childRef = ref.child(uid)
    
            

         let values = [    "Number of rides" : oneNumberOfRidesTextField.text as Any,
                            "Lesson Length" : twoLessonLengthTextField.text as Any,
                            "Number of Boards" : threeNumberOfBoardsTextField.text as Any,
                            "Price per Board" : fourPriceOfABoadTextField.text as Any,
                            "Number of Wet suits" : fiveNumberOfWetsuitsTextField.text as Any,
                            "Beach one" : sixBeachOneTextField.text as Any,
                            "Beach Two" : sixBeachTwoTextField.text as Any,
                            "Beach Three" : sixBeachThreeTextField.text as Any ,
                            "Beach Four" : sixBeachFourTextField.text as Any,
                            "Beach Five" : sixBeachFiveTextField.text as Any,
                           ]
        
        
            print("Databse branch added")
            
           childRef.updateChildValues(values) { (error, ref) in
           if error != nil {
               print(error!)
               return
           } else {
               print("No errors and child added")

               
            }
           
        }
        
        //print(oneNumberOfRidesTextField.text as Any)
        //print(twoLessonLengthTextField.text as Any)
        //print(threeNumberOfBoardsTextField.text as Any)
        //print(fourPriceOfABoadTextField.text as Any)
        //print(fiveNumberOfWetsuitsTextField.text as Any)
        //print(sixBeachOneTextField.text as Any)
        //print(sixBeachTwoTextField.text as Any)
        //print(sixBeachThreeTextField.text as Any)
        //print(sixBeachFourTextField.text as Any)
       // print(sixBeachFiveTextField.text as Any)
        
        print("Lesson type saved")
        dismiss(animated: true, completion: nil)

    }
    
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Lesson Type"

        self.navigationController?.tabBarController?.tabBar.isHidden = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        addDoneButtonOnKeyboard()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveChanges))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        setupNavBar()
        setupViews()
        setupPickerViews()
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
        setAmountOfRiders()
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    func setupNavBar() {

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
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
        containerView.addSubview(fourPriceOfABoadTextField)
        containerView.addSubview(fourPriceOfABoadLable)
        containerView.addSubview(fiveNumberOfWetsuitsLable)
        containerView.addSubview(fiveNumberOfWetsuitsTextField)
        
        containerView.addSubview(sixWhichBeach)
        containerView.addSubview(sixBeachOneTextField)
        containerView.addSubview(sixBeachTwoTextField)
        containerView.addSubview(sixBeachThreeTextField)
        containerView.addSubview(sixBeachFourTextField)
        containerView.addSubview(sixBeachFiveTextField)
        
        containerView.addSubview(sixSubLable)
        
        
        
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
        
        threeNumberOfBoardsTextField.topAnchor.constraint(equalTo: threeNumberOfBoardsLable.bottomAnchor, constant: 6).isActive = true
        threeNumberOfBoardsTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        threeNumberOfBoardsTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        
        fourPriceOfABoadLable.topAnchor.constraint(equalTo: threeNumberOfBoardsTextField.bottomAnchor,constant: 16).isActive = true
        fourPriceOfABoadLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        fourPriceOfABoadLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        fourPriceOfABoadTextField.topAnchor.constraint(equalTo: fourPriceOfABoadLable.bottomAnchor, constant: 6).isActive = true
        fourPriceOfABoadTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        fourPriceOfABoadTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        
        fourPriceOfABoadLable.topAnchor.constraint(equalTo: threeNumberOfBoardsTextField.bottomAnchor,constant: 16).isActive = true
        fourPriceOfABoadLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        fourPriceOfABoadLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        fourPriceOfABoadTextField.topAnchor.constraint(equalTo: fourPriceOfABoadLable.bottomAnchor, constant: 6).isActive = true
        fourPriceOfABoadTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        fourPriceOfABoadTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
        
        fiveNumberOfWetsuitsLable.topAnchor.constraint(equalTo: fourPriceOfABoadTextField.bottomAnchor,constant: 16).isActive = true
        fiveNumberOfWetsuitsLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        fiveNumberOfWetsuitsLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        fiveNumberOfWetsuitsTextField.topAnchor.constraint(equalTo: fiveNumberOfWetsuitsLable.bottomAnchor, constant: 6).isActive = true
        fiveNumberOfWetsuitsTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        fiveNumberOfWetsuitsTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        sixWhichBeach.topAnchor.constraint(equalTo: fiveNumberOfWetsuitsTextField.bottomAnchor,constant: 16).isActive = true
        sixWhichBeach.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        sixWhichBeach.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        sixSubLable.topAnchor.constraint(equalTo: sixWhichBeach.bottomAnchor,constant: 6).isActive = true
        sixSubLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        sixSubLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        
        sixBeachOneTextField.topAnchor.constraint(equalTo: sixSubLable.bottomAnchor, constant: 8).isActive = true
        sixBeachOneTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        sixBeachOneTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        sixBeachTwoTextField.topAnchor.constraint(equalTo: sixBeachOneTextField.bottomAnchor, constant: 8).isActive = true
        sixBeachTwoTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        sixBeachTwoTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        sixBeachThreeTextField.topAnchor.constraint(equalTo: sixBeachTwoTextField.bottomAnchor, constant: 8).isActive = true
        sixBeachThreeTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        sixBeachThreeTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        sixBeachFourTextField.topAnchor.constraint(equalTo: sixBeachThreeTextField.bottomAnchor, constant: 8).isActive = true
        sixBeachFourTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        sixBeachFourTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        sixBeachFiveTextField.topAnchor.constraint(equalTo: sixBeachFourTextField.bottomAnchor, constant: 8).isActive = true
        sixBeachFiveTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        sixBeachFiveTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        
        
       
        
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

    
    func setAmountOfRiders(){
       
        
        var user: User?
        var type = user?.businessType
        switch type{
        case "Camp":
            for i in 1...21{
                numberOfRides.append("\(i)")
            }
        default:
            for i in 1...4{
                numberOfRides.append("\(i)")
            }
            
        }
    }
    
    
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {

        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
    //                self.navigationItem.title = dictionary["name"] as? String
                    
                    let user = User(dictionary: dictionary)
                    user.id = snapshot.key
                }
                
                }, withCancel: nil)
        }


}
    


