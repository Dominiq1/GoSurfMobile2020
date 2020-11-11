//
//  CreatePostViewController.swift
//  GoSurf
//
//  Created by Pop on 12/10/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var email = String()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.title = "Upload Media"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(handlePost))
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        fetchUser()
        setupViews()
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePost() {
        

        
        if thumbnailImageView.image != nil {
            
            let values = [    "description" : descriptionLable.text as String,
                              "postedBy": self.email ] as [String : Any]
            print(values)
            _ = Post(image: thumbnailImageView.image!, dictionary: values as [String : AnyObject] ).save()
            
            self.dismiss(animated: true, completion: nil)
            
        }

        
    }
    
    lazy var imageWidth = self.view.frame.width
    lazy var imageHeight = self.view.frame.width
    lazy var imageSize = CGSize(width:  imageWidth, height: ((imageHeight - 16 - 16)*(9/19) + 32 ))

    
        lazy var thumbnailImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            imageView.contentMode = .scaleAspectFill
    //        imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            imageView.frame.size = imageSize
            imageView.layer.masksToBounds = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
//            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
            return imageView
        }()
        

        let descriptionLable: UITextView = {
            let lable = UITextView()
            lable.translatesAutoresizingMaskIntoConstraints = true
            lable.isEditable = true
            lable.isScrollEnabled = false
            lable.font = UIFont.systemFont(ofSize: 18)
            lable.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            lable.backgroundColor = #colorLiteral(red: 0.9641213613, green: 0.9641213613, blue: 0.9641213613, alpha: 1)
            lable.layer.cornerRadius = 5
            return lable
        }()
    
    lazy var improvementResourcesSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Improvement", "Resources"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.backgroundColor = .gray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let descriptionBackground: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return view
        
    }()
        
    
    
    let descriptionTitleLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        lable.text = "Description (Optional)"
        return lable
    }()
    
    @objc func handleSelectProfileImageView() {
        
        print("works")
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
            thumbnailImageView.image = selectedImage
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
        
        

        
        func setupViews() {
            
            view.addSubview(thumbnailImageView)

            view.addSubview(descriptionLable)
            view.addSubview(descriptionTitleLable)
            view.addSubview(descriptionBackground)

            
            view.addConstraintsWithFormat(format:  "H:|-16-[v0]-16-|", views: thumbnailImageView)
            view.addConstraintsWithFormat(format: "V:|-64-[v0]-16-[v1]-8-[v2][v3]", views: thumbnailImageView,descriptionTitleLable,descriptionLable,descriptionBackground)
            view.addConstraintsWithFormat(format:  "H:|-12-[v0]-12-|", views: descriptionLable)
            view.addConstraintsWithFormat(format:  "H:|-16-[v0]-16-|", views: descriptionTitleLable)

            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            descriptionLable.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
            descriptionBackground.bottomAnchor.constraint(equalTo: descriptionLable.bottomAnchor).isActive = true
               
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
        
        self.email = user.email!
        
    }
}
