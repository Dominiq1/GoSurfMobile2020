//
//  StorefrontProfileViewController.swift
//  GoSurf
//
//  Created by Pop on 07/05/20.
//  Copyright © 2020 Piyush Makwana. All rights reserved.
//

import Foundation
import Firebase
import UIKit

@available(iOS 13.4, *)
class StorefrontProfileViewController: UITableViewController, UINavigationControllerDelegate {
    
    var user: User? {
        
        didSet {

            self.tableView.reloadData()
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .plain, target: self, action: #selector(openChatViewController))
            

        }
    }

    var name: String? {
        
        didSet {
            
            print(self.name!)
        }
    }
    
    var email: String? {
        
        didSet {
            
            print(self.email!)
            
            fetchUser(self.email!)
            
        }
    }
    
    func fetchUser(_ email : String) {
            
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let user = User(dictionary: dictionary)
                    user.id = snapshot.key
                    
                    if user.email == self.email {
                        
                        self.user = user
                        
                    }
                    
                    //this will crash because of background thread, so lets use dispatch_async to fix
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                    
    //                user.name = dictionary["name"]
                }
                
                }, withCancel: nil)
        }
    
    
    
        var placeText = "To sorry world an at do spoil along. Incommode he depending do frankness remainder to. Edward day almost active him friend thirty piqued. People as period twenty my extent as. Set was better abroad ham plenty secure had horses. Admiration has sir decisively excellence say everything inhabiting acceptance. Sooner settle add put you sudden him. "
    
    
    
    var tags = [[String]]()
    
    var count: Int = 0
    
    let cellID = "cellid"
    let cellID1  = "cellid1"
    let cellID3 = "cellid3"
    let cellID4 = "cellid4"
    let cellID5 = "cellid5"
    let cellID6 = "cellid6"

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = "Coaches"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .plain, target: self, action: #selector(openChatViewController))
        
        view.backgroundColor = .white
        
        setupNavBar()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tableView.register(ProfileFieldCell.self, forCellReuseIdentifier: cellID)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: cellID1)
        tableView.register(OfferingTableViewCell.self, forCellReuseIdentifier: cellID3)
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: cellID4)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: cellID5)
        tableView.register(ReviewTableViewCell.self,forCellReuseIdentifier: cellID6)
        
        tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    
    var messagesController: ChatViewController?
    
    @objc func openChatViewController() {
        
        print("chat button clicked ")
        
        guard let user = self.user else { return }
        
        
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
        chatLogController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chatLogController, animated: true)
        
        
    }
    
    
    
    
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupNavBar() {
        
        self.title = "Storefront Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
        
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID1, for: indexPath) as! ProfileTableViewCell
        
        cell.nameLable.text = self.user?.name
            
        cell.availabilityTitleLable.text = "Address"
            
        cell.availabilityLable.text = "City, State"
            
            cell.priceLable.text = user?.contact
        cell.priceLable.textColor = .blue
            
        cell.locationLable.text = "Website"
        cell.locationLable.textColor = .blue
            
            if self.user?.profileImageUrl != nil {
        
            if let profileImageUrl = self.user?.profileImageUrl {
                
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
                
            }
                
            }

            
            var n = 0
            for i in reviews {
                n = n + i.rating!
            }
            
            if reviews.count != 0 {
            cell.ratingsImageView.image = starImage(rating: Double(n/reviews.count))
            cell.reviewsLable.text = "based on " + String(reviews.count) + " Ratings"
            } else {
                cell.ratingsImageView.image = #imageLiteral(resourceName: "0stars")
                cell.reviewsLable.text = "No Ratings yet"
            }
        
        return cell
            
            
        } else if indexPath.row == 1 {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ProfileFieldCell

        cell.detailLable.text = placeText

        cell.nameLable.text = "About"
            
        cell.detailLable.text = self.user?.bio
        
        cell.selectionStyle = .none
            
        return cell
            
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ProfileFieldCell

            cell.detailLable.text = placeText

            cell.nameLable.text = "Opening Hours"
                
            cell.detailLable.text = " M-W: 8:00am - 5:00pm \n Th-F: 8:00am - 4:00pm \n Sat-Sun: 10:00am - 3:00pm "
            
            cell.selectionStyle = .none
            
            return cell
    
            
        } else if indexPath.row == 3 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellID4, for: indexPath) as! MediaTableViewCell
            cell.contentView.isUserInteractionEnabled = false
                
                return cell
        
                
        } else if indexPath.row  == 4 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellID6, for: indexPath) as! ReviewTableViewCell
                cell.button.addTarget(self, action: #selector(showReviewViewController), for: .touchUpInside)
                cell.reviews = self.reviews
                return cell
                
            } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID3, for: indexPath) as! OfferingTableViewCell
            
            return cell
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        fetchReviews()
    }
    
     @objc func showReviewViewController() {
         let newPostController = ReviewVeiwController()
         newPostController.reviewFor = self.email!
         let navController = UINavigationController(rootViewController: newPostController)
         present(navController, animated: true, completion: nil)
     }
     
     var reviews = [Review]()
     
     func fetchReviews() {
                 
                 Database.database().reference().child("reviews").observe(.childAdded, with: { (snapshot) in
     
                     if let dictionary = snapshot.value as? [String: AnyObject] {
                         let review = Review(dictionary: dictionary)
                         review.id = snapshot.key

     
                         if review.reviewFor == self.email! {
                         self.reviews.append(review)
                         }
     
                         //this will crash because of background thread, so lets use dispatch_async to fix
                         DispatchQueue.main.async(execute: {
                             self.tableView.reloadData()
    
                         })
     
         //                user.name = dictionary["name"]
                     }
     
                     }, withCancel: nil)
             }
     
     func starImage(rating: Double) -> UIImage {
         
         let roundedRating = round(rating)
         
         if roundedRating == 1 {
             return #imageLiteral(resourceName: "1stars")
             
         } else if roundedRating == 2 {
             return #imageLiteral(resourceName: "2stars")
             
         } else if roundedRating == 3 {
             return #imageLiteral(resourceName: "3stars")
                    
         } else if roundedRating == 4 {
             return #imageLiteral(resourceName: "4stars")
                    
         } else if roundedRating == 5 {
             return #imageLiteral(resourceName: "5stars")
                    
         } else {
             return #imageLiteral(resourceName: "0stars")
         }
     }
    
}
