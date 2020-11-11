//
//  ShellProfileViewController.swift
//  GoSurf
//
//  Created by Piyush on 22/07/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Firebase
import UIKit
import SafariServices

@available(iOS 13.4, *)
@available(iOS 13.4, *)
@available(iOS 13.4, *)
class ShellfileViewController: UITableViewController {

    let shellHeadCellID = "shellHeadID"
    let shellEntriesCellID  = "shellEntrieID"
    let shellSeperatorCellID = "shellSeperatorID"
    let shellVersionCellID = "shellVersionID"
    
    var currentUser: User?
    var profileImageURL: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    
    var entriesTitle = ["Help","Privacy Policy","Terms Of Use","Report A Technical Problem"]
    var entriesURL = ["https://gosurfsd.com/go-surf-support/","https://gosurfsd.com/privacy-policy/","https://gosurfsd.com/terms-of-use/","https://gosurfsd.com/reporting-a-technical-problem/"]
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white


        tableView.register(ShellEntryTableViewCell.self, forCellReuseIdentifier: shellEntriesCellID)
        tableView.register(SeperatorTableViewCell.self, forCellReuseIdentifier: shellSeperatorCellID)
        tableView.register(ProfilePhotoTableViewCell.self, forCellReuseIdentifier: shellHeadCellID)
        tableView.register(VersionNameTableViewCell.self, forCellReuseIdentifier: shellVersionCellID)

        tableView.separatorStyle = .none
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "You"
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        fetchUser()
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    @objc func openMapViewController() {
        
        let mapController = MapViewController()
        mapController.fromProfile = true
        let navController = UINavigationController(rootViewController: mapController)
        present(navController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID1, for: indexPath) as! ProfileTableViewCell
        
        if indexPath.row == 0 {
            //ProfilePhotoCell
            let cell = tableView.dequeueReusableCell(withIdentifier: shellHeadCellID, for: indexPath) as! ProfilePhotoTableViewCell
            
            if let imageURL = profileImageURL {
                
                cell.profileImageView.loadImageUsingCacheWithUrlString(imageURL)
                
            }
            
            cell.isUserInteractionEnabled = false
            
            return cell
        
        
        } else if indexPath.row == 1 {
            //SeperatorCell
            let cell = tableView.dequeueReusableCell(withIdentifier: shellSeperatorCellID, for: indexPath) as! SeperatorTableViewCell
            
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: shellEntriesCellID, for: indexPath) as! ShellEntryTableViewCell
            
            cell.titleLable.text = "Profile"
            
            return cell
            
            
        } else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: shellEntriesCellID, for: indexPath) as! ShellEntryTableViewCell
            
            cell.titleLable.text = "Upload Media"
            
            return cell
            
            
        } else if indexPath.row == 4 {
            //SeperatorCell
            let cell = tableView.dequeueReusableCell(withIdentifier: shellSeperatorCellID, for: indexPath) as! SeperatorTableViewCell
            
            cell.isUserInteractionEnabled = true
            
            return cell
            
            
        } else if indexPath.row < 9 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: shellEntriesCellID, for: indexPath) as! ShellEntryTableViewCell
            
            cell.titleLable.text = entriesTitle[indexPath.row - 5]
            
            return cell
            
        } else if indexPath.row == 9 {
            // Log-Out/Users/piyush/Desktop/GoSurf-Mobile/GoSurf/Model/Review.swift
            
            let cell = tableView.dequeueReusableCell(withIdentifier: shellEntriesCellID, for: indexPath) as! ShellEntryTableViewCell
            
            cell.titleLable.text = "Log Out"
            
            cell.arrowImageView.isHidden = true
            
            return cell

        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: shellVersionCellID, for: indexPath) as! VersionNameTableViewCell
            cell.isUserInteractionEnabled = false
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 2 {
            if let user = currentUser {
                
                openProfileViewController(user)
                
            }
        } else if indexPath.row == 3 {
            
            let viewController = CreatePostViewController()
            let vc = UINavigationController(rootViewController: viewController)
            present(vc, animated: true, completion: nil)

            
        } else if indexPath.row >= 5 && indexPath.row <= 8 {
            
            showSafariVC(for: entriesURL[indexPath.row - 5])
            
        } else if indexPath.row == 9 {
            
            handleSignOut()
        }
            
        
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

    
    
    func openProfileViewController(_ user: User) {
        

        if user.type == "User" {
            
            let viewController = ProfileViewController()
            viewController.hidesBottomBarWhenPushed = false
            viewController.navigationItem.hidesBackButton = false
            navigationController?.pushViewController(viewController, animated: true)

        } else {
            
            if user.businessType == "Instructor" || user.businessType == "Coach" {
                
                let instructorViewController = InstructorProfileViewController()
                instructorViewController.name = user.name
                instructorViewController.email = user.email
                instructorViewController.navigationItem.hidesBackButton = false
                instructorViewController.hidesBottomBarWhenPushed = false
                instructorViewController.checker = 1
                navigationController?.pushViewController(instructorViewController, animated: true)
                
            } else if user.businessType == "Camp" {
                
                let viewController = CampProfileViewController()
                viewController.name = user.name
                viewController.email = user.email
                viewController.hidesBottomBarWhenPushed = false
                viewController.navigationItem.hidesBackButton = false
                viewController.checker = 1
                navigationController?.pushViewController(viewController, animated: true)
                
                
            } else if user.businessType == "Photographer" || user.businessType == "Videographer" {
                
                let viewController = PhotographerProfileViewController()
                viewController.name = user.name
                viewController.email = user.email
                viewController.hidesBottomBarWhenPushed = false
                viewController.navigationItem.hidesBackButton = false
                viewController.checker = 1
                navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        }
        
    }
    
    func showSafariVC(for url: String) {
        guard let siteURL = URL(string: url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: siteURL)
        present(safariVC, animated: true)
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
                    self.setupProfilePhoto(user)
                }
                
                }, withCancel: nil)
        }
    
    
    func setupProfilePhoto(_ user: User) {
        
        self.currentUser = user
        
        if let profileImageUrl = user.profileImageUrl {
            
            self.profileImageURL = profileImageUrl
            
        }
        
    }
    
   func handleSignOut(){
    
    let alert = UIAlertController(title: "Log Out", message: "Are you sure you wnat to Logot ?", preferredStyle: .alert)
    
    
    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
        (action) in
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        self.present(loginController, animated: true, completion: nil)
        
    }))
    
    alert.addAction(UIAlertAction(title: "No", style: .default, handler: {
        (action) in
        
        
    }))
    
    self.present(alert,animated: true)
    
    }
    
}

