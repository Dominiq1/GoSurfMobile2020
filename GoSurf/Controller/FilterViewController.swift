//
//  FilterViewController.swift
//  GoSurf
//
//  Created by Piyush on 20/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol filterDelegate {

    func filterBusinesses(minRate: Int, maxRate: Int, distance: Int, enabled: Bool)
 
}

class FilterViewController: UIViewController, UINavigationControllerDelegate {
    
    var delegate: filterDelegate?
    
    var isUserLocationAvailable: Bool? 
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    let rateTitleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rate($/hour):"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let distanceTitleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Distance:"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let toTitleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "to"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let minRateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Min."
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 4
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let maxRateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Max."
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 4
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let firstSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sliderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let distanceLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Showing all services irrespective of there distance"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let distanceSlider: UISlider = {
        let mySlider = UISlider()
        mySlider.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        mySlider.translatesAutoresizingMaskIntoConstraints = false
        mySlider.minimumValue = 0
        mySlider.maximumValue = 1000
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor(r: 22, g: 128, b: 199)
        mySlider.minimumValueImage = #imageLiteral(resourceName: "walking")
        mySlider.maximumValueImage = #imageLiteral(resourceName: "plane")
        mySlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
               
        return mySlider
    }()
    
    lazy var clearFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear filter", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 22, g: 128, b: 199), for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleClearfilter), for: .touchUpInside)
        return button
    }()
    
    @objc func handleClearfilter() {
        
        
        delegate?.filterBusinesses(minRate: Int(minRateTextField.text!) ?? 0, maxRate: Int(maxRateTextField.text!) ?? 0, distance: Int(distanceSlider.value), enabled: false)
            
    }
    
    @objc func sliderValueDidChange() {
        let value = Int(distanceSlider.value)
        print(value)
        
        
        if isUserLocationAvailable == false {
            
            distanceLable.text = "Please set your location to use this feature"
            distanceSlider.isEnabled = false
            
        }else {
            
            distanceSlider.isEnabled = true
            if value == 0 {
                distanceLable.text = "Showing services irrespective of their distance"
            } else {
                distanceLable.text = "Showing services within \(value) km range"
            }
            
        }

        
    }

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Filter"

        self.navigationController?.tabBarController?.tabBar.isHidden = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        addDoneButtonOnKeyboard()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(handleFilter))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))

        setupNavBar()
        setupViews()


    }
    
    @objc func handleFilter() {
        
        if (Int(minRateTextField.text!) ?? 0)  <= (Int(maxRateTextField.text!) ?? 0) {
        
        delegate?.filterBusinesses(minRate: Int(minRateTextField.text!) ?? 0, maxRate: Int(maxRateTextField.text!) ?? 0, distance: Int(distanceSlider.value), enabled: true)
            
        }
        
    }
    
    @objc func handleCancel() {
        self.dismiss(animated: true, completion: nil)
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
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    func setupViews()  {
        
        view.addSubview(rateTitleLable)
        view.addSubview(minRateTextField)
        view.addSubview(maxRateTextField)
        view.addSubview(toTitleLable)
        view.addSubview(firstSeparatorView)
        view.addSubview(distanceTitleLable)
        view.addSubview(distanceSlider)
        view.addSubview(distanceLable)
        view.addSubview(secondSeparatorView)
        view.addSubview(clearFilterButton)
        
        rateTitleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        rateTitleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        rateTitleLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        
        toTitleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toTitleLable.topAnchor.constraint(equalTo: rateTitleLable.bottomAnchor, constant: 16).isActive = true
    
        minRateTextField.bottomAnchor.constraint(equalTo: toTitleLable.bottomAnchor, constant: 0).isActive = true
        minRateTextField.rightAnchor.constraint(equalTo: toTitleLable.leftAnchor, constant: -16).isActive = true
        minRateTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        maxRateTextField.bottomAnchor.constraint(equalTo: toTitleLable.bottomAnchor, constant: 0).isActive = true
        maxRateTextField.leftAnchor.constraint(equalTo: toTitleLable.rightAnchor,constant: 16).isActive = true
        maxRateTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        firstSeparatorView.topAnchor.constraint(equalTo: toTitleLable.bottomAnchor, constant: 16).isActive = true
        firstSeparatorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        firstSeparatorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        firstSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        distanceTitleLable.topAnchor.constraint(equalTo: firstSeparatorView.bottomAnchor, constant: 16).isActive = true
        distanceTitleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        distanceTitleLable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        
        distanceLable.topAnchor.constraint(equalTo: distanceTitleLable.bottomAnchor, constant: 16).isActive = true
        distanceLable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        distanceLable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        distanceSlider.topAnchor.constraint(equalTo: distanceLable.bottomAnchor, constant: 16).isActive = true
        distanceSlider.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        distanceSlider.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        
        secondSeparatorView.topAnchor.constraint(equalTo: distanceSlider.bottomAnchor, constant: 16).isActive = true
        secondSeparatorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        secondSeparatorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        secondSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        clearFilterButton.topAnchor.constraint(equalTo: secondSeparatorView.bottomAnchor, constant: 16).isActive = true
        clearFilterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true



        
        
    }
    

    
    func addDoneButtonOnKeyboard(){
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        minRateTextField.inputAccessoryView = doneToolbar
        maxRateTextField.inputAccessoryView = doneToolbar


    }

    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }

    

}

