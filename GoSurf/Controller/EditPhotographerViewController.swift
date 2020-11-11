//
//  EditPhotographerViewController.swift
//  GoSurf
//
//  Created by Piyush on 21/06/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import UIKit
import Firebase

@available(iOS 13.4, *)
class EditPhotographerProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
        return UIStatusBarStyle.default
        //return UIStatusBarStyle.default   // Make dark again
        
    }

    
    lazy var cVS = CGSize(width: self.view.frame.width, height: 630)
    
    var viewController = PhotographerProfileViewController()
    
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
    
    lazy var plusImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "plus")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    
    var imageURL = String()
    var imageURLOne = String()
    var imageURLTwo = String()
    var imageURLThree = String()
    
    var imageNumber = Int()
    
    
    @objc func handleSignOut(){
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        weak var pvc = self.presentingViewController
        
        self.dismiss(animated: true, completion: {
            
            let loginController = LoginController()
            loginController.modalPresentationStyle = .fullScreen
            
            pvc?.present(loginController, animated: true, completion: nil)

        })
        
    }
    
    @objc func handleEditLessonType(){
        
        let viewController = PhotographerConfigViewController()
        let navController = UINavigationController(rootViewController: viewController)
        present(navController, animated: true, completion: nil)
        
    }
    
    @objc func handleSetBusinessHours(){
        
        let viewController = SetBusinessHoursViewController()
     
        let navController = UINavigationController(rootViewController: viewController)
        present(navController, animated: true, completion: nil)
        
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
                            
                            
                
        
        
        if let imageData = self.profileImageView.image?.jpegData(compressionQuality: 0.5)  {
                    
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
                                              "bio": self.descriptionTextView.text!,
                                              "profileImageUrl": self.imageURL,
                                              "latitude": self.latitude as Any,
                                              "longitude": self.longitude as Any,
                                              "rate": self.rateTextField.text!,
                                              "imageOneUrl": self.imageURLOne,
                                              "imageTwoUrl": self.imageURLTwo,
                                              "imageThreeUrl": self.imageURLThree,
                                              "shortAddress": self.shortAddress as Any,
                                              "address": self.address as Any ] as [String : Any]
                                                        
                                              usersReference.updateChildValues(values as [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                                                            
                                                            if let err = err {
                                                                print(err)
                                                                return
                                                            }
                                                            //on competion
                                
                                                            let message = "successfully saved \n Changes will reflect shortly"
                                                            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                                                            self.present(alert, animated: true)

                                                            // duration in seconds
                                                            let duration: Double = 1
                        
                                                
                                                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                                                                alert.dismiss(animated: true)
                                                                self.viewController.tableView.reloadData()
                                                                self.handleCancel()
                                                            
                                                }
                                                })

                                }
                                })
                                            
                            }

    }
    
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
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
    
    
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "user")
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderWidth = 1
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.font = UIFont.boldSystemFont(ofSize: 30)
        tf.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let editAvailabilityButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("Set Business hours", for: UIControl.State())
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSetBusinessHours), for: .touchUpInside)
        return button
        
    }()
    
    let addressTextField: UIButton = {
        
        let tf = UIButton(type: .system)
        tf.setTitle("Location", for: .normal)
        tf.setTitleColor(UIColor(r: 22, g: 128, b: 199), for: .normal)
        tf.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tf.contentHorizontalAlignment = .left
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.titleLabel?.lineBreakMode = .byTruncatingTail
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
    
    let rateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Hourly Rate"
        tf.keyboardType = .decimalPad
        tf.textColor = UIColor(r: 22, g: 128, b: 199)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let rateLable: UILabel = {
        let lable = UILabel()
        lable.text = "$/hour"
        lable.textColor = .black
        lable.textAlignment = .right
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let rateSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.text = "Bio"
        lable.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = true
        tv.backgroundColor = #colorLiteral(red: 0.9314685464, green: 0.9314685464, blue: 0.9314685464, alpha: 1)
        tv.layer.cornerRadius = 10
        tv.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    let mediaTitleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Media"
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()

    
    let ImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var imageViewOne: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var imageViewTwo: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    lazy var imageViewThree: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .darkGray
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let editServicePackageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("Edit Lesson Type", for: UIControl.State())
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleEditLessonType), for: .touchUpInside)

        return button
        
    }()
    
    let setBusinessHoursButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 22, g: 128, b: 199)
        button.setTitle("Set Business hours", for: UIControl.State())
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSetBusinessHours), for: .touchUpInside)

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
    
    lazy var uploadMediaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+ Upload Media", for: UIControl.State())
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action:  #selector(handleUploadMedia), for: .touchUpInside)
        return button
    }()
    
    @objc func handleUploadMedia() {

        let viewController = CreatePostViewController()
        let vc = UINavigationController(rootViewController: viewController)
        present(vc, animated: true, completion: nil)
        
    }

    
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        self.imageNumber = 0
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSelectOneImageView() {
        let picker = UIImagePickerController()
        self.imageNumber = 1
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSelectTwoImageView() {
        let picker = UIImagePickerController()
        self.imageNumber = 2
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSelectThreeImageView() {
        let picker = UIImagePickerController()
        self.imageNumber = 3
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
            
            if self.imageNumber == 0 {
                
            profileImageView.image = selectedImage
                
            } else if self.imageNumber == 1 {
                
                imageViewOne.image = selectedImage
                
            } else if self.imageNumber == 2 {
                
                imageViewTwo.image = selectedImage
                
            } else if self.imageNumber == 3 {
                
                imageViewThree.image = selectedImage
            
            }
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
        
        self.title = "Edit Profile"

        self.navigationController?.tabBarController?.tabBar.isHidden = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        addDoneButtonOnKeyboard()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Publish", style: .plain, target: self, action: #selector(handleSaveChanges))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        setupNavBar()
        setupViews()


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
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print(" vDD called")
        viewController.tableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var businessTypeTextFieldHeightAnchor: NSLayoutConstraint?
    var descriptionTextViewHeightAnchor: NSLayoutConstraint?
    var contactInfoTextFieldHeightAnchor: NSLayoutConstraint?
    
    
    func setupViews()  {
        
        containerView.addSubview(nameTextField)
        containerView.addSubview(nameSeparatorView)
        containerView.addSubview(profileImageView)
        
        containerView.addSubview(plusImageView)
        
        containerView.addSubview(editAvailabilityButton)
        containerView.addSubview(addressTextField)
        containerView.addSubview(addresSeparatorView)
        containerView.addSubview(rateLable)
        containerView.addSubview(rateTextField)
        containerView.addSubview(rateSeparatorView)
        
        containerView.addSubview(descriptionLable)
        containerView.addSubview(descriptionTextView)
        
        containerView.addSubview(mediaTitleLable)
        containerView.addSubview(ImageContainer)
        
            ImageContainer.addSubview(imageViewOne)
            ImageContainer.addSubview(imageViewTwo)
            ImageContainer.addSubview(imageViewThree)
        
        containerView.addSubview(editServicePackageButton)
        
        containerView.addSubview(uploadMediaButton)
        
        
        nameTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        nameTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        
        nameSeparatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -40 ).isActive = true
        nameSeparatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4).isActive = true
        profileImageView.topAnchor.constraint(equalTo: nameSeparatorView.bottomAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4).isActive = true
        
        plusImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        plusImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        plusImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -8).isActive = true
        plusImageView.rightAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: -8).isActive = true
        
        editAvailabilityButton.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 0).isActive = true
        editAvailabilityButton.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16).isActive = true
        editAvailabilityButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        editAvailabilityButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        
        addressTextField.topAnchor.constraint(equalTo: editAvailabilityButton.bottomAnchor, constant: 6).isActive = true
        addressTextField.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16).isActive = true
        addressTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        
        addresSeparatorView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 0).isActive = true
        addresSeparatorView.leftAnchor.constraint(equalTo: addressTextField.leftAnchor).isActive = true
        addresSeparatorView.rightAnchor.constraint(equalTo: addressTextField.rightAnchor).isActive = true
        addresSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        rateLable.topAnchor.constraint(equalTo: addresSeparatorView.bottomAnchor, constant: 10).isActive = true
        rateLable.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        rateLable.widthAnchor.constraint(equalTo: rateLable.widthAnchor ).isActive = true
        
        rateTextField.topAnchor.constraint(equalTo: addresSeparatorView.bottomAnchor, constant: 10).isActive = true
        rateTextField.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16).isActive = true
        rateTextField.rightAnchor.constraint(equalTo: rateLable.leftAnchor, constant: -2).isActive = true
        
        rateSeparatorView.topAnchor.constraint(equalTo: rateTextField.bottomAnchor,constant: 6).isActive = true
        rateSeparatorView.leftAnchor.constraint(equalTo: rateTextField.leftAnchor).isActive = true
        rateSeparatorView.rightAnchor.constraint(equalTo: rateLable.rightAnchor).isActive = true
        rateSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        descriptionLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        descriptionLable.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16).isActive = true
        descriptionLable.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionTextView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 6).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        mediaTitleLable.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        mediaTitleLable.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16).isActive = true

        ImageContainer.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        ImageContainer.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        ImageContainer.topAnchor.constraint(equalTo: mediaTitleLable.bottomAnchor, constant: 8).isActive = true
        ImageContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        uploadMediaButton.centerXAnchor.constraint(equalTo: ImageContainer.centerXAnchor).isActive = true
        uploadMediaButton.centerYAnchor.constraint(equalTo: ImageContainer.centerYAnchor).isActive = true
        

                imageViewOne.topAnchor.constraint(equalTo: ImageContainer.topAnchor, constant: 0).isActive = true
                imageViewOne.bottomAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 0).isActive = true
                imageViewOne.widthAnchor.constraint(equalTo: ImageContainer.widthAnchor, multiplier: 1/3).isActive = true
                imageViewOne.leftAnchor.constraint(equalTo: ImageContainer.leftAnchor, constant: 0).isActive = true
                
                imageViewTwo.topAnchor.constraint(equalTo: ImageContainer.topAnchor, constant: 0).isActive = true
                imageViewTwo.bottomAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 0).isActive = true
                imageViewTwo.widthAnchor.constraint(equalTo: ImageContainer.widthAnchor, multiplier: 1/3).isActive = true
                imageViewTwo.leftAnchor.constraint(equalTo: imageViewOne.rightAnchor, constant: 10).isActive = true

                imageViewThree.topAnchor.constraint(equalTo: ImageContainer.topAnchor, constant: 0).isActive = true
                imageViewThree.bottomAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 0).isActive = true
                imageViewThree.widthAnchor.constraint(equalTo: ImageContainer.widthAnchor, multiplier: 1).isActive = true
//                imageViewThree.leftAnchor.constraint(equalTo: imageViewTwo.rightAnchor, constant: 5).isActive = true
                imageViewThree.leftAnchor.constraint(equalTo: ImageContainer.leftAnchor, constant: 0).isActive = true
        
        editServicePackageButton.topAnchor.constraint(equalTo: ImageContainer.bottomAnchor, constant: 32).isActive = true
        editServicePackageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        editServicePackageButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32).isActive = true
        editServicePackageButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -32).isActive = true
        
        
        
        
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

        descriptionTextView.inputAccessoryView = doneToolbar
        
        rateTextField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }

    
    
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {

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

        self.descriptionTextView.text = user.bio
        
        self.rateTextField.text = user.rate
        
        if user.address != nil {
            
        self.addressTextField.setTitle(user.address, for: .normal)

            
        }
        
        
        if let profileImageUrl = user.profileImageUrl {
            
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
            
        }
        
    }

}

@available(iOS 13.4, *)
extension EditPhotographerProfileViewController: AddAddressDelegate {
    
    
    func addAddress(shortAddress: String, address: String, latitude: Double, longitude: Double) {
        self.dismiss(animated: true, completion: nil)
        self.longitude = longitude
        self.latitude = latitude
        self.address = address
        self.shortAddress = shortAddress
        
    }
}


