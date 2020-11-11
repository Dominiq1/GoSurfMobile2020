//
//  ProfileViewController.swift
//  GoSurf
//
//  Created by Pop on 28/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
        //return UIStatusBarStyle.default   // Make dark again
    }

    
    var businessType = ["Camp","Coach","Instructor","Photographer","Videographer"]
    
//    var businessType = ["Camp","Shaper","Storefront","Rental","Coach","Instructor","Photographer","Videographer","Repairs","Glassing"]
    
    var businessTypePicker = UIPickerView()
    
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
    
    //var messagesController: ViewController?
    
    lazy var cVS = CGSize(width: self.view.frame.width, height: 820)
    
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
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var saveChangesButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("Save", for: UIControl.State())
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSaveChanges), for: .touchUpInside)
        return button
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.darkGray, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        return button
    }()
    
    
    

    

    
    var imageURL = String()
    
    
    @objc func handleSignOut(){
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
        
    }
    
    @objc func handleSaveChanges() {
        
        
        print("save pressed")
        

            guard let uid = Auth.auth().currentUser?.uid else {
                    //for some reason uid = nil
            return
                }
                            
                            //successfully authenticated user
                            let ref = Database.database().reference()
                            let usersReference = ref.child("users").child(uid)
                            
                            
                
        
        
                if let imageData = self.profileImageView.image?.jpegData(compressionQuality: 0.5) {
                    
                    let imageStorageRef = Storage.storage().reference().child("images")
                    let newImageRef = imageStorageRef.child(uid)
                    
                    newImageRef.putData(imageData).observe(.success, handler:
                        { (snapshot) in
                            newImageRef.downloadURL { (url, error) in
                                guard let downloadURL = url?.absoluteString else {
                                // Uh-oh, an error occurred!
                                return
                              }
                                
                                self.imageURL = downloadURL
                                
                                let values = ["name": self.nameTextField.text!,
                                              "email": self.emailTextField.text!,
                                              "businessType": self.businessTypeTextField.text!,
                                              "contact": self.contactInfoTextField.text!,
                                              "bio": self.descriptionTextView.text!,
                                              "profileImageUrl": self.imageURL,
                                              "latitude": self.latitude as Any,
                                              "longitude": self.longitude as Any,
                                              "shortAddress": self.shortAddress as Any,
                                              "address": self.address as Any ] as [String : Any]
                                                        
                                            usersReference.updateChildValues(values as [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                                                            
                                                            if let err = err {
                                                                print(err)
                                                                return
                                                            }
                                                            //on competion
                                
                                                            let message = "successfully saved"
                                                            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                                                            self.present(alert, animated: true)

                                                            // duration in seconds
                                                            let duration: Double = 1

                                                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                                                                alert.dismiss(animated: true)
                                                            }

                                                            
                                                        })
                    
                            }

                    })
                    
                }
        

        

    }
    
    func handleLogin() {
        
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            //successfully logged in our user
            
//            self.messagesController?.fetchUserAndSetupNavBarTitle()
            
            self.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
    func handleRegister() {
        
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
                
            })
        })
        
    }
    
    
    func getType() -> String {
        
        return "User"
        
            }
    
    var latitude: Double?
    var longitude: Double?
    var shortAddress: String?
    
    var address: String? {
        didSet {
            addressTextField.setTitle(self.address, for: .normal)
            addressTextField.setTitleColor(.black, for: .normal)
        }
    }

    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
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
    
    let businessSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contactSeparatorView: UIView = {
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
    
    let contactInfoTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Contact Info."
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let businessTypeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Business type"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.text = "Bio"
        lable.textColor = .lightGray
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = true
        tv.backgroundColor = #colorLiteral(red: 0.9314685464, green: 0.9314685464, blue: 0.9314685464, alpha: 1)
        tv.layer.cornerRadius = 10
        tv.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "user")
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderWidth = 0.5
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        
        return imageView
    }()
    
    let addressTextField: UIButton = {
        let tf = UIButton()
        tf.setTitle("Address", for: .normal)
        tf.setTitleColor(.gray, for: .normal)
        tf.contentHorizontalAlignment = .left
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(openAddressPicker), for: UIControl.Event.touchUpInside)
        return tf
    }()
    
    @objc func openAddressPicker() {
        let newPostController = AddressPickViewController()
        newPostController.delegate = self
        let navController = UINavigationController(rootViewController: newPostController)
        present(navController, animated: true, completion: nil)
    }
    
    let addresSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    


    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        businessTypePicker.dataSource = self
        businessTypePicker.delegate = self
        businessTypeTextField.inputView = businessTypePicker
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        addDoneButtonOnKeyboard()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
                containerView.addSubview(inputsContainerView)
                containerView.addSubview(saveChangesButton)
                containerView.addSubview(profileImageView)


        setupInputsContainerView()
        setupSaveChangesButton()
        setupProfileImageView()
 
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    

    

    func setupProfileImageView() {
        //need x, y, width, height constraints
        profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 64).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var businessTypeTextFieldHeightAnchor: NSLayoutConstraint?
    var descriptionTextViewHeightAnchor: NSLayoutConstraint?
    var contactInfoTextFieldHeightAnchor: NSLayoutConstraint?
    

    
    func setupInputsContainerView() {
        //need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24-16).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(businessTypeTextField)
        inputsContainerView.addSubview(contactInfoTextField)
        inputsContainerView.addSubview(descriptionTextView)
        
        inputsContainerView.addSubview(contactSeparatorView)
        inputsContainerView.addSubview(businessSeparatorView)
        
        inputsContainerView.addSubview(descriptionLable)
        
        inputsContainerView.addSubview(addressTextField)
        inputsContainerView.addSubview(addresSeparatorView)
        

        
        //need x, y, width, height constraints
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/8)
        nameTextFieldHeightAnchor?.isActive = true
        
        
        
        
        //need x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/8)
        emailTextFieldHeightAnchor?.isActive = true
        
        //need x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        

        //
        businessTypeTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        businessTypeTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        businessTypeTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        businessTypeTextFieldHeightAnchor = businessTypeTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/8)
        businessTypeTextFieldHeightAnchor?.isActive = true
        
        //--
        businessSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        businessSeparatorView.topAnchor.constraint(equalTo: businessTypeTextField.bottomAnchor).isActive = true
        businessSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        businessSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
//
        //
        contactInfoTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        contactInfoTextField.topAnchor.constraint(equalTo: businessTypeTextField.bottomAnchor).isActive = true
        contactInfoTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        contactInfoTextFieldHeightAnchor = contactInfoTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/8)
        contactInfoTextFieldHeightAnchor?.isActive = true
        
        contactSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        contactSeparatorView.topAnchor.constraint(equalTo: contactInfoTextField.bottomAnchor).isActive = true
        contactSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        contactSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addressTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        addressTextField.topAnchor.constraint(equalTo: contactInfoTextField.bottomAnchor).isActive = true
        addressTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        addressTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/8).isActive = true
        
        addresSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        addresSeparatorView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor).isActive = true
        addresSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        addresSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        descriptionLable.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        descriptionLable.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10).isActive = true
        descriptionLable.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        descriptionLable.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionTextView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 6).isActive = true
//        descriptionTextView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: inputsContainerView.bottomAnchor).isActive = true
//        descriptionTextViewHeightAnchor = descriptionTextView.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor,multiplier: 3/7)
        descriptionTextViewHeightAnchor?.isActive = true
        
        
    }
    
    func setupSaveChangesButton() {
        //need x, y, width, height constraints
        saveChangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveChangesButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 16).isActive = true
        saveChangesButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -60).isActive = true
        saveChangesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
//    func setupSignOutButton() {
//        //need x, y, width, height constraints
//        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        signOutButton.topAnchor.constraint(equalTo: saveChangesButton.bottomAnchor, constant: 16).isActive = true
//        signOutButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -60).isActive = true
//        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
    
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
        businessTypeTextField.inputAccessoryView = doneToolbar
        contactInfoTextField.inputAccessoryView = doneToolbar
        descriptionTextView.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }

    
    
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
    //                self.navigationItem.title = dictionary["name"] as? String
                    
                    let user = User(dictionary: dictionary)
                    self.setupData(user)
                }
                
                }, withCancel: nil)
        }
    
    
    func setupData(_ user: User) {
        
        self.nameTextField.text = user.name
        
        self.emailTextField.text = user.email
        
        self.contactInfoTextField.text = user.contact
        
        self.descriptionTextView.text = user.bio
        
        if user.address != nil {
            
        self.addressTextField.setTitle(user.address, for: .normal)
            
        self.addressTextField.setTitleColor(.black, for: .normal)
            
        }
        
        
        
        if user.type == "User" {
            
            self.businessTypeTextField.text = "Customer Account"
            self.businessTypeTextField.isEnabled = false
            
        } else {
            
            self.businessTypeTextField.text = user.businessType
            
        }
        
        
        if let profileImageUrl = user.profileImageUrl {
            
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
            
        }
        
        
        
        
    }

}

extension ProfileViewController: AddAddressDelegate {
    
    
    func addAddress(shortAddress: String, address: String, latitude: Double, longitude: Double) {
        self.dismiss(animated: true, completion: nil)
        self.longitude = longitude
        self.latitude = latitude
        self.address = address
        self.shortAddress = shortAddress
        
    }
}


