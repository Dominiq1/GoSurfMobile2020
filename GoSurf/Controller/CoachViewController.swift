//
//  CoachViewController.swift
//  GoSurf
//
//  Created by Pop on 18/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Firebase

@available(iOS 13.4, *)
@available(iOS 13.4, *)
class CoachViewController: UITableViewController {
    
    var users = [User]()
    var reviews = [Review]()
    var filteredUsers = [User]()
    var isFiltering: Bool = false {
        
        didSet {
            
            if isFiltering {
                
            
                filteredUsers = users.filter({ (user: User) -> Bool in
                    

                if ((Int(user.rate ?? "0")!) >= minRate!) && ((Int(user.rate ?? "0")!) <= maxRate!)  {
                    
                    if userCoordinates != nil && distance != 0  {
                        
                        let userDistance = Int(userCoordinates.distance(from: CLLocation(latitude: ( user.latitude ?? 0 ), longitude: ( user.longitude ?? 0 ))))
                        
                        print("distance of user from \(String(describing: user.name)) is \(userDistance)")
                        
                        if userDistance <= distance!*1000 {
                            
                            return true
                            
                        }else {
                            
                            return false
                        }
                            
                    }else {
                        
                        return true
                    }
                    
                } else if maxRate! == 0 {
                    
                    if userCoordinates != nil && distance != 0 {
                        
                        let userDistance = Int(userCoordinates.distance(from: CLLocation(latitude: ( user.latitude ?? 0 ), longitude: ( user.longitude ?? 0 ))))
                        
                        print("distance of user from \(String(describing: user.name)) is \(userDistance)")
                        
                        if userDistance <= distance!*1000 {
                            
                            return true
                            
                        }else {
                            
                            return false
                        }
                        
                    }else {
                        
                        return true
                    }
                } else {
                    return false
                    }
                
            })
                
                self.tableView.reloadData()
                
            } else {
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    var maxRate: Int?
    var minRate: Int?
    var distance: Int?
    
    
    var type: String? {
        
        didSet {
            navigationItem.title = type! + "s"
        }
    }
    
    let cellID = "cellid"
    let profileCellID = "cellID2"

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = "Coaches"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        tableView.register(BusinessProfileTableViewCell.self, forCellReuseIdentifier: profileCellID)
        
        fetchUser()
        fetchBusinesses()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(openFilterViewController))
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    
    @objc func openFilterViewController() {
        let viewController = FilterViewController()
        viewController.delegate = self
        
        if userCoordinates == nil {
            viewController.isUserLocationAvailable = false
        } else {
            viewController.isUserLocationAvailable = true
        }
        
        let navController = UINavigationController(rootViewController: viewController)
        
        present(navController, animated: true, completion: nil)
        
    }
    

    var userCoordinates: CLLocation!
    
    
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
                //for some reason uid = nil
        return
            }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
    //                self.navigationItem.title = dictionary["name"] as? String
                    
                    let user = User(dictionary: dictionary)
                    if user.latitude != nil {
                    self.userCoordinates = CLLocation(latitude: user.latitude!, longitude: user.longitude!)
                    }
                }
                
                }, withCancel: nil)
        }
    


    
    func getAvgRatings() {
        
        
                     Database.database().reference().child("reviews").observe(.childAdded, with: { (snapshot) in
         
                         if let dictionary = snapshot.value as? [String: AnyObject] {
                             let review = Review(dictionary: dictionary)
                             review.id = snapshot.key
                                

                            self.reviews.append(review)

                            
                            DispatchQueue.main.async(execute: {

                                
                                for user in self.users {
                                    
                                    var reviewForUser = [Review]()
                                    
                                    for review in (self.reviews) {
                                        
                                        if review.reviewFor == user.email {
                                            
                                            reviewForUser.append(review)
                                            
                                        }
                                        
                                    }
                                
                                        var n: Double = 0
                                        for i in reviewForUser {
                                            n = n + Double(i.rating!)
                                        }
                                        
                                        if reviewForUser.count != 0 {
                                        
                                            user.starRating = Double(n/Double(reviewForUser.count))
                                            user.reviewCount = reviewForUser.count/self.users.count
                                            

                                        } else {
                                            
                                            user.starRating = 0
                                            user.reviewCount = 0
                                            
                                            }
                                    
                                }
                                        
                                        self.tableView.reloadData()
                                    
                            
                                    })

                         }
         
                         }, withCancel: nil)
        

    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredUsers.count
        }else {
            return users.count
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCellID, for: indexPath) as! BusinessProfileTableViewCell
        
        let user: User
        
        if isFiltering {
            user = filteredUsers[indexPath.row]
        }else {
            user = users[indexPath.row]
        }
        

        cell.nameLable.text = user.name
        
        if let address = user.address {
            cell.locationLable.text =  address
        }
        
        if let price = user.rate {
            cell.priceLable.text = "$" + price + "/hour"
            cell.priceLable.font = UIFont.boldSystemFont(ofSize: 16)
            cell.priceLable.textColor = .black
        } else {
            cell.priceLable.text = "Cost not mentioned"
            cell.priceLable.textColor = .gray
            cell.estimatedPriceLable.isHidden = true
        }
        
        if let count = user.reviewCount {
            
            cell.reviewsLable.text = "(\(String(count)))"
            
        }
        
        if let rating = user.starRating {
            
            cell.ratingsImageView.image = starImage(rating: rating)

            
            if rating == 0 {
                cell.ratingLable.text = "No Ratings"
                
            } else {
                cell.ratingLable.text = String(format: "%.1f", rating)
            }
        }
        
        
        
        if let profileImageUrl = user.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 72
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user: User
        
        if isFiltering {
            user = filteredUsers[indexPath.row]
        }else {
            user = users[indexPath.row]
        }
        

        switch String(type!) {
        case "Instructor":
            showInstructorProfileViewController(user.name! ,user.email! )
        case "Camp" :
            showCampProfileViewController( user.name! ,user.email!)
        case "Coach" :
            showInstructorProfileViewController(user.name! ,user.email! )
        case "Photographer":
            showPhotographerProfileViewController(user.name! ,user.email! )
        case "Videographer":
            showPhotographerProfileViewController(user.name! ,user.email! )
            
        default:
            print("Error while loading profile")
            
        }
    }
    
    func showStorefrontProfileViewController(_ name: String, _ email: String) {
        let instructorViewController = StorefrontProfileViewController()
        instructorViewController.name = name
        instructorViewController.email = email
        instructorViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(instructorViewController, animated: true)
    }
    
    func showRepairOrShaperProfileViewController(_ name: String, _ email: String) {
        let instructorViewController = ShaperAndRepairProfileViewController()
        instructorViewController.name = name
        instructorViewController.email = email
        instructorViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(instructorViewController, animated: true)
    }
    
    
    func showInstructorProfileViewController(_ name: String, _ email: String ) {
        let instructorViewController = InstructorProfileViewController()
        instructorViewController.name = name
        instructorViewController.email = email
        instructorViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(instructorViewController, animated: true)
    }
    
    func showCampProfileViewController(_ name: String, _ email: String ) {
        let viewController = CampProfileViewController()
        viewController.name = name
        viewController.email = email
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showPhotographerProfileViewController(_ name: String, _ email: String ) {
        let viewController = PhotographerProfileViewController()
        viewController.name = name
        viewController.email = email
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRentalProfileViewController(_ name: String, _ email: String ) {
        let viewController = RentalProfileViewController()
        viewController.name = name
        viewController.email = email
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func fetchBusinesses() {
                
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let user = User(dictionary: dictionary)
                        user.id = snapshot.key
                        
                        if self.type == "Instructor" {
                            
                            if user.businessType == "Instructor" || user.businessType == "Coach" {
                                
                                self.users.append(user)
                                
                                self.getAvgRatings()

                                
                            }
                            
                            
                        } else if user.businessType == self.type {
                            
                            self.users.append(user)
                            
                            self.getAvgRatings()

                            
                        }
                        
    
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

@available(iOS 13.4, *)
extension CoachViewController: filterDelegate {
    
    func filterBusinesses(minRate: Int, maxRate: Int, distance: Int, enabled: Bool) {
        self.dismiss(animated: true, completion: nil)
        
        self.minRate = minRate
        self.maxRate = maxRate
        self.distance = distance
        self.isFiltering = enabled
        
        if enabled {
            print("Applying filter with values - minRate: \(minRate), maxRate: \(maxRate), distance: \(distance)")
        } else {
            print("Filter cleared")
        }
    }
    
    

}

