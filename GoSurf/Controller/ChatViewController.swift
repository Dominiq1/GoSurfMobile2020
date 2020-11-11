//
//  MessagesController.swift
//  GoSurf
//
//  Created by Pop on 30/09/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import UIKit
import Firebase

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


@available(iOS 13.4, *)
class ChatViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let cellId = "cellId"
    

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.tintColor = UIColor.white

        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        // adding search bar
        navigationItem.searchController = searchController
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(r: 22, g: 128, b: 199)
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
//        observeMessages()
        checkIfUserIsLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // search bar controller
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = "Search"
        s.searchBar.sizeToFit()
        if #available(iOS 13.0, *) {
            s.searchBar.searchTextField.backgroundColor = .white
        }
//        s.searchBar.searchBarStyle = .prominent
        s.searchBar.showsScopeBar = false
        s.searchBar.delegate = self
        return s
    }()
    
    // when user inputs text in search bar
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterMessagesForSearch(searchText: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterMessagesForSearch(searchText: searchBar.text!)
    }
    
    func filterMessagesForSearch(searchText: String) {
        filteredMessage = messages.filter({ (message: Message) -> Bool in
            
            if isSearchBarEmpty() {
                return true
            } else {
                return (message.toName?.lowercased().contains(searchText.lowercased()))!
            }
            
        })
        
        tableView.reloadData()
        
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text!.isEmpty
    }
    
    func isFiltering() -> Bool {
        _ = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty())
    }

    
    func setupNames() {
        
        for message in messages {
            
            if let id = message.chatPartnerId() {
                
            let ref = Database.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                     message.toName = dictionary["name"] as? String
                    

                }
                
                }, withCancel: nil)
            }
        }
    }
    
    var messages = [Message]()
    
    var filteredMessage  = [Message]()
    var messagesDictionary = [String: Message]()
    
    func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let userId = snapshot.key
            
            print(uid, userId)
            
            
            print(userId)
            
            
            print(userId)
            Database.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                
                let messageId = snapshot.key
                self.fetchMessageWithMessageId(messageId)
                
                }, withCancel: nil)
            
            }, withCancel: nil)
    }
    
    
    
    
    fileprivate func fetchMessageWithMessageId(_ messageId: String) {
        let messagesReference = Database.database().reference().child("messages").child(messageId)
        
        messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message(dictionary: dictionary)
                
                if let chatPartnerId = message.chatPartnerId() {
                    self.messagesDictionary[chatPartnerId] = message
                }
                
                self.attemptReloadOfTable()
            }
            
            }, withCancel: nil)
    }
    
    
    
    
    fileprivate func attemptReloadOfTable() {
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    var timer: Timer?
    
    @objc func handleReloadTable() {
        self.messages = Array(self.messagesDictionary.values)
        self.messages.sort(by: { (message1, message2) -> Bool in
            
            return message1.timestamp?.int32Value > message2.timestamp?.int32Value
        })
        
        //this will crash because of background thread, so lets call this on dispatch_async main thread
        DispatchQueue.main.async(execute: {
            self.setupNames()
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredMessage.count
        } else {
            return messages.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let currentMessage: Message
        
        if isFiltering() {
            
            currentMessage = filteredMessage[indexPath.row]
            
        } else {
            
            currentMessage = messages[indexPath.row]
        }
        
//        let message = messages[indexPath.row]
        cell.message = currentMessage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentMessage: Message
        
        if isFiltering() {
            
            currentMessage = filteredMessage[indexPath.row]
            
        } else {
            
            currentMessage = messages[indexPath.row]
        }
        
        
        guard let chatPartnerId = currentMessage.chatPartnerId() else {
            return
        }
        
        let ref = Database.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let user = User(dictionary: dictionary)
            user.id = chatPartnerId
            self.showChatControllerForUser(user)
            
            }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        
        if isFiltering() {
            
            return UISwipeActionsConfiguration()
            
        } else {
            
            return UISwipeActionsConfiguration(actions: [delete])
        }
    
        
        
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Delete" ) { (action, view, completion) in
            
            let uid = Auth.auth().currentUser!.uid
            
            if self.messages[indexPath.row].toId == uid {
    
                let fromID = self.messages[indexPath.row].fromId
                
                let ref = Database.database().reference().child("user-messages").child(uid).child(fromID!)
                
                ref.removeValue { error,arg  in
                  if error != nil {
                    print("error \(String(describing: error))")
                  }
                }
                
            } else {

                let fromID = self.messages[indexPath.row].toId
                
                let ref = Database.database().reference().child("user-messages").child(uid).child(fromID!)
                
                ref.removeValue { error,arg  in
                  if error != nil {
                    print("error \(String(describing: error))")
                  }
                }
            }
            
            
            self.messages.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        
        
        return action
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController()
        newMessageController.messagesController = self
        newMessageController.title = "New Chat"
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    func fetchUserAndSetupNavBarTitle() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            //for some reason uid = nil
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
                  self.setupNavBar()
//            }
            
            }, withCancel: nil)
    }
    
    func setupNavBarWithUser(_ user: User) {
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()
        
        observeUserMessages()
        
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
        
        self.navigationItem.titleView = titleView

    }
    
    
        func setupNavBar() {
    
            self.title = "Chat"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            
            observeUserMessages()

            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add25"), style: .plain, target: self, action: #selector(handleNewMessage))
    
        }
    
    
    
    
    func showChatControllerForUser(_ user: User) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
        chatLogController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    @objc func handleLogout() {
           
           do {
               try Auth.auth().signOut()
           } catch let logoutError {
               print(logoutError)
           }
           
           let profileController = ProfileViewController()
           present(profileController, animated: true, completion: nil)
       }
    
    


}





