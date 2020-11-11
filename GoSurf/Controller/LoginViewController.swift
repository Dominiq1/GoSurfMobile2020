//
//  LoginViewController.swift
//  GoSurf
//
//  Created by Pop on 18/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate {
    
//    var businessType = ["Camp","Shaper","Storefront","Rental","Coach","Instructor","Photographer","Videographer","Repairs","Glassing"]
    
    var businessType = ["Camp","Coach","Instructor","Photographer","Videographer"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        businessType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return businessType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        businessTypeTextField.text = businessType[row]
        self.view.endEditing(false)
    }
    
    
    var messagesController: ViewController?
    
    
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.setTitle("Register", for: UIControl.State())
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
        
        
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                var alert = UIAlertController(title: "Invalid Login",
                            message: "Please enter he correct login information.",
                            preferredStyle: .alert)
                        self.present(alert, animated: true, completion:nil)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    (action) in
                    
                    
                }))
                
        
                
                print(error ?? "")
                return
            }
            
            //successfully logged in our user
            
//            self.messagesController?.fetchUserAndSetupNavBarTitle()
            

            
            self.dismiss(animated: true, completion: {
                
            })
            
  
//            self.dismiss(animated: true, completion: nil)
            

        })
        
    }
    
    func handleRegister() {
        
        if userTypeSegmentedController.selectedSegmentIndex == 1 {
            
            // user profile registration
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
            
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            print(error!)
                            return
                        }
                        
                        guard let uid = user?.user.uid else {
                            return
                        }
                        
                        
                        //successfully authenticated user
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users").child(uid)
                        let values = ["name": name, "email": email, "type": self.getType()]
                        
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            
                            if let err = err {
                                print(err)
                                return
                            }
                            
                            self.dismiss(animated: true, completion: nil)
                            self.tabBarController?.selectedIndex = 3
                            
                            
                        })
                    })
            
        } else {
            
            // business profile registration
            
            guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let type = businessTypeTextField.text else {
                print("Form is not valid")
                return
            }
            
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            print(error!)
                            return
                        }
                        
                        guard let uid = user?.user.uid else {
                            return
                        }
                        
                        
                        //successfully authenticated user
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users").child(uid)
                        let values = ["name": name, "email": email, "type": self.getType(), "businessType": type ]
                        
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            
                            if let err = err {
                                print(err)
                                return
                            }
                            

            //                let profileViewController = ProfileViewController()
            //                self.present(profileViewController, animated: true, completion: nil)
                            
                            self.dismiss(animated: true, completion: nil)
                            self.tabBarController?.selectedIndex = 3
                            
                            
                        })
                    })
            
        }
        

        
    }
    
    
    func getType() -> String {
        
        let index = userTypeSegmentedController.selectedSegmentIndex
        
        if index == 0 {
            
            return "Business"
        }else {
            
            return "User"
        }
    }
    


    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let businessTypeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Business Type"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gosurf")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.backgroundColor = .gray
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    lazy var userTypeSegmentedController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Business", "User"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.green
        sc.backgroundColor = .white
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 0
        sc.layer.borderColor = UIColor(r: 255, g: 255, b: 255).cgColor
        sc.layer.borderWidth = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        sc.layer.masksToBounds = true
        return sc
    }()
    
    @objc func handleBusinessUserChange() {
        
        
    }
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControl.State())

        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            
            
            inputsContainerViewHeightAnchor?.constant = 100
            
            // change height of nameTextField
            nameTextFieldHeightAnchor?.isActive = false
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            nameTextFieldHeightAnchor?.isActive = true
            nameTextField.isHidden = true
            
            businessTypeTextFieldHeightAnchor?.isActive = false
            businessTypeTextFieldHeightAnchor = businessTypeTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            businessTypeTextFieldHeightAnchor?.isActive = true
            businessTypeTextField.isHidden = true
            
            
            userTyperHeightAnchor?.isActive = false
            userTyperHeightAnchor = userTypeSegmentedController.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            userTyperHeightAnchor?.isActive = true
            userTypeSegmentedController.isHidden = true
            
            
            emailTextFieldHeightAnchor?.isActive = false
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            emailTextFieldHeightAnchor?.isActive = true
            
            
            passwordTextFieldHeightAnchor?.isActive = false
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            passwordTextFieldHeightAnchor?.isActive = true
            
            
        }else {
            
            if userTypeSegmentedController.selectedSegmentIndex == 0 {
            
            
            inputsContainerViewHeightAnchor?.constant = 220
            
            // change height of nameTextField
            nameTextFieldHeightAnchor?.isActive = false
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
            nameTextFieldHeightAnchor?.isActive = true
            nameTextField.isHidden = false
            
            businessTypeTextFieldHeightAnchor?.isActive = false
            businessTypeTextFieldHeightAnchor = businessTypeTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
            businessTypeTextFieldHeightAnchor?.isActive = true
            businessTypeTextField.isHidden = false
            
            
            userTyperHeightAnchor?.isActive = false
            userTyperHeightAnchor = userTypeSegmentedController.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
            userTyperHeightAnchor?.isActive = true
            userTypeSegmentedController.isHidden = false
            
            
            emailTextFieldHeightAnchor?.isActive = false
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
            emailTextFieldHeightAnchor?.isActive = true
            
            
            passwordTextFieldHeightAnchor?.isActive = false
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
            passwordTextFieldHeightAnchor?.isActive = true
                
                
            } else {
                
                inputsContainerViewHeightAnchor?.constant = 200
                
                // change height of nameTextField
                nameTextFieldHeightAnchor?.isActive = false
                nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
                nameTextFieldHeightAnchor?.isActive = true
                nameTextField.isHidden = false
                
                businessTypeTextFieldHeightAnchor?.isActive = false
                businessTypeTextFieldHeightAnchor = businessTypeTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
                businessTypeTextFieldHeightAnchor?.isActive = true
                businessTypeTextField.isHidden = false
                
                
                userTyperHeightAnchor?.isActive = false
                userTyperHeightAnchor = userTypeSegmentedController.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
                userTyperHeightAnchor?.isActive = true
                userTypeSegmentedController.isHidden = false
                
                
                emailTextFieldHeightAnchor?.isActive = false
                emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
                emailTextFieldHeightAnchor?.isActive = true
                
                
                passwordTextFieldHeightAnchor?.isActive = false
                passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
                passwordTextFieldHeightAnchor?.isActive = true
                
            }
            
            
        }
        
        
        
    }
    var businessTypePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        businessTypePicker.dataSource = self
        businessTypePicker.delegate = self
        businessTypeTextField.inputView = businessTypePicker
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "4")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        backgroundImage.alpha = 0.5
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
        addDoneButtonOnKeyboard()
    }
    
    
    func addDoneButtonOnKeyboard(){
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        nameTextField.inputAccessoryView = doneToolbar
        emailTextField.inputAccessoryView = doneToolbar
        passwordTextField.inputAccessoryView = doneToolbar
        businessTypeTextField.inputAccessoryView = doneToolbar

    }

    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }

    
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    

    
    func setupLoginRegisterSegmentedControl() {
        //need x, y, width, height constraints
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor , constant:  -36).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func setupProfileImageView() {
        //need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var businessTypeTextFieldHeightAnchor: NSLayoutConstraint?
    var userTyperHeightAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView() {
        //need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24-16).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 220)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(userTypeSegmentedController)
        inputsContainerView.addSubview(businessTypeTextField)
        inputsContainerView.addSubview(passwordSeparatorView)

        //need x, y, width, height constraints
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
        nameTextFieldHeightAnchor?.isActive = true
        
        
        userTypeSegmentedController.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        userTypeSegmentedController.topAnchor.constraint(equalTo: businessTypeTextField.bottomAnchor).isActive = true
        userTypeSegmentedController.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        userTyperHeightAnchor = userTypeSegmentedController.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
        userTyperHeightAnchor?.isActive = true
        
        
        businessTypeTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        businessTypeTextField.topAnchor.constraint(equalTo: passwordSeparatorView.bottomAnchor).isActive = true
        businessTypeTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        businessTypeTextFieldHeightAnchor = businessTypeTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
        businessTypeTextFieldHeightAnchor?.isActive = true
        
        
        //need x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
    
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
        
        emailTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/5)
        passwordTextFieldHeightAnchor?.isActive = true
        
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        

    }
    
    func setupLoginRegisterButton() {
        //need x, y, width, height constraints
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -60).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}


