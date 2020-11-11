//
//  NewProfileViewController.swift
//  GoSurf
//
//  Created by Pop on 20/06/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//


import UIKit
import Firebase

@available(iOS 13.4, *)
class NewProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
    }

    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Profile"

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        view.backgroundColor = .white
        
        setupNavBar()
        view.addSubview(loadingLable)
        loadingLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingLable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    let loadingLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.textColor = UIColor(r: 22, g: 128, b: 210)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Loading..."
        return lable
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchUser()
        
    }
    
    @objc func dismissKeyboard() {
        
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
    
    
    func setupNavBar() {

        self.navigationController?.navigationBar.tintColor = UIColor.white
        
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
    
    @objc func opneEditInstructorViewController() {
        
    }
    
    
    
    func setupData(_ user: User) {
        

        if user.type == "User" {
            
            let viewController = ProfileViewController()
            viewController.hidesBottomBarWhenPushed = false
            viewController.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(viewController, animated: true)

        } else {
            
            if user.businessType == "Instructor" || user.businessType == "Coach" {
                
                let instructorViewController = InstructorProfileViewController()
                instructorViewController.name = user.name
                instructorViewController.email = user.email
                instructorViewController.navigationItem.hidesBackButton = true
                instructorViewController.hidesBottomBarWhenPushed = false
                instructorViewController.checker = 1
                navigationController?.pushViewController(instructorViewController, animated: true)
                
            } else if user.businessType == "Camp" {
                
                let viewController = CampProfileViewController()
                viewController.name = user.name
                viewController.email = user.email
                viewController.hidesBottomBarWhenPushed = false
                viewController.navigationItem.hidesBackButton = true
                viewController.checker = 1
                navigationController?.pushViewController(viewController, animated: true)
                
                
            } else if user.businessType == "Photographer" || user.businessType == "Videographer" {
                
                let viewController = PhotographerProfileViewController()
                viewController.name = user.name
                viewController.email = user.email
                viewController.hidesBottomBarWhenPushed = false
                viewController.navigationItem.hidesBackButton = true
                viewController.checker = 1
                navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        }
        
    }

}



