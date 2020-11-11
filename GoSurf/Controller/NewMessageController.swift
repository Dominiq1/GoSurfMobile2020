//
//  NewMessageController.swift
//  GoSurf
//
//  Created by Pop on 18/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.


import UIKit
import Firebase

@available(iOS 13.4, *)
class NewMessageController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    

// new code
    
        let cellId = "cellId"
        
        var users = [User]()
        
        var filteredUsers = [User]()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            fetchUser()
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
            navigationItem.searchController = searchController
            
            tableView.register(UserCell.self, forCellReuseIdentifier: cellId)

        }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterUsersForSearch(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterUsersForSearch(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func filterUsersForSearch(searchText: String, scope: String = "All")  {
        filteredUsers = users.filter({ (user: User) -> Bool in
            
            let doesTypeMatch = ( scope == "All" ) || (user.businessType == scope)
            
            if isSearchBarEmpty() {
                return doesTypeMatch
            } else {
                return doesTypeMatch && (user.name?.lowercased().contains(searchText.lowercased()))!
            }
            
        })
        
        tableView.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text!.isEmpty
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
    }
    
    lazy var searchController: UISearchController = {
            let s = UISearchController(searchResultsController: nil)
            s.searchResultsUpdater = self
            s.obscuresBackgroundDuringPresentation = false
            s.searchBar.placeholder = "Search"
            s.searchBar.sizeToFit()
            s.searchBar.searchBarStyle = .prominent
        s.searchBar.scopeButtonTitles = ["All","Camp","Coach","Instructor","Photographer","Videographer" ]
            s.searchBar.delegate = self
            return s
        }()
        
    func fetchUser() {
        
            let uid = Auth.auth().currentUser!.uid
            
            Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let user = User(dictionary: dictionary)
                    user.id = snapshot.key
                    
                    if user.type == "Business" && user.id != uid {
                    self.users.append(user)
                    }
                    
                    //this will crash because of background thread, so lets use dispatch_async to fix
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                    
    //                user.name = dictionary["name"]
                }
                
                }, withCancel: nil)
        }
        
        @objc func handleCancel() {
            dismiss(animated: true, completion: nil)
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if isFiltering() {
                return filteredUsers.count
            } else {
                return users.count
            }
            
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
            
            let user: User
            
            if isFiltering() {
                user = filteredUsers[indexPath.row]
            } else {
                user = users[indexPath.row]
            }
            
//            let user = users[indexPath.row]
            cell.nameLable.text = user.name
            cell.detailLable.text = user.email
            cell.timeLabel.text = user.businessType
            cell.detailLable.isHidden = true
            
            if let profileImageUrl = user.profileImageUrl {
                cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
            }
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 72
        }
        
        var messagesController: ChatViewController?
    
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            let user: User
            
            if isFiltering() {
                user = filteredUsers[indexPath.row]
            } else {
                user = users[indexPath.row]
            }
            
            self.searchController.dismiss(animated: true) {
                
                self.dismiss(animated: true) {
                    
                print("Dismiss completed")
                self.messagesController?.showChatControllerForUser(user)
                    
                }
            }
        }
}



