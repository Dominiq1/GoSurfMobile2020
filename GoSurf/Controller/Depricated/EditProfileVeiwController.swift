//
//  EditProfileVeiwController.swift
//  GoSurf
//
//  Created by Pop on 09/10/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EditProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUser()
        }
        
    }
    
    
    func fetchUser() {
        
                guard let uid = Auth.auth().currentUser?.uid else {
                    //for some reason uid = nil
                    return
                }
                
                Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        self.navigationItem.title = dictionary["name"] as? String
        
                        let user = User(dictionary: dictionary)
                        self.setupView(user)
                        
                        }
                    }, withCancel: nil)
        }
    
    
    func setupView(_ user: User) {

            
            let titleView = UIView()
            titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
    //        titleView.backgroundColor = UIColor.redColor()
            
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            titleView.addSubview(containerView)
            
            let profileImageView = UIImageView()
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 20
            profileImageView.clipsToBounds = true
            if let profileImageUrl = user.profileImageUrl {
                profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
            }

            let nameLabel = UILabel()
            
            containerView.addSubview(nameLabel)
            nameLabel.text = user.name
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
            
            containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
            containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
            
        self.view.addSubview(titleView)

        }
        

    
    @objc func handleLogout() {
           
           do {
               try Auth.auth().signOut()
           } catch let logoutError {
               print(logoutError)
           }
           
           let loginController = LoginController()
           loginController.modalPresentationStyle = .fullScreen
           present(loginController, animated: true, completion: nil)
       }
    
    
}
